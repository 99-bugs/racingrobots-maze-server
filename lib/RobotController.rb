require 'json'
require './lib/CommandParser'


class RobotController

    def initialize server
        @server = server
        @commandParser = CommandParser.new @server
    end

    def parseCommand command
        response = JSON.generate({status: "ok"})
        begin
            robot, command = @commandParser.parse command
            execute robot, command
        rescue JSON::ParserError
            response = JSON.generate({status: "error",message: "command not a valid JSON string"})
        rescue CommandError => e
            response = JSON.generate({status: "error", message: e.message})
        end
        response
    end

    def execute robot, command
        if robot.alive?
            case command
            when "forward" then
                robot.forward
            when "backward" then
                robot.backward
            when "left" then
                robot.turnleft
            when "right" then
                robot.turnright
            when "shoot", "rocket", "bazooka", "a" then
                robot.shoot
            when "b" then
                robot.shoot
            when "x" then
                robot.shoot
            else
                raise CommandError.new "unknown command"
            end
        end
    end
end
