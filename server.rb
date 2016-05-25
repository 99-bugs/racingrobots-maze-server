require './lib/Server'
require 'yaml'
require './lib/GameStatistics'
require 'curses'
require './lib/CursesStatsPrinter'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: server.rb [options]"
  opts.on('-n', '--use-curses', 'Use curses for GUI') { |v| options[:use_curses] = v }
end.parse!

server = Server.new '0.0.0.0', RobotState::Server::PORT
settings = YAML.load_file('settings.yml')

server.serial = SerialPort.new settings["serial"]["device"], settings["serial"]["baud"]
server.setRobots settings["robots"]

statistics = GameStatistics.new server

if options.has_key?(:use_curses)
  begin
    ncurses_printer = CursesStatsPrinter.new

    loop do
      stats = statistics.robots
      ncurses_printer.display_stats stats
      sleep 1
    end

    ncurses_printer.close_all_windows
  rescue => ex
    Curses.close_screen
    puts ex.message
    puts ex.backtrace
  end
else
  loop do
    puts statistics.robots
    sleep 1
  end
end