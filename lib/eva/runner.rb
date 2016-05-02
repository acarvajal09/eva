module Eva
  class Runner

    attr_reader :direction, :table
    attr_accessor :command, :placed

    def initialize
      @command = nil
      @placed = false
      @table = Table.new(5, 5)
      @direction = Direction.new
    end

    def already_placed?
      self.placed = true if command.command.eql? Command::WHITE_LIST[0]
      placed
    end

    def inside_table?(next_move, place=true)
      origin_x = place ? table.x : 0
      origin_y = place ? table.y : 0
      next_move[:x] = origin_x + next_move[:x]
      next_move[:y] = origin_y + next_move[:y]
      next_move[:x].between?(0, table.width - 1) && next_move[:y].between?(0, table.height - 1)
    end

    def place
      next_move = {x: command.arguments[:x], y: command.arguments[:y]}
      if inside_table?(next_move, false)
        update_position! next_move
        update_direction!
      else
        almost_die
      end
    end

    def move
      if inside_table? next_move
        update_position! next_move
      else
        almost_die
      end
    end

    def right
      direction.move_right!
    end

    def left
      direction.move_left!
    end

    def report
      puts "#{table.x},#{table.y},#{Direction::DIRECTIONS[direction.current]}"
    end

    def update_position!(next_move)
      table.x = table.x + next_move[:x]
      table.y = table.y + next_move[:y]
    end

    def update_direction!
      direction.place!(command.arguments[:direction])
    end

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

    def do(full_command)
      self.command = Command.new
      if command.valid?(full_command) && already_placed?
        case command.command
        when Command::WHITE_LIST[0] # PLACE
          place
        when Command::WHITE_LIST[1] # MOVE
          move
        when Command::WHITE_LIST[2] # RIGHT
          right
        when Command::WHITE_LIST[3] # LEFT
          left
        when Command::WHITE_LIST[4] # REPORT
          report
        end
      else
        puts error
      end
    end

    def error
      placed_error = placed ? nil : 'Eva is not placed'
      placed_error || command.error
    end

    def almost_die
      puts 'Eva almost die!'
    end

  end
end
