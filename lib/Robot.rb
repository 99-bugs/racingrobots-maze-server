require './lib/Rocket'

class Robot

    attr_reader :health, :size, :world
    @power = 0

    def initialize name = "Unnamed Robot", world = nil
        @world = world
        @name = name
        @size = 0.5
        @health = 100
        @x, @y, @a = 0
    end

    def update
        power = power + 1
    end

    def setLocation location
        #[:x, :y, :a].all? {|s| location.key? s}
        @x = location[:x]
        @y = location[:y]
        @a = location[:a]
    end

    def shoot
        @power = 0
        rocket = Rocket.new self
    end

    def getPosition
        {x: @x, y: @y, a: @a}
    end

    def hit! rocket
        @health -= rocket.power
    end

end
