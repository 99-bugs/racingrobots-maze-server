require 'geometry'

class GeometryHelper

    include Geometry

    def self.distance first, last
        Math::sqrt((first.x.to_f - last.x.to_f) ** 2 + (first.y.to_f - last.y.to_f) ** 2)
    end

    # http://paulbourke.net/geometry/pointlineplane/
    def self.minimumDistanceLineToPoint line, point
        x1, y1 = line.first.x.to_f, line.first.y.to_f
        x2, y2 = line.last.x.to_f, line.last.y.to_f
        x3, y3 = point.x.to_f, point.y.to_f

        #calculate closest point to the line at the tangent which passes trhough to point
        numerator = (((x3 - x1) * (x2 - x1)) + ((y3 - y1) * (y2 - y1)))
        denominator = ((x2 - x1) ** 2 + (y2 - y1) ** 2)

	return 0.0 if denominator == 0

        u = numerator / denominator

        # intersection point must be on the line
        u = [u, 1].min
        u = [u, 0].max

        #calculate point of intersection of the tangent
        x = x1 + u * (x2 - x1)
        y = y1 + u * (y2 - y1)
        intersection = Point[x, y]

        #calculate distance between intersection point and point
        self::distance(point, intersection)
    end

    # http://paulbourke.net/geometry/pointlineplane/
    def self.getLineIntersection line1, line2
        x1, y1 = line1.first.x.to_f, line1.first.y.to_f
        x2, y2 = line1.last.x.to_f,  line1.last.y.to_f
        x3, y3 = line2.first.x.to_f, line2.first.y.to_f
        x4, y4 = line2.last.x.to_f,  line2.last.y.to_f

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
            return Point[x,y]
        else
            #line segments do not cross between start and end points
            return false
        end
    end
end
