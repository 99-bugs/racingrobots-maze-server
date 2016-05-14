require 'minitest/autorun'
require './lib/RobotState/Server'

describe RobotState::Server do
    before do
        @server = RobotState::Server.new
        @client = TCPSocket.open("localhost", RobotState::Server::PORT)
    end

    after do
        # @server.shutdown
        # @client.close
    end

    describe "when making connection" do
        it "must accept the connection" do

        end
    end

    describe "when sending data" do
        it "must not not accept any other data than json" do
            #@client.puts "blablala"
            #result = @client.gets
            #result.must_equal '{"error": "not valid json"}'
        end
    end

end
