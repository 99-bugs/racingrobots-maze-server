
require './lib/Maze'
require './lib/Robot'


class Server

    attr_accessor :robots

    def initialize
        @maze = Maze.new
    end

    def setRobots robots
        @robots = Hash.new
        robots.each do |id, name|
            @robots[id] = Robot.new name, self
        end
    end

end
