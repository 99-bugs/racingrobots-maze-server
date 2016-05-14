
require './lib/Maze'
require './lib/Robot'
require './lib/Remotes/Serial'
require './lib/Remotes/Xbee'


class Server

    attr_accessor :robots, :maze, :robotController

    def initialize
        @maze = Maze.new
        @robotController = RobotController.new self
        @remote = nil #xbee or serial
    end

    def setRobots robots
        @robots = Hash.new
        robots.each do |id, name|
            @robots[id] = Robot.new name, self
        end
    end



end
