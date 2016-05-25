require 'table_print'

class GameStatistics

    def initialize server
        @server = server
    end

    def robots
        options = [
            :name,
            {:position => {:display_method => lambda{|u| "#{"%6.0f" % u.position.x} - #{"%6.0f" % u.position.y}"}}},
            {:heading=> {:display_method => lambda{|u| "#{"%6.3f" % u.heading}"}}},
            :health,
            :shotsFired,
            :damage
        ]
        tablePrinter = TablePrint::Printer.new @server.robots.values, options
        tablePrinter.table_print
    end

    def to_s
        tablePrinter = TablePrint::Printer.new @server, options
        tablePrinter.table_print
    end

end
