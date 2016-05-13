require "./lib/Geometry"

class Rocket

    attr_reader :power

    def initialize owner, range = 5, power = 50
        @owner = owner
        owner_position = @owner.getPosition
        @world = owner.world
        @x = owner_position[:x].to_f
        @y = owner_position[:y].to_f
        @a = owner_position[:a].to_f
        @power = power.to_f
        @range = range.to_f

        checkCollisions if @world
    end

    def checkCollisions
        robot = getRobotCollision
        robot.hit! self unless robot.nil?
    end

    def getRobotCollision
        robotsInRange = @world.robots.select do |id, robot|
            hit? robot unless robot == @owner
        end

        id, robot = robotsInRange.min_by do |id, robot|
            position = robot.getPosition
            Geometry::distance({x: position[:x], y: position[:y]}, {x: @x, y: @y})
        end
        robot
    end

    def endPosition
        x = @x + (@range * Math::cos(@a))
        y = @y - (@range * Math::sin(@a))
        {x: x, y: y}
    end

    def hit? robot
        linestart = {x: @x, y:@y}
        lineend = endPosition
        point = robot.getPosition

        distance = Geometry::minimumDistanceLineToPoint(linestart, lineend, point)
        distance - robot.size < 0
    end



end
