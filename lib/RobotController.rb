require 'json'


class RobotController

    def initialize server
        @server = server
    end

    def parseCommand command
        response = JSON.generate({status: "ok"})
        begin
            # try to parse the JSON string
            command = JSON.parse(command)

            # command should contain robotid and command options
            raise "no robotid present" unless command.key? "robotid"
            raise "no command present" unless command.key? "command"

            robotid = command["robotid"].downcase
            robot =  @server.robots[robotid.to_sym]
            command = command["command"].downcase

            # robot should exist on the server
            raise "unknown robot" if robot.nil?

            execute robot, command
        rescue JSON::ParserError
            response = JSON.generate({status: "error",message: "command not a valid JSON string"})
        rescue Exception => e
            response = JSON.generate({status: "error", message: e.message})
        end

        return response
    end

    def execute robot, command
        if robot.alive?
            case command
            when "forward" then

            when "backward" then

            when "left" then

            when "right" then

            when "shoot", "rocket", "bazooka", "a" then
                robot.shoot
            when "b" then
                robot.shoot
            when "x" then
                robot.shoot
            else
                return raise "unknown command"
            end
        end
    end
end
