require './lib/Rocket'
require 'Geometry'

class Robot

    include Geometry

    attr_reader :health, :size, :world, :name, :position, :heading, :shotsFired, :damage
    @power = 0

    def initialize name = "Unnamed Robot", world = nil
        @world = world
        @name = name
        @size = 0.5
        reset
        updatePosition Point[0,0], 0
    end

    def update
        power = power + 1
    end

    def shoot
        @power = 0
        @shotsFired += 1
        rocket = Rocket.new self
        @damage += rocket.damage
    end

    def hit! rocket
        health = @health
        @health -= rocket.power
        @health = [@health, 0].max
        damage = health - @health
    end

    def updatePosition position, heading = nil
        @position = position
        @heading = heading unless heading.nil?
    end

    def reset
        @health = 100
        @shotsFired = 0
        @damage = 0
    end

    def dead?
        @health <= 0
    end

    def alive?
        not dead?
    end

end
