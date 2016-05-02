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

    # This method override the setter method for arguments
    #
    # @param array [Array] with the arguments
    # @return [Hast] with arguments
    def arguments=(array)
      x = array[0].nil? ? false : array[0]
      y = array[1].nil? ? false : array[1]
      @arguments = {
        x: (x.to_i rescue nil),
        y: (y.to_i rescue nil),
        direction: array[2]
      }
    end

    # This method check if command is valid
    #
    # @return [Boolean] true if valid, otherwise false
    def valid?(full_command)
      full_command = full_command.strip
      if full_command.empty?
        invalid_command_message!('Blank command')
        false
      else
        parse_command!(full_command)
        valid_command?
      end
    end

    # This method parse the command and set the class attributes (not the error attribute)
    def parse_command!(full_command)
      self.full_command = full_command
      tokens = full_command.split(' ', 2)
      self.command = tokens.first
      if tokens.size > 1
        arguments = tokens.last.split(',')
        # Split by comma without spaces
        if arguments.select{|arg| /\s/ =~ arg}.empty? && arguments.size == 3
          self.arguments = arguments
        else
          self.arguments = [nil, nil, nil]
        end
      else
        self.arguments = [nil, nil, nil]
      end
    end

    # This method check if first word command is valid
    #
    # @return [Boolean] true if valid, otherwise false
    def valid_command?
      if WHITE_LIST.include? command
        validate_syntax
      else
        invalid_command_message!(full_command)
        false
      end
    end

    # This method validate syntax
    def validate_syntax
      if place_command?
        validate_place_command
      else
        validate_one_word_command
      end
    end

    # This method check if first word command is PLACE
    #
    # @return [Boolean] true if PLACE, otherwise false
    def place_command?
      command.eql? WHITE_LIST.first
    end

    # This method check if PLACE command is valid
    #
    # @return [Boolean] true if valid PLACE command, otherwise false
    def validate_place_command
      if invalid_place_size? || invalid_place_direction? || invalid_place_numbers?
        invalid_command_message!(full_command)
        false
      else
        true
      end
    end

    # This method check if valid PLACE size arguments
    #
    # @return [Boolean] true if valid PLACE size arguments, otherwise false
    def invalid_place_size?
      arguments.values.compact.size != 3
    end

    # This method check if valid PLACE direction
    #
    # @return [Boolean] true if valid PLACE direction, otherwise false
    def invalid_place_direction?
      # TODO: monkey patch the array class to add the .exclude? method and avoid the negation
      !(Direction::DIRECTIONS.include? arguments[:direction])
    end

    # This method check if valid PLACE coordinates
    #
    # @return [Boolean] true if valid PLACE coordinates, otherwise false
    def invalid_place_numbers?
      unless arguments[:x].nil?
        @arguments[:x] = nil if arguments[:x] < 0
      end
      unless arguments[:y].nil?
        @arguments[:y] = nil if arguments[:y] < 0
      end
      [arguments[:x], arguments[:y]].include? nil
    end

    # This method check if valid one word command
    #
    # @return [Boolean] true if valid one word command, otherwise false
    def validate_one_word_command
      if /^\S+$/ =~ full_command
        true
      else
        invalid_command_message!(full_command)
        false
      end
    end

    # This method set error when invalid command
    def invalid_command_message!(message)
      self.error = "Invalid command: #{message}"
    end

  end
end
