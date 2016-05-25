require './lib/Server'
require 'yaml'
require './lib/GameStatistics'

server = Server.new '0.0.0.0', RobotState::Server::PORT
settings = YAML.load_file('settings.yml')

server.serial = SerialPort.new settings["serial"]["device"], settings["serial"]["baud"]
server.setRobots settings["robots"]


statistics = GameStatistics.new server
loop do
  puts statistics.robots
  sleep 1
end
