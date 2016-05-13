require 'minitest/autorun'
require './lib/Geometry'

class TestGeometry < Minitest::Test

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

  def test_lines_crossing
      line1 = {start: {x: 0.0, y: 0.0}, end: {x: 10.0, y: 0.0}}
      line2 = {start: {x: 5.0, y: -5.0}, end: {x: 5.0, y: 5.0}}

      intersection = Geometry::getLineIntersection line1, line2

      assert_equal 5, intersection[:x]
      assert_equal 0, intersection[:y]
  end

  def test_lines_not_crossing
      line1 = {start: {x: 0.0, y: 0.0}, end: {x: 10.0, y: 0.0}}
      line2 = {start: {x: 5.0, y: 1.0}, end: {x: 5.0, y: 11.0}}

      intersection = Geometry::getLineIntersection line1, line2

      refute intersection
  end

end
