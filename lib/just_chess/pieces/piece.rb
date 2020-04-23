require 'board_game_grid'

module JustChess

  # = Piece
  #
  # A piece that can move on a chess board
  class Piece < BoardGameGrid::Piece
    def initialize(id: , player_number: , type: nil, has_moved: false)
      @id = id
      @player_number = player_number
      @has_moved = has_moved
    end

    # @return [Boolean] determines if the piece has moved.
    attr_reader :has_moved
    alias_method :has_moved?, :has_moved

    # mark the piece as moved
    #
    # @return [TrueClass]
    def moved
      @has_moved = true
    end

    # Has the piece not moved yet?
    #
    # @return [TrueClass, FalseClass]
    def has_not_moved?
      !has_moved?
    end

    # returns a serialized piece as a hash
    #
    # @return [Hash]
    def as_json
      {
        id: id,
        player_number: player_number,
        type: type,
        has_moved: has_moved?
      }
    end
  end
end
