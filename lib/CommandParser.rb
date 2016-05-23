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
        warnings = ""

        JSON.parse(json_string).each do |robot|
            begin
                # Make sure robot has id
                JSON::Validator.validate!(@schema, robot['id'], :fragment => "#/definitions/id")

                @handlers.each do |property, handler|
                    if (robot.has_key?(property))
                        begin
                            JSON::Validator.validate!(@schema, robot[property], :fragment => "#/definitions/" + property)
                            handler.call(robot['id'], robot[property])
                        rescue JSON::Schema::ValidationError => e
                            warnings += "#{robot['id']}: #{e.message}"
                        rescue CommandError => ce
                            warnings += ce.message
                        end
                    end
                end

            rescue JSON::Schema::ValidationError => e
                warnings += "#{robot.inspect}: has no id"
            end
        end

        raise CommandError.new warnings unless warnings.empty?
    end
end
