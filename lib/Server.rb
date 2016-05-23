
require './lib/Maze'
require './lib/Robot'
require './lib/RobotState/Server'
require './lib/Remotes/Serial'
require './lib/Remotes/Xbee'


class Server

    attr_accessor :robots, :maze, :robotController

    def initialize host = "localhost", port = 0
        @maze = Maze.new
        @robotController = RobotController.new self
        @remote = nil #xbee or serial
        @tcpServer = RobotState::Server.new @robotController, host, port
    end

    def setRobots robots
        @robots = Hash.new
        robots.each do |id, name|
            @robots[id] = Robot.new name, self
        end
    end

    def close
        @tcpServer.close
    end

    def port
        @tcpServer.port
    end
end
