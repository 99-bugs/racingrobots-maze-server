require './lib/Shots/Rocket'
require "./lib/Shots/Emp"
require "./lib/Shots/Shotgun"
require './lib/RemoteControl'
require 'geometry'

class Robot

    include Geometry
    include RemoteControl

    attr_reader :health, :size, :world, :name, :position, :heading, :shotsFired, :damage

    def initialize name = "Unnamed Robot", world = nil
        @world = world
        @name = name
        @size = 120 / 2 #radius = diameter / 2
        reset
        updatePosition Point[0,0], 0
        @lastshot = DateTime.now - 10
    end

    def shoot type = "rocket"
        if @lastshot + 5.0 < DateTime.now
            rocket = Shot.create type, self
            unless rocket.nil?
                @shotsFired += 1
                @lastshot = DateTime.now
                return @damage += rocket.damage
            end
        end
        0
    end

    def hit! shot
        health = @health
        @health -= shot.power
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
