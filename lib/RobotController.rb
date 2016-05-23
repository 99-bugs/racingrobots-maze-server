require 'json'
require './lib/CommandParser'
require 'geometry'


class RobotController

    include Geometry

    def initialize server
        @server = server
        @commandParser = CommandParser.new
        @commandParser.registerHandler('move', method(:moveHandler))
        @commandParser.registerHandler('shoot', method(:shootHandler))
        @commandParser.registerHandler('state', method(:stateUpdateHandler))
    end

    def parseCommand commandString
        begin
            @commandParser.parse commandString
            return JSON.generate({status: "ok"})
        rescue JSON::ParserError
            return JSON.generate({status: "error", message: "command not a valid JSON string"})
        rescue CommandError => ce
            return JSON.generate({status: "warning", warnings: ce.message})
        end
    end

    def moveHandler robotId, direction
        robot = getRobot robotId
        if robot.alive?
            case direction
                when "forward" then
                    robot.forward
                when "backward" then
                    robot.backward
                when "left" then
                    robot.turnleft
                when "right" then
                    robot.turnright
            end
        end
    end

    def shootHandler robotId, weapon
        robot = getRobot robotId
        if robot.alive?
            case weapon
                when "rocket", "bazooka" then
                    robot.shoot
                when "a", "b", "x" then
                    robot.shoot
            end
        end
    end

    def stateUpdateHandler robotId, state
        robot = getRobot robotId
        robot.updatePosition Point[state['x'], state['y']], state['angle']
    end

    def getRobot robotId
        robot =  @server.robots[robotId.to_sym]
        raise CommandError.new "unknown robot" if robot.nil?
        return robot
    end
end
