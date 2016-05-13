require 'minitest/autorun'
require './lib/Geometry'

class TestRockets < Minitest::Test

  def setup

  end

  def test_minimum_distance_from_point
      linestart = {x: 0, y: 0}
      lineend = {x: 5, y: 0}
      point = {x: 2.5, y: 1}
      distance = Geometry::minimumDistanceLineToPoint(linestart, lineend, point)
      assert_equal 1, distance
  end

  def test_minimum_distance_from_point_behind_end_point
      linestart = {x: 0, y: 0}
      lineend = {x: 5, y: 0}
      point = {x: 6, y: 0}
      distance = Geometry::minimumDistanceLineToPoint(linestart, lineend, point)
      assert_equal 1, distance
  end

  def test_minimum_distance_from_point_before_begin_point
      linestart = {x: 0, y: 0}
      lineend = {x: 5, y: 0}
      point = {x: -1, y: 0}
      distance = Geometry::minimumDistanceLineToPoint(linestart, lineend, point)
      assert_equal 1, distance
  end


end
