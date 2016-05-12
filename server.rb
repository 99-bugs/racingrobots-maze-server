require './lib/Server'
require 'yaml'

server = Server.new
settings = YAML.load_file('settings.yml')
server.setRobots @settings["names"]
