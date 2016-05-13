
class Geometry

    def self.distance startpoint, endpoint
        Math::sqrt((startpoint[:x] - endpoint[:x]) ** 2 + (startpoint[:y] - endpoint[:y]) ** 2)
    end

    # http://paulbourke.net/geometry/pointlineplane/
    def self.minimumDistanceLineToPoint linestart, lineend, point
        x1, y1 = linestart[:x], linestart[:y]
        x2, y2 = lineend[:x], lineend[:y]
        x3, y3 = point[:x], point[:y]

        #calculate closest point to the line at the tangent which passes trhough to point
        numerator = (((x3 - x1) * (x2 - x1)) + ((y3 - y1) * (y2 - y1)))
        denominator = ((x2 - x1) ** 2 + (y2 - y1) ** 2)
        u = numerator / denominator

        # intersection point must be on the line
        u = [u, 1].min
        u = [u, 0].max

        #calculate point of intersection of the tangent
        x = x1 + u * (x2 - x1)
        y = y1 + u * (y2 - y1)

        #calculate distance between intersection point and point
        self::distance({x: x3, y: y3}, {x: x, y: y})
    end

    # http://paulbourke.net/geometry/pointlineplane/
    def self.getLineIntersection line1, line2
        x1, y1 = line1[:start][:x], line1[:start][:y]
        x2, y2 = line1[:end][:x], line1[:end][:y]
        x3, y3 = line2[:start][:x], line2[:start][:y]
        x4, y4 = line2[:end][:x], line2[:end][:y]

        numeratorA  = ((x4 - x3) * (y1 - y3)) - ((y4 - y3) * (x1 - x3))
        numeratorB  = ((x2 - x1) * (y1 - y3)) - ((y2 - y1) * (x1 - x3))
        denominator = ((y4 - y3) * (x2 - x1)) - ((x4 - x3) * (y2 - y1))
        uA = numeratorA / denominator
        uB = numeratorB / denominator

        if denominator.zero?
            if uA.zero? and uB.zero?
                # lines are coincident
                return false
            else
                # lines are parallel
                return false
            end
        end

        if uA.between?(0,1) and uB.between?(0,1)
            x = x1 + uA * (x2 - x1)
            y = y1 + uA * (y2 - y1)
        else
            #line segments do not cross between start and end points
            return false
        end

        {x: x, y: y}
    end

end
