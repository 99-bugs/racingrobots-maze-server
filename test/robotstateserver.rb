require 'minitest/autorun'
require './lib/RobotState/Server'
require './lib/Server'

# describe RobotState::Server do
#     before do
#         @server = RobotState::Server.new nil
#         port = @server.port
#         @client = TCPSocket.open("localhost", )
#     end
#
#     after do
#         @server.close
#         @client.close
#     end
#
#     describe "when making connection" do
#         it "must accept the connection" do
#
#         end
#     end
#
#     describe "when sending data" do
#         it "must not not accept any other data than json" do
#             @client.puts "blablala"
#             result = @client.gets
#             result.must_equal '{"error": "not valid json"}'
#         end
#     end
# end

describe Server do

    before do
        @server = Server.new
        @server.setRobots({
            robot1: "Robot 1",
            robot2: "Robot 2",
            robot3: "Robot 3"
            })
        port = @server.port
        @client = TCPSocket.open("localhost", port)
    end

    after do
        @client.close
        @server.close
    end

    describe "when sending data" do
        it "must not not accept any other data than json" do
            robot1 = @server.robots[:robot1]
            @client.puts '{ "robot1": {"x": 100, "y": 200, "angle": 1.5}, "robot2": {"x": 50, "y": 0, "angle": 0}}'
            result = @client.gets
            result.must_equal JSON.generate({status: "error", message: "command not a valid JSON string"})
        end
    end

end
