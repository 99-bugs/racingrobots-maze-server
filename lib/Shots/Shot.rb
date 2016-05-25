require "./lib/GeometryHelper"
require "geometry"


class Shot
    include Geometry

    attr_reader :damage, :power

    def initialize owner, range = 1000.0, power = 25.0
        @owner = owner
        @world = owner.world

        @power = power.to_f
        @range = range.to_f
        @damage = 0

        @position = owner.position
        @heading = owner.heading
    end

    def self.create type = "rocket", owner
      case type
      when "bazooka", "rocket"
          return Rocket.new owner
      when "emp"
          return Emp.new owner
      when "shotgun"
          return Shotgun.new owner
      end
    end
end
