require 'minitest/autorun'
require './lib/RobotController'
require './lib/Server'
require 'geometry/point'

require "minitest/reporters"
Minitest::Reporters.use!    [Minitest::Reporters::SpecReporter.new]

describe RobotController do

    before do
        @server = Server.new
        @server.setRobots({
            "robot1" => "Robot 1",
            "robot2" => "Robot 2",
            "robot3" => "Robot 3",
            "robot4" => "Robot 4",
            "robot5" => "Robot 5",
            "robot6" => "Robot 6",
            "robot7" => "Robot 7",
            "robot8" => "Robot 8"
            })
        @server.robots["robot1"].updatePosition(Geometry::Point[1728,508], Math::PI)
        @server.robots["robot2"].updatePosition(Geometry::Point[1118,508], 0)
        @server.robots["robot3"].updatePosition(Geometry::Point[ 915,508], 0)
        @server.robots["robot4"].updatePosition(Geometry::Point[1118,406], 0)
        @server.robots["robot5"].updatePosition(Geometry::Point[1728,101], 0)
        @server.robots["robot6"].updatePosition(Geometry::Point[1118,101], (3*Math::PI)/2)
        @server.robots["robot7"].updatePosition(Geometry::Point[ 915,711], Math::PI/4)
        @server.robots["robot8"].updatePosition(Geometry::Point[1931,101], Math::PI)
    end

    after do
        @server.close
    end

    describe "when robot shoots" do
        it "should hit robot in front of him" do
            robot1 = @server.robots["robot1"]
            robot2 = @server.robots["robot2"]
            health = robot2.health
            robot1.shoot
            assert robot2.health < health
        end

        it "should mis robot next to him" do
            robot1 = @server.robots["robot1"]
            robot5 = @server.robots["robot5"]
            health = robot5.health
            robot1.shoot
            assert_equal health, robot5.health
        end

        it "should hit robot, even on the side" do
            robot1 = @server.robots["robot1"]
            robot4 = @server.robots["robot4"]
            health = robot4.health
            robot1.shoot
            assert_equal health, robot4.health
        end

        it "should only hit the closes robot" do
            robot6 = @server.robots["robot6"]
            robot4 = @server.robots["robot4"]
            robot2 = @server.robots["robot2"]
            health4 = robot4.health
            health2 = robot2.health

            robot6.shoot
            assert_equal health2, robot2.health
            refute_equal health4, robot4.health
        end

        it "should not hit a robot if a wall is in between" do
            robot5 = @server.robots["robot5"]
            robot8 = @server.robots["robot8"]
            health = robot8.health
            robot5.shoot
            assert_equal health, robot8.health
        end
    end

    describe "when robot is hit" do
        it "should die if health is zero" do
            robot1 = @server.robots["robot1"]
            robot2 = @server.robots["robot2"]
            health = robot2.health
            robot1.shoot
            robot1.shoot
            robot1.shoot
            robot1.shoot
            robot1.shoot
            assert robot2.dead?
        end

        it "should have a health of 0 if robot is dead" do
            robot1 = @server.robots["robot1"]
            robot2 = @server.robots["robot2"]
            health = robot2.health
            robot1.shoot
            robot1.shoot
            robot1.shoot
            robot1.shoot
            robot1.shoot
            assert_equal 0, robot2.health
        end

        it "cannot shoot when dead" do
            robot1 = @server.robots["robot1"]
            robot2 = @server.robots["robot2"]
            robot2.shoot
            robot2.shoot
            robot2.shoot
            robot2.shoot
            robot2.shoot
            health = robot1.health
            robot1.shoot
            assert_equal health, robot1.health
            assert_equal 5, robot2.shotsFired
            assert_equal 100, robot2.damage
        end
    end


end
