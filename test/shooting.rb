require 'minitest/autorun'
require './lib/Server'

class TestShooting < Minitest::Test

  def setup
    @server = Server.new
    @server.setRobots({
        robot1: "Robot 1",
        robot2: "Robot 2",
        robot3: "Robot 3",
        robot4: "Robot 4",
        robot5: "Robot 5",
        robot6: "Robot 6",
        robot7: "Robot 7",
        robot8: "Robot 8"
        })
    @server.robots[:robot1].setLocation({x: 8.5, y: 2.5, a: Math::PI})
    @server.robots[:robot2].setLocation({x: 5.5, y: 2.5, a: 0})
    @server.robots[:robot3].setLocation({x: 4.5, y: 2.5, a: 0})
    @server.robots[:robot4].setLocation({x: 5.5, y: 2.0, a: 0})
    @server.robots[:robot5].setLocation({x: 8.5, y: 0.5, a: 0})
    @server.robots[:robot6].setLocation({x: 5.5, y: 0.5, a: (3*Math::PI)/2})
    @server.robots[:robot7].setLocation({x: 4.5, y: 3.5, a: Math::PI/4})
    @server.robots[:robot8].setLocation({x: 9.5, y: 0.5, a: Math::PI})
  end

  def test_clear_shot
      robot1 = @server.robots[:robot1]
      robot2 = @server.robots[:robot2]
      health = robot2.health
      robot1.shoot
      assert(robot2.health < health, "health not decreased after hit")
  end

  def test_missed_shot
      robot1 = @server.robots[:robot1]
      robot5 = @server.robots[:robot5]
      health = robot5.health
      robot1.shoot
      assert_equal health, robot5.health
  end

  def test_near_shot
      robot1 = @server.robots[:robot1]
      robot4 = @server.robots[:robot4]
      health = robot4.health
      robot1.shoot
      assert_equal health, robot4.health
  end

  def test_multiple_targets_shot
      robot6 = @server.robots[:robot6]
      robot4 = @server.robots[:robot4]
      robot2 = @server.robots[:robot2]
      health4 = robot4.health
      health2 = robot2.health

      robot6.shoot
      assert_equal health2, robot2.health
      refute_equal health4, robot4.health
  end

  def test_hit_shot_with_wall_in_between
      robot5 = @server.robots[:robot5]
      robot8 = @server.robots[:robot8]
      health = robot8.health
      robot5.shoot
      assert_equal health, robot8.health
  end
end
