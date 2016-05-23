
require './lib/Maze'
require './lib/Robot'
require './lib/RobotState/Server'
require './lib/RobotController'

class Server

    attr_accessor :robots, :maze, :robotController

    def initialize host = "localhost", port = 0
        @maze = Maze.new
        @robotController = RobotController.new self
        @tcpServer = RobotState::Server.new @robotController, host, port
    end

    def serial= serial
      @serial = serial
    end

    def setRobots robots
        @robots = Hash.new
        robots.each do |id, config|
            robot = Robot.new config["name"], self
            address = config["address"].split "-"
            address.map! { |e| e.to_i 16  }
            robot.set_xbee_address = address
            robot.set_xbee_port = @serial unless @serial.nil?
            @robots[id] = robot
        end
    end

    def close
        @tcpServer.close
    end

    def port
        @tcpServer.port
    end
end
