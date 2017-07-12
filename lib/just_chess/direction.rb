module JustChess

  # = Direction
  #
  # The Direction that something is moving on a 2d plane
  class Direction

    # New objects can be instantiated with
    #
    # @param [Fixnum] dx
    #   the dx magnitude.
    #
    # @param [Fixnum] dy
    #   the dy magnitude.
    #
    # ==== Example:
    #   # Instantiates a new Direction
    #   JustChess::Direction.new({
    #     dx: 1,
    #     dy: 1
    #   })
    def initialize(dx, dy)
      x = dx == 0 ? dx : dx/dx.abs
      y = dy == 0 ? dy : dy/dy.abs

      @x, @y = x, y
    end

    # @return [Fixnum] the x magnitude.
    attr_reader :x

    # @return [Fixnum] the y magnitude.
    attr_reader :y
  end
end