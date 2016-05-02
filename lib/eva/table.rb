module Eva
  class Table

    attr_reader :width, :height
    attr_accessor :x, :y

    # This method initialize the table
    #
    # @param width [Integer] table width
    # @param height [Integer] table height
    def initialize(width, height)
      @width = width
      @height = height
      @x = 0
      @y = 0
    end

  end
end
