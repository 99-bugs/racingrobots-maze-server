require "./lib/Shots/Shot.rb"

class Emp < Shot

  def initialize owner, range = 300.0, power = 10.0
      super owner, range, power

      checkCollisions if @world
  end

  def checkCollisions
    robots = getRobotCollision
    robots.each do |robot|
      @damage += robot.hit! self unless robot.nil?
    end
  end

  def getRobotCollision
      robots = @world.robots.select do |id, robot|
        distance = GeometryHelper::distance(@position, robot.position)
        distance < @range unless robot == @owner
      end
      robots
  end

end
