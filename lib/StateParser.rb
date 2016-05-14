require 'json'

class StateError < StandardError
end

class StateParser

    def initialize server
        @server = server
    end

    # { "robot1": {x: 0, y: 0, angle: 0}, ...}
    def self.parse data
        JSON.parse data
    end

end
