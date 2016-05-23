require 'json'
require 'json-schema'

class CommandError < StandardError
end

class CommandParser

    SCHEMA = {
        "type" => "array",
        "items"=> {
            "type" => "object",
            "properties" => {
                "id" => { "$ref" => "#/definitions/id" },
                "move" => { "$ref" => "#/definitions/move" },
                "shoot" => { "$ref" => "#/definitions/shoot" },
                "state" => { "$ref" => "#/definitions/state" }
            },
            "additionalProperties" => false,
            "required"=> ["id"],
            "minProperties"=> 2,
            "maxProperties"=> 4
        },
        "definitions" => {
                    "id" => { "type" => "string", "pattern" => "^(robot[0-9]+)$" },
                    "move" => { "type" => "string", "enum" => ["forward", "left", "right", "reverse"] },
                    "shoot" => { "type" => "string", "enum" => ["rocket", "shoot", "bazooka", "a", "b", "x"] },
                    "state" => {
                        "type" => "object",
                        "properties" => {
                            "x" => { "type" => "number", "minimum" => 0, "maximum" => 2440 },
                            "y" => { "type" => "number", "minimum" => 0, "maximum" => 1220 },
                            "angle" => { "type" => "number" }
                        },
                        "required"=> ["x", "y", "angle"]
                    }
        }
    }

    def initialize
        @handlers = Hash.new
    end

    def registerHandler commandkey, handler
        @handlers[commandkey.downcase] = handler
    end

    def parse json_string
        warnings = ""

        JSON.parse(json_string).each do |robot|
            begin
                # Make sure robot has id
                JSON::Validator.validate!(SCHEMA, robot['id'], :fragment => "#/definitions/id")

                @handlers.each do |property, handler|
                    if (robot.has_key?(property))
                        begin
                            JSON::Validator.validate!(SCHEMA, robot[property], :fragment => "#/definitions/" + property)
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