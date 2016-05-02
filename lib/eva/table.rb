module Eva
  class Table

    attr_reader :width, :height
    attr_accessor :x, :y

    def initialize(width, height)
      @width = width
      @height = height
      @x = 0
      @y = 0
    end

  end
end
