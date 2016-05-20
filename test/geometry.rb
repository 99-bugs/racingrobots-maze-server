require 'minitest/autorun'
require './lib/GeometryHelper'
require 'geometry/line'
require 'geometry/point'

class TestGeometry < Minitest::Test

    Line = Geometry::Line
    Point = Geometry::Point
    
  def setup

  end

  def test_minimum_distance_from_point
      line = Line[[0,0], [5,0]]
      point = Point[2.5, 1]
      distance = GeometryHelper::minimumDistanceLineToPoint(line, point)
      assert_equal 1, distance
  end

  def test_minimum_distance_from_point_behind_end_point
      line = Line[[0,0], [5,0]]
      point = Point[6, 0]
      distance = GeometryHelper::minimumDistanceLineToPoint(line, point)
      assert_equal 1, distance
  end

  def test_minimum_distance_from_point_before_begin_point
      line = Line[[0,0], [5,0]]
      point = Point[-1, 0]
      distance = GeometryHelper::minimumDistanceLineToPoint(line, point)
      assert_equal 1, distance
  end

  def test_lines_crossing
      line1 = Line[[0,0],[10,0]]
      line2 = Line[[5,-5],[5,5]]

      intersection = GeometryHelper::getLineIntersection line1, line2

      assert_equal 5, intersection.x
      assert_equal 0, intersection.y
  end

  def test_lines_not_crossing
      line1 = Line[[0,0],[10,0]]
      line2 = Line[[5,1],[5,11]]

      intersection = GeometryHelper::getLineIntersection line1, line2

      refute intersection
  end

end
