class InputParser

  def initialize curses_printer, server
    @curses_printer = curses_printer
    @server = server
  end

  def parse string
    command = string.split
    case command[0]
      when 'reset' then
        if (command.count == 2)
          robot =  @server.robots[command[1]]
          if robot.nil?
            @curses_printer.add_flash_message "Unknown robot"
          else
            @curses_printer.add_flash_message "Resetting #{command[1]}"
            robot.reset
          end
        else
          @curses_printer.add_flash_message "Invalid command given"
        end      
    end
  end

end