require 'minitest/autorun'
require './lib/RobotState/Server'
require './lib/Server'

describe Server do

    before do
        @server = Server.new
        @server.setRobots({
            "robot1" => "Robot 1",
            "robot2" => "Robot 2",
            "robot3" => "Robot 3"
            })
        @server.robots["robot1"].updatePosition(Geometry::Point[1728,508], Math::PI)
        @server.robots["robot2"].updatePosition(Geometry::Point[1118,508], 0)
        @server.robots["robot3"].updatePosition(Geometry::Point[ 915,508], 0)
        port = @server.port
        @client = TCPSocket.open("localhost", port)
    end

    after do
        @client.close
        @server.close
    end

    describe "when sending data" do
        it "must not not accept any other data than json" do
            @client.puts 'This is not a valid json string'
            result = @client.gets.strip
            assert_equal JSON.generate({status: "error", message: "command not a valid JSON string"}), result
        end
    end

    describe "when sending valid json state data" do
        it "must relocate robot to correct position" do
            robot1 = @server.robots["robot1"]
            @client.puts '[{ "id" : "robot1", "state": { "x": 123, "y": 180, "angle": 3.24 }}]'
            result = @client.gets.strip
            assert_equal JSON.generate({status: "ok"}), result

            assert_equal Geometry::Point[123,180], robot1.position
            assert_equal 3.24, robot1.heading
        end
    end
end
