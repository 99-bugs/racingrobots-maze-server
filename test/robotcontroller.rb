require 'minitest/autorun'
require './lib/RobotController'
# require './lib/Server'
# require 'Geometry/Point'

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
        @server.robots[:robot1].updatePosition(Geometry::Point[1728,508], Math::PI)
        @server.robots[:robot2].updatePosition(Geometry::Point[1118,408], 0)
        @server.robots[:robot3].updatePosition(Geometry::Point[ 915,508], 0)
        @server.robots[:robot4].updatePosition(Geometry::Point[1118,406], 0)
        @server.robots[:robot5].updatePosition(Geometry::Point[1728,101], 0)
        @server.robots[:robot6].updatePosition(Geometry::Point[1118,101], (3*Math::PI)/2)
        @server.robots[:robot7].updatePosition(Geometry::Point[ 915,711], Math::PI/4)
        @server.robots[:robot8].updatePosition(Geometry::Point[1931,101], Math::PI)

        @robotController = @server.robotController
    end

    describe "commandparser" do
        describe "returning an error" do
            it  "if command is not valid JSON" do
                result = @robotController.parseCommand "this is not valid json"
                assert_equal JSON.generate({status: "error", message: "command not a valid JSON string"}), result
            end

            it "if no robotid is present" do
                command = JSON.generate({
                    command: "forward"
                    })
                result = @robotController.parseCommand command
                assert_equal JSON.generate({status: "error", message: "no robotid present"}), result
            end

            it "if no command is present" do
                command = JSON.generate({
                    robotid: "robot1"
                    })
                result = @robotController.parseCommand command
                assert_equal JSON.generate({status: "error", message: "no command present"}), result
            end

            it "if robotid does not exist" do
                command = JSON.generate({
                    robotid: "doesnotexist",
                    command: "forward"
                    })
                result = @robotController.parseCommand command
                assert_equal JSON.generate({status: "error", message: "unknown robot"}), result
            end

            it "if command does not exist" do
                command = JSON.generate({
                    robotid: "robot1",
                    command: "commanddoesnotexist"
                    })
                result = @robotController.parseCommand command
                assert_equal JSON.generate({status: "error", message: "unknown command"}), result
            end
        end

        describe "commanding a robot" do
            it "should return no error" do
                command = JSON.generate({
                    robotid: "robot1",
                    command: "forward"
                    })
                result = @robotController.parseCommand command
                assert_equal  "ok", JSON.parse(result)["status"]
            end
        end
    end
end

describe StateParser do
    it "should parse json data" do
        data = '{ "robot1": {"x": 100, "y": 200, "angle": 1.5}, "robot2": {"x": 50, "y": 0, "angle": 0}}'
        state = StateParser::parse data

        assert state.key? "robot1"
        assert state.key? "robot2"

        assert_equal 100, state["robot1"]["x"]
        assert_equal 200, state["robot1"]["y"]
        assert_equal 1.5, state["robot1"]["angle"]

        assert_equal 50, state["robot2"]["x"]
        assert_equal 0, state["robot2"]["y"]
        assert_equal 0, state["robot2"]["angle"]
    end
end

describe CommandParser do
    before do
        @server = Server.new
        @server.setRobots({ robot1: "Robot 1" })
        @server.robots[:robot1].updatePosition(Geometry::Point[8.5,2.5], Math::PI)
    end

    it "should parse json data" do
        data = '{ "robotid": "robot1", "command": "shoot"}'
        robot = @server.robots[:robot1]
        assert_equal 0, robot.shotsFired

        @server.robotController.parseCommand data

        assert_equal 1, robot.shotsFired
    end
end
