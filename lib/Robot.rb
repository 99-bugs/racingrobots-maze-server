require './lib/Rocket'
require 'Geometry/Point'

class Robot

    Point = Geometry::Point

    attr_reader :health, :size, :world, :name, :position, :heading
    @power = 0

    def initialize name = "Unnamed Robot", world = nil
        @world = world
        @name = name
        @size = 0.5
        @health = 100
        updatePosition Point[0,0], 0
    end

    def update
        power = power + 1
    end

    def shoot
        @power = 0
        rocket = Rocket.new self
    end

    def hit! rocket
        @health -= rocket.power
    end

    def updatePosition position, heading = nil
        @position = position
        @heading = heading unless heading.nil?
    end

end
