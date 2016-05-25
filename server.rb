require './lib/Server'
require 'yaml'
require './lib/GameStatistics'
require 'curses'
require './lib/CursesStatsPrinter'

server = Server.new '0.0.0.0', RobotState::Server::PORT
settings = YAML.load_file('settings.yml')

Curses.init_screen
Curses.curs_set(0)  # Invisible cursor

server.serial = SerialPort.new settings["serial"]["device"], settings["serial"]["baud"]
server.setRobots settings["robots"]

statistics = GameStatistics.new server

begin
  ncurses_printer = CursesStatsPrinter.new

  loop do
    stats = statistics.robots
    ncurses_printer.display_stats stats
    sleep 1
  end

  printer.close_all_windows
rescue => ex
  Curses.close_screen
  puts ex.message
  puts ex.backtrace
end