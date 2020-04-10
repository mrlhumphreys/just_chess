require 'just_chess/piece_factory'
require 'board_game_grid'

module JustChess

  # = Square
  #
  # A Square on a checker board
  class Square < BoardGameGrid::Square

    # New objects can be instantiated by passing in a hash with
    #
    # @param [String] id
    #   the unique identifier of the square.
    #
    # @param [Fixnum] x
    #   the x co-ordinate of the square.
    #
    # @param [Fixnum] y
    #   the y co-ordinate of the square.
    #
    # @option [Piece,Hash,NilClass] piece
    #   The piece on the square, can be a piece object or hash or nil.
    #
    # ==== Example:
    #   # Instantiates a new Square
    #   JustChess::Square.new({
    #     id: 'a1',
    #     x: 1,
    #     y: 0,
    #     piece: { id: 1, player_number: 1, type: 'pawn' }
    #   })
    def initialize(id: , x: , y: , piece: nil)
      @id = id
      @x = x
      @y = y
      @piece = PieceFactory.new(piece).build
    end

    # returns the rank number of the square for the specified player
    #
    # @return [Fixnum]
    def rank_number(player_number)
      if player_number == 1
        8 - @y
      else
        @y + 1
      end
    end

    # Is the square the last rank for the specified player?
    #
    # @return [Boolean]
    def last_rank(player_number)
      rank_number(player_number) == 8
    end
  end
end
