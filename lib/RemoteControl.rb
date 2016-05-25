require 'xbee-ruby'

module RemoteControl

    def set_xbee_address= address
      @address = XBeeRuby::Address64.new(*address)
    end

    def set_xbee_port= port
      @xbee = XBeeRuby::XBee.new serial: port
    end

    def xbee_send data
      raise "Xbee address not set" if @address.nil?
      raise "No serial port for Xbee configured" if @xbee.nil?
      @xbee.write_request XBeeRuby::TxRequest.new  @address, data
    end

    def drive speed, turn_radius
      raise "Speed is to high, speed must be less than 100" if speed > 100
      raise "Speed is to low, speed must be greater than -100" if speed < -100
      raise "Turn radius is to high, turn_radius must be less than 100" if speed > 100
      raise "Turn radius is to low, turn_radius must be greater than -100" if speed < -100
      xbee_send [0x10, [speed].pack("c").getbyte(0), [turn_radius].pack("c").getbyte(0)]
    end

    def forward
        drive 100, 0
    end

    def backward
        drive -100, 0
    end

    def turn_left
        drive 0, -50
    end

    def turn_right
        drive 0, 50
    end

    def stop
        speed 0
    end
end
