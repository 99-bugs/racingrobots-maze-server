
class CommandError < StandardError
end

class CommandParser

    def initialize server
        @server = server
    end

    def parse command
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

        return robot, command
    end


end
