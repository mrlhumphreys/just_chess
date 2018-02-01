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
    #     piece: { player_number: 1, direction: 1, king: false }
    #   })
    def initialize(id: , x: , y: , piece: nil)
      @id = id
      @x = x
      @y = y
      @piece = PieceFactory.new(piece).build
    end

    # Is the square occupied by the specified player?
    #
    # @return [Boolean]
    def occupied_by_player?(player_number)
      piece && piece.player_number == player_number
    end

    # Is the square occupied by the opponent of the specified player?
    #
    # @return [Boolean]
    def occupied_by_opponent?(player_number)
      piece && piece.player_number != player_number
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

    # A serialized version of the square as a hash
    #
    # @return [Hash]
    def as_json
      {
        id: id,
        x: x,
        y: y,
        piece: piece && piece.as_json
      }
    end
  end
end