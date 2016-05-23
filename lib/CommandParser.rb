require 'json'
require 'json-schema'

class CommandError < StandardError
end

class CommandParser

    SCHEMA_FILE = "./lib/json_schemas/command.json"

    def initialize
        @handlers = Hash.new

        # Read schema
        @schema = File.read(SCHEMA_FILE)
    end

    def registerHandler commandkey, handler
        @handlers[commandkey.downcase] = handler
    end

    def parse json_string
        # Parse and validate json info
        parsed_json = JSON.parse(json_string)
        warnings = JSON::Validator.fully_validate(@schema, parsed_json)
        raise CommandError.new warnings unless warnings.empty?

        # Call handlers
        warnings = ""
        parsed_json.each do |robot|
            @handlers.each do |property, handler|
                if (robot.has_key?(property))
                    begin
                        handler.call(robot['id'], robot[property])
                    rescue CommandError => ce
                        warnings += ce.message
                    end
                end
            end
        end
        raise CommandError.new warnings unless warnings.empty?
    end
end