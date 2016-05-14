

require 'celluloid/current'
require 'celluloid/io'

module RobotState
    class Server
      include Celluloid::IO
      finalizer :shutdown

      PORT = 9957
      HOST = '0.0.0.0'

      def initialize host = HOST, port = PORT
        puts "*** Starting server on #{host}:#{port}"

        # Since we included Celluloid::IO, we're actually making a
        # Celluloid::IO::TCPServer here
        @server = TCPServer.new(host, port)
        async.run
      end

      def shutdown
        @server.close if @server
      end

      def run
        loop { async.handle_connection @server.accept }
      end

      def handle_connection(socket)
        _, port, host = socket.peeraddr
        puts "*** Received connection from #{host}:#{port}"
        loop { socket.write socket.readpartial(4096) }
      rescue EOFError
        puts "*** #{host}:#{port} disconnected"
        socket.close
      end
    end
end
