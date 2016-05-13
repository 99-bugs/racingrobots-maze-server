require './lib/Point'

class Wall

    @start = nil
    @end = nil

    def initialize x1, y1, x2, y2
        @start = Point.new x1, y1
        @end = Point.new x2, y2
    end

    def to_hash
        {start: {x: @start.x, y: @start.y}, end: {x: @end.x, y: @end.y}}
    end
end
