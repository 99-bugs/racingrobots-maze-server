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
            @client.puts 'This is not a valid json string'
            result = @client.gets.strip
            assert_equal JSON.generate({status: "error", message: "command not a valid JSON string"}), result
        end
    end

end