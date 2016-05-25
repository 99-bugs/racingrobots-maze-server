require 'curses'

class StatsWindow < Curses::Window
  def initialize
    super(Curses.lines/2, Curses.cols, 0, 0)
    draw_window
    refresh
    @max_lines = Curses.lines/2 - 4
  end

  def draw_window
    clear
    box("|", "-")
  end

  def display_stats stats
    draw_window
    stats.pop while stats.count > @max_lines
    stats.each_with_index do |stat, i|
      setpos(2+i, 2)
      addstr(stat)
    end
    refresh
  end
end

class FlashWindow < Curses::Window
  def initialize
    super(Curses.lines/4, Curses.cols, Curses.lines / 2, 0)
    draw_window
    refresh
    @max_lines = Curses.lines/4 - 4
  end

  def draw_window
    clear
    box("|", "-")
  end

  def display_messages messages
    draw_window
    messages.shift while messages.count > @max_lines
    messages.each_with_index do |message, i|
      setpos(2+i, 2)
      addstr(message)
    end
    refresh
  end
end

class CommandWindow < Curses::Window
  def initialize
    super(Curses.lines/4, Curses.cols, 3*Curses.lines/4, 0)
    draw_window
    refresh
  end

  def draw_window
    clear
    box("|", "-")
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
    @flash_window.display_messages @flash_messages
  end

  def display_stats stats
    stats = stats.split("\n")
    @stats_window.display_stats stats
  end

  def close_all_windows
    @stats_window.close
    @flash_window.close
    @command_window.close
  end

end