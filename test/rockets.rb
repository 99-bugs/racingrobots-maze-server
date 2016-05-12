require 'minitest/autorun'
require './lib/Robot'
require './lib/Rocket'

class TestRockets < Minitest::Test

  def setup
      @robot = Robot.new
  end

  def test_minimum_distance_from_point
      rocket = Rocket.new @robot
      distance = rocket.minimumDistanceToPoint({x:2.5, y:1})
      assert_equal 1, distance
  end

  def test_minimum_distance_from_point_behind_end_point
      rocket = Rocket.new @robot
      distance = rocket.minimumDistanceToPoint({x:6, y:0})
      assert_equal 1, distance
  end

  def test_minimum_distance_from_point_before_begin_point
      rocket = Rocket.new @robot
      distance = rocket.minimumDistanceToPoint({x:-1, y:0})
      assert_equal 1, distance
  end


end
