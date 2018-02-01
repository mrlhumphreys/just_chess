module JustChess

  # = Piece
  #
  # A piece that can move on a chess board
  class Piece
    def initialize(id: , player_number: , type: nil, has_moved: false)
      @id = id
      @player_number = player_number
      @has_moved = has_moved
    end

    # @return [Fixnum] the identifier of the piece.
    attr_reader :id

    # @return [Fixnum] the owner of the piece.
    attr_reader :player_number

    # @return [Boolean] determines if the piece has moved.
    attr_reader :has_moved

    alias_method :has_moved?, :has_moved

    # The opposing player number
    #
    # @return [Fixnum]
    def opponent
      player_number == 1 ? 2 : 1
    end

    # mark the piece as moved
    #
    # @return [TrueClass]
    def moved
      @has_moved = true
    end

    # The stringified identifier of the piece type.
    #
    # @return [String]
    def has_not_moved?
      !has_moved?
    end

    # The stringified identifier of the piece type.
    #
    # @return [String]
    def type
      self.class.to_s.split('::').last.downcase
    end

    # Can the piece move from a square, to a square, given the game state?
    #
    # @param [Square] from
    #   the origin square.
    #
    # @param [Square] to
    #   the destination square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [Boolean]
    def can_move?(from, to, game_state)
      destinations(from, game_state).include?(to)
    end

    # All the squares that the piece can move to and/or capture.
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def destinations(square, game_state)
      []
    end

    # All the squares that the piece can move to.
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def move_squares(square, game_state)
      destinations(square, game_state)
    end

    # All the squares that the piece can capture.
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def capture_squares(square, game_state)
      destinations(square, game_state)
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