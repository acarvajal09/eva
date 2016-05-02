module Eva
  class Direction

    attr_reader :current

    DIRECTIONS = [
      'NORTH',
      'EAST',
      'SOUTH',
      'WEST'
    ].freeze

    def initialize
      @current = 0
    end

    def move_right!
      @current = (current + 1) % 4
    end

    def move_left!
      @current = (current - 1) % 4
    end

    def place!(direction)
      @current = DIRECTIONS.index(direction)
    end

  end
end
