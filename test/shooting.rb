require 'minitest/autorun'
require './lib/Server'

class TestShooting < Minitest::Test

  def setup
    @server = Server.new
    @server.setRobots({ robot1: "Robot 1", robot2: "Robot 2"})
  end

  def test_clear_shot
      robot1 = @server.robots[:robot1]
      robot2 = @server.robots[:robot2]

      robot1.setLocation({x: 8.5, y: 2.5, a: Math::PI})
      robot2.setLocation({x: 5.5, y: 2.5, a: 0})

      health = robot2.health
      robot1.shoot
      assert(robot2.health < health, "health not decreased after hit")
  end
end
