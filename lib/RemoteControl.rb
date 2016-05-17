

module RemoteControl
    def speed value
        # if xbee on pi -> serial port command packet
        # else socket client (in @server instance) to mbed
    end

    def turn value
        # if xbee on pi -> serial port command packet
        # else socket client (in @server instance) to mbed
    end

    def forward
        speed 100
    end

    def backward
        speed -100
    end

    def turn_left
        turn 100
    end

    def turn_right
        turn -100
    end

    def stop
        speed 0
    end
end
