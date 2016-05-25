require 'curses'

class CursesWindow < Curses::Window
  attr_reader :max_lines

  def initialize height, width, top, left
    super(height, width, top, left)
    @max_lines = height-4

    display_border
    refresh
  end

  def display_border
    clear
    box("|", "-")
  end
end

class StatsWindow < CursesWindow
  def initialize
    super(Curses.lines/2, Curses.cols, 0, 0)
  end

  def display stats
    display_border
    stats.pop while stats.count > max_lines
    stats.each_with_index do |stat, i|
      setpos(2+i, 2)
      addstr(stat)
    end
    refresh
  end
end

class FlashWindow < CursesWindow
  def initialize
    super(Curses.lines/4, Curses.cols, Curses.lines/2, 0)
  end

  def display messages
    display_border
    messages.shift while messages.count > max_lines
    messages.each_with_index do |message, i|
      setpos(2+i, 2)
      addstr(message)
    end
    refresh
  end
end

class CommandWindow < CursesWindow
  def initialize
    super(Curses.lines/4, Curses.cols, 3*Curses.lines/4, 0)
    display
    refresh

    @commands = Queue.new
    @command_consumer = Thread.new do
      loop do
        command = @commands.pop
        @input_parser.parse(command) unless @input_parser.nil?
        display
        refresh
      end
    end
    
    Thread.new do
      listen_for_input
    end
  end

  def display_prompt
    setpos(2, 2)
    addstr("> ")
  end

  def display
    display_border
    display_prompt
  end

  def input_parser= parser
    @input_parser = parser
  end

  private
  def listen_for_input
    loop do
      command = getstr
      @commands.push command
    end
  end
end

class CursesStatsPrinter

  def initialize
    Curses.init_screen
    Curses.curs_set(0)  # Invisible cursor

    @stats_window = StatsWindow.new
    @flash_window = FlashWindow.new
    @command_window = CommandWindow.new

    @flash_messages = Array.new
  end

  def add_flash_message message
    @flash_messages << message
    @flash_window.display @flash_messages
  end

  def display_stats stats
    stats = stats.split("\n")
    @stats_window.display stats
  end

  def close_all_windows
    @stats_window.close
    @flash_window.close
    @command_window.close
  end

  def input_parser= parser
    @command_window.input_parser = parser
  end

end