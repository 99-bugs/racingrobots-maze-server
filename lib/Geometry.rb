
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

end
