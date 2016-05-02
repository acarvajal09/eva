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

    # This method move current position to right
    def move_right!
      @current = (current + 1) % 4
    end

    # This method move current position to left
    def move_left!
      @current = (current - 1) % 4
    end

    # This method set current position to direction
    #
    # @param direction [String] new direction
    def place!(direction)
      @current = DIRECTIONS.index(direction)
    end

  end
end
