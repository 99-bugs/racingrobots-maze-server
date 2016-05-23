require 'minitest/autorun'
require './lib/RobotController'
require './lib/Server'
require './test/custom_assertions'

describe RobotController do

    before do
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
        @server.robots[:robot1].updatePosition(Geometry::Point[8.5,2.5], Math::PI)
        @server.robots[:robot2].updatePosition(Geometry::Point[5.5,2.5], 0)
        @server.robots[:robot3].updatePosition(Geometry::Point[4.5,2.5], 0)
        @server.robots[:robot4].updatePosition(Geometry::Point[5.5,2.0], 0)
        @server.robots[:robot5].updatePosition(Geometry::Point[8.5,0.5], 0)
        @server.robots[:robot6].updatePosition(Geometry::Point[5.5,0.5], (3*Math::PI)/2)
        @server.robots[:robot7].updatePosition(Geometry::Point[4.5,3.5], Math::PI/4)
        @server.robots[:robot8].updatePosition(Geometry::Point[9.5,0.5], Math::PI)

        @robotController = @server.robotController
    end

    after do
        @server.close
    end

    describe "commandparser" do
        describe "returning an error" do
            it  "if command is not valid JSON" do
                result = @robotController.parseCommand "this is not valid json"

                assert_string_contains "error", result
                assert_string_contains "command not a valid JSON string", result
            end

            it "if no id is present" do
                command = JSON.generate([
                    { "move": "forward"}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "warning", result
                assert_string_contains "has no id", result
            end

            it "if robotid is not valid" do
                command = JSON.generate([
                    { "id": "robot999",  "move": "forward"}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "warning", result
                assert_string_contains "unknown robot", result
            end

            it "if move has no arguments" do
                command = JSON.generate([
                    { "id": "robot1",  "move": ""}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "warning", result
                assert_string_contains "\\\"\\\" did not match one of the following values: forward, left, right, reverse", result
            end

            it "if move has invalid arguments" do
                command = JSON.generate([
                    { "id": "robot1",  "move": "invalid"}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "warning", result
                assert_string_contains "\\\"invalid\\\" did not match one of the following values: forward, left, right, reverse", result
            end

            it "if shoot has no arguments" do
                command = JSON.generate([
                    { "id": "robot1",  "shoot": ""}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "warning", result
                assert_string_contains "\\\"\\\" did not match one of the following values: rocket, shoot, bazooka, a, b, x", result
            end

            it "if move has invalid arguments" do
                command = JSON.generate([
                    { "id": "robot1",  "shoot": "fire"}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "warning", result
                assert_string_contains "\\\"fire\\\" did not match one of the following values: rocket, shoot, bazooka, a, b, x", result
            end

            it "if state has missing x position" do
                command = JSON.generate([
                    { "id": "robot1", "state": { "y": 54, "angle": 2.14 }}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "warning", result
                assert_string_contains "did not contain a required property of 'x'", result
            end

            it "if state has missing y position" do
                command = JSON.generate([
                    { "id": "robot1", "state": { "x": 54, "angle": 2.14 }}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "warning", result
                assert_string_contains "did not contain a required property of 'y'", result
            end

            it "if state has missing angle" do
                command = JSON.generate([
                    { "id": "robot1", "state": { "x": 54, "y": 54 }}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "warning", result
                assert_string_contains "did not contain a required property of 'angle'", result
            end

            it "if state has invalid x position" do
                command = JSON.generate([
                    { "id": "robot1", "state": { "x": nil, "y": 54, "angle": 2.14 }}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "warning", result
                assert_string_contains "did not match the following type: number", result
            end

            it "if state has invalid y position" do
                command = JSON.generate([
                    { "id": "robot1", "state": { "x": 43, "y": nil, "angle": 2.14 }}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "warning", result
                assert_string_contains "did not match the following type: number", result
            end

            it "if state has invalid angle" do
                command = JSON.generate([
                    { "id": "robot1", "state": { "x": 43, "y": 55, "angle": "PI" }}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "warning", result
                assert_string_contains "did not match the following type: number", result
            end
        end

        describe "commanding a robot to move" do
            it "should return no error" do
                command = JSON.generate([
                    { "id": "robot1", "move": "forward"}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "ok", result
            end
        end

        describe "commanding a robot to shoot" do
            it "should return no error" do
                command = JSON.generate([
                    { "id": "robot1", "shoot": "rocket"}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "ok", result
            end
        end

        describe "commanding a robot to move and shoot" do
            it "should return no error" do
                command = JSON.generate([
                    { "id": "robot1", "move": "forward", "shoot": "rocket"}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "ok", result
            end
        end

        describe "updating a robots position" do
            it "should return no error" do
                command = JSON.generate([
                    { "id": "robot1", "state": { "x": 12, "y": 54, "angle": 2.14 }}
                    ])
                result = @robotController.parseCommand command

                assert_string_contains "ok", result
            end
        end
    end
end

describe CommandParser do
    before do
        @server = Server.new
        @server.setRobots({ robot1: "Robot 1" })
        @server.robots[:robot1].updatePosition(Geometry::Point[8.5,2.5], Math::PI)
    end

    it "should parse json data" do
        data = JSON.generate([
            { "id": "robot1", "shoot": "rocket"}
            ])
        
        robot = @server.robots[:robot1]
        assert_equal 0, robot.shotsFired

        @server.robotController.parseCommand data

        assert_equal 1, robot.shotsFired
    end
end
