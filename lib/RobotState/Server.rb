require 'socket'

module RobotState
    class Server

      PORT = 9957
      HOST = '0.0.0.0'

      def initialize robotController, host = HOST, port = 0
          @robotController = robotController
          @server = TCPServer.new(host, port)
          @clients = []
          @commands = Queue.new
          @listener = Thread.new do
              loop do
                  command = @commands.pop
                  response = robotController.parseCommand command[:command]
                  command[:response_queue] << response
              end
          end
          Thread.new do
              run
          end
      end

      def close
          @server.close
          @listener.kill
          @clients.each do |client|
              thread.kill
          end
      end

      def port
          @server.addr[1]
      end

      private

      def run
          loop do
              Thread.new(@server.accept) do |client|
                  @clients << client
                  @response = Queue.new
                  puts @response
                  while command = client.gets.strip
                      @commands.push({command: command, response_queue: @response})
                      client.puts @response.pop
                  end

              end
          end
      end
  end
end
