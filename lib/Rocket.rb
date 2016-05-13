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
        endPosition = endPosition()
        @destination_x, @destination_y = endPosition[:x], endPosition[:y]

        checkCollisions if @world
    end

    def checkCollisions
        limitShotUntilWall
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

    def limitShotUntilWall
        wallsInRange = @world.maze.walls.select do |wall|
            Geometry::getLineIntersection({
                    start: {x:@x, y: @y},
                    end:{x: @destination_x, y: @destination_y}
                }, wall.to_hash)
        end

        wall = wallsInRange.min_by do |wall|
            intersection = Geometry::getLineIntersection({
                    start: {x:@x, y: @y},
                    end:{x: @destination_x, y: @destination_y}
                }, wall.to_hash)
            Geometry::distance({x: intersection[:x], y: intersection[:y]}, {x: @x, y: @y})
        end

        intersection = Geometry::getLineIntersection({
                start: {x:@x, y: @y},
                end:{x: @destination_x, y: @destination_y}
            }, wall.to_hash)

        @destination_x , @destination_y = intersection[:x], intersection[:y]
    end

    def endPosition
        x = @x + (@range * Math::cos(@a))
        y = @y - (@range * Math::sin(@a))
        {x: x, y: y}
    end

    def hit? robot
        linestart = {x: @x, y:@y}
        lineend = {x: @destination_x, y: @destination_y}
        point = robot.getPosition

        distance = Geometry::minimumDistanceLineToPoint(linestart, lineend, point)
        distance - robot.size < 0
    end



end
