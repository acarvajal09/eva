module Eva
  class Command

    attr_accessor :command, :arguments, :full_command, :error

    WHITE_LIST = [
      'PLACE',
      'MOVE',
      'RIGHT',
      'LEFT',
      'REPORT'
    ].freeze

    def arguments=(array)
      x = array[0].nil? ? false : array[0]
      y = array[1].nil? ? false : array[1]
      @arguments = {
        x: (x.to_i rescue nil),
        y: (y.to_i rescue nil),
        direction: array[2]
      }
    end

    def valid?(full_command)
      full_command = full_command.strip
      if full_command.empty?
        invalid_command_message!('Empty command')
        false
      else
        parse_command!(full_command)
        valid_command?
      end
    end

    def parse_command!(full_command)
      self.full_command = full_command
      tokens = full_command.split(' ', 2)
      self.command = tokens.first
      if tokens.size > 1
        arguments = tokens.last.split(',')
        # Split by comma without spaces
        if arguments.select{|arg| /\s/ =~ arg}.empty?
          self.arguments = arguments
        else
          self.arguments = [nil, nil, nil]
        end
      else
        self.arguments = [nil, nil, nil]
      end
    end

    def valid_command?
      if WHITE_LIST.include? command
        validate_syntax
      else
        invalid_command_message!(full_command)
        false
      end
    end

    def validate_syntax
      if place_command?
        validate_place_command
      else
        validate_one_word_command
      end
    end

    def place_command?
      command.eql? WHITE_LIST.first
    end

    def validate_place_command
      if invalid_place_size? || invalid_place_direction? || invalid_place_numbers?
        invalid_command_message!(full_command)
        false
      else
        true
      end
    end

    def invalid_place_size?
      arguments.values.compact.size != 3
    end

    def invalid_place_direction?
      # TODO: monkey patch the array class to add the .exclude? method and avoid the negation
      !(Direction::DIRECTIONS.include? arguments[:direction])
    end

    def invalid_place_numbers?
      unless arguments[:x].nil?
        @arguments[:x] = nil if arguments[:x] < 0
      end
      unless arguments[:y].nil?
        @arguments[:y] = nil if arguments[:y] < 0
      end
      [arguments[:x], arguments[:y]].include? nil
    end

    def validate_one_word_command
      if arguments.values.compact.empty?
        true
      else
        invalid_command_message!(full_command)
        false
      end
    end

    def invalid_command_message!(message)
      self.error = "Invalid command: #{message}"
    end

  end
end
