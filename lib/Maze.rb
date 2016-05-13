require "./lib/Wall"

class Maze

    attr_reader :walls

    def initialize
        @walls = Array.new
        # outer walls
        @walls.push Wall.new 0,0,12,0
        @walls.push Wall.new 12,0,12,6
        @walls.push Wall.new 12,6,0,6
        @walls.push Wall.new 0,6,0,0

        @walls.push Wall.new 0,1,2,1
        @walls.push Wall.new 2,1,2,2
        @walls.push Wall.new 2,2,4,2
        @walls.push Wall.new 4,2,4,1
        @walls.push Wall.new 4,1,3,1

        @walls.push Wall.new 0,4,1,4
        @walls.push Wall.new 1,4,1,2

        @walls.push Wall.new 1,6,1,5
        @walls.push Wall.new 1,5,3,5

        @walls.push Wall.new 4,6,4,3
        @walls.push Wall.new 5,1,5,3
        @walls.push Wall.new 5,3,3,3
        @walls.push Wall.new 3,3,3,4
        @walls.push Wall.new 3,4,2,4
        @walls.push Wall.new 2,4,2,3

        @walls.push Wall.new 5,6,5,5
        @walls.push Wall.new 5,5,7,5

        @walls.push Wall.new 8,6,8,4
        @walls.push Wall.new 8,4,7,4

        @walls.push Wall.new 10,6,10,4

        @walls.push Wall.new 10,2,12,2

        @walls.push Wall.new 11,0,11,1
        @walls.push Wall.new 11,1,10,1

        @walls.push Wall.new 6,0,6,2
        @walls.push Wall.new 6,2,8,2
        @walls.push Wall.new 8,2,8,1
        @walls.push Wall.new 8,1,7,1

        @walls.push Wall.new 9,0,9,5
        @walls.push Wall.new 11,5,11,3
        @walls.push Wall.new 11,3,6,3
        @walls.push Wall.new 6,3,6,4
        @walls.push Wall.new 6,4,5,4

    end
end
