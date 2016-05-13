require './lib/Server'
require 'yaml'
require './lib/GameStatistics'

server = Server.new
settings = YAML.load_file('settings.yml')
server.setRobots settings["names"]

statistics = GameStatistics.new server
puts statistics.robots
