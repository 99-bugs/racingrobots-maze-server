require "./lib/Shots/Rocket"

class Shotgun < Rocket

  def initialize owner, range = 500.0, power = 15.0
      super owner, range, power
      @bullets = 15

      delta_angle = Math::PI / 4 # 45°

      @heading -= delta_angle / 2

      @bullets.times do |i|
          @heading += delta_angle / @bullets
          @traject = Line[@position, endPosition]
          checkCollisions if @world
      end
  end

  def power
    @power / @bullets
  end

end
