module Eva
  class Runner

    attr_reader :direction, :table
    attr_accessor :command, :placed

    def initialize
      EvaLogger.log
      @command = nil
      @placed = false
      @table = Table.new(5, 5)
      @direction = Direction.new
    end

    # This method execute the command
    #
    # @param full_command [String] with the command
    # @return [String] if REPORT, error message if invalid command
    def do(full_command)
      self.command = Command.new
      if command.valid?(full_command) && already_placed?
        case command.command
        when Command::WHITE_LIST[0] # PLACE
          place
          report {|msg| $log.info msg}
        when Command::WHITE_LIST[1] # MOVE
          move
          report {|msg| $log.info msg}
        when Command::WHITE_LIST[2] # RIGHT
          right
          report {|msg| $log.info msg}
        when Command::WHITE_LIST[3] # LEFT
          left
          report {|msg| $log.info msg}
        when Command::WHITE_LIST[4] # REPORT
          report {|msg| $log.info msg}
          report {|msg| puts msg}
        end
      else
        puts error
      end
    end

    # This method check if Eva was placed in table
    #
    # @return [Boolean] true if placed, otherwise false
    def already_placed?
      self.placed = true if command.command.eql? Command::WHITE_LIST[0]
      placed
    end

    # This method check if valid next move inside table
    #
    # @param next_move [Hash] with the command
    # @return [Boolean] true if is inside_table, otherwise false
    def inside_table?(next_move)
      next_move[:x].between?(0, table.width - 1) && next_move[:y].between?(0, table.height - 1)
    end

    # This method place Eva into x, y position
    def place
      next_move = {x: command.arguments[:x], y: command.arguments[:y]}
      if inside_table?(next_move_x_y(next_move, false))
        update_position!(next_move_x_y(next_move, false))
        update_direction!
      else
        almost_die
      end
    end

    # This method move Eva one position depending current direction
    def move
      if inside_table?(next_move_x_y(next_move))
        update_position!(next_move_x_y(next_move))
      else
        almost_die
      end
    end

    # This method turn Eva right
    def right
      direction.move_right!
    end

    # This method turn Eva left
    def left
      direction.move_left!
    end

    # This method output || log the current position: X,Y,Direction
    #
    # = Example
    #
    # 0,1,NORTH
    def report
      yield "#{table.x},#{table.y},#{Direction::DIRECTIONS[direction.current]}"
    end

    # This method update the Eva position to X,Y coordinates
    #
    # @param next_move [Hash] with the new coordinates
    def update_position!(next_move)
      table.x = next_move[:x]
      table.y = next_move[:y]
    end

    # This method update the Eva direction
    def update_direction!
      direction.place!(command.arguments[:direction])
    end

    # This method return the next move based in the current direction
    #
    # @return [Hash] with X,Y coordinates
    def next_move
      case Direction::DIRECTIONS[direction.current]
      when Direction::DIRECTIONS[0] # NORTH
        {x: 0, y: 1}
      when Direction::DIRECTIONS[1] # EAST
        {x: 1, y: 0}
      when Direction::DIRECTIONS[2] # SOUTH
        {x: 0, y: -1}
      when Direction::DIRECTIONS[3] # WEST
        {x: -1, y: 0}
      end
    end

    # This method return the next move based in the command,
    # if PLACE command reset the position, otherwise update
    # X,Y coordinates
    #
    # @return [Hash] with X,Y coordinates
    def next_move_x_y(next_move, place=true)
      origin_x = place ? table.x : 0
      origin_y = place ? table.y : 0
      next_move[:x] = origin_x + next_move[:x]
      next_move[:y] = origin_y + next_move[:y]
      next_move
    end

    # This method return the error when invalid command
    #
    # @return [String] with error
    def error
      placed_error = placed ? nil : 'Eva is not placed'
      placed_error || command.error
    end

    # This method output warning when Eva receive command outside the table
    def almost_die
      puts 'Eva almost die!'
    end

  end
end
