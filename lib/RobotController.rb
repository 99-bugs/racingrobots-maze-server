require 'json'


class RobotController
    class CommandError < StandardError
    end

    def initialize server
        @server = server
    end

    def parseCommand command
        response = JSON.generate({status: "ok"})
        begin
            # try to parse the JSON string
            command = JSON.parse(command)

            # command should contain robotid and command options
            raise CommandError.new "no robotid present" unless command.key? "robotid"
            raise CommandError.new "no command present" unless command.key? "command"

            robotid = command["robotid"].downcase
            robot =  @server.robots[robotid.to_sym]
            command = command["command"].downcase

            # robot should exist on the server
            raise CommandError.new "unknown robot" if robot.nil?

            execute robot, command
        rescue JSON::ParserError
            response = JSON.generate({status: "error",message: "command not a valid JSON string"})
        rescue CommandError => e
            response = JSON.generate({status: "error", message: e.message})
        end

        return response
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
