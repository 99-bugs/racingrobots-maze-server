

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
        robotsInRange = @world.robots.select do |id, robot|
            hit? robot unless robot == @owner
        end

        #TODO calculate closest target to take the punch, we are not shooting "frickin' Lasers"
        robot = robotsInRange.values[0]
        robot.hit! self

    end

    def endPositioin
        x = @x + (@range * Math::cos(@a))
        y = @y - (@range * Math::sin(@a))
        {x: x, y: y}
    end

    def hit? robot
        minimumDistanceToPoint(robot.getPosition) - robot.size < 0
    end

    # http://paulbourke.net/geometry/pointlineplane/
    def minimumDistanceToPoint point
        endpoint = endPositioin()
        x1, y1 = @x, @y
        x2, y2 = endpoint.values
        x3, y3 = point[:x].to_f, point[:y].to_f

        #calculate closest point to the line at the tangent which passes trhough to point
        numerator = (((x3 - x1) * (x2 - x1)) + ((y3 - y1) * (y2 - y1)))
        denominator = ((x2 - x1) ** 2 + (y2 - y1) ** 2)
        u = numerator / denominator

        # intersection point must be on the line
        u = [u, 1].min
        u = [u, 0].max

        #calculate point of intersection of the tangent
        x = x1 + u * (x2 - x1)
        y = y1 - u * (y2 - y1)

        #calculate distance between intersection point and point
        Math::sqrt((x3 - x) ** 2 + (y3 - y) ** 2)
    end

end
