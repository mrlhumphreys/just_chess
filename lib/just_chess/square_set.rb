require 'just_chess/square'
require 'board_game_grid'

module JustChess

  # = Square Set
  #
  # A collection of Squares with useful filtering functions
  class SquareSet < BoardGameGrid::SquareSet

    # New objects can be instantiated by passing in a hash with squares.
    # They can be square objects or hashes.
    #
    # @param [Array<Square,Hash>] squares
    #   An array of squares, each with x and y co-ordinates and a piece.
    #
    # ==== Example:
    #   # Instantiates a new Square Set
    #   JustChess::SquareSet.new({
    #     squares: [
    #       { x: 1, y: 0, piece: { player_number: 1, direction: 1, king: false }}
    #     ]
    #   })
    def initialize(squares: )
      @squares = if squares.all? { |s| s.instance_of?(Hash) }
        squares.map { |s| Square.new(s) }
      elsif squares.all? { |s| s.instance_of?(Square) }
        squares
      else
        raise ArgumentError, "all squares must have the same class"
      end
    end

    # serializes the squares as a hash
    #
    # @return [Hash]
    def as_json
      squares.map(&:as_json)
    end

    # Find the square with the matching piece identifier
    #
    # @param [Fixnum] piece_id
    #   the unique identifier of the piece.
    #
    # @return [Square]
    # ==== Example:
    #   # Find the square with a piece of id 4
    #   square_set.find_by_piece_id(4)
    def find_by_piece_id(piece_id)
      find { |s| s.piece && s.piece.id == piece_id }
    end

    # Find the square occupied by the player's king
    #
    # @param [Fixnum] player_number
    #   the number of the player
    #
    # @return [Square]
    # ==== Example:
    #   # Find the square occupied by player 2's king
    #   square_set.find_king_for_player(2)
    def find_king_for_player(player_number)
      find { |s| s.piece && s.piece.is_a?(JustChess::King) && s.occupied_by_player?(player_number) }
    end

    # Find all squares in the y direction of square
    #
    # @param [Square] square
    #   the originating square
    #
    # @param [Fixnum] direction_y
    #   the direction, either up (-1) or down (1)
    #
    # @return [SquareSet]
    # ==== Example:
    #   # Get all squares up from square_a
    #   square_set.in_direction(square_a, -1)
    def in_direction(square, direction_y)
      select { |s| BoardGameGrid::Vector.new(square, s).direction.y == direction_y }
    end

    # Takes a player number and returns all squares occupied by the player
    #
    # @param [Fixnum] player_number
    #   the player's number.
    #
    # @return [SquareSet]
    def occupied_by_player(player_number)
      select { |s| s.occupied_by_player?(player_number) }
    end

    # Takes a player number and returns all squares occupied by the opponent of the player
    #
    # @param [Fixnum] player_number
    #   the player's number.
    #
    # @return [SquareSet]
    def occupied_by_opponent(player_number)
      select { |s| s.occupied_by_opponent?(player_number) }
    end

    # Takes a player number and returns all squares unoccupied or occupied by the opponent of the player
    #
    # @param [Fixnum] player_number
    #   the player's number.
    #
    # @return [SquareSet]
    def unoccupied_or_occupied_by_opponent(player_number)
      select { |s| s.unoccupied? || s.occupied_by_opponent?(player_number) }
    end

    # Find all squares occupied by a piece of a particular type
    #
    # @param [Class] piece_type
    #   the class of the piece.
    #
    # @return [SquareSet]
    def occupied_by_piece(piece_type)
      select { |s| s.piece && s.piece.is_a?(piece_type) }
    end

    # Find all squares occupied by a piece not of a particular type
    #
    # @param [Class] piece_type
    #   the class of the piece.
    #
    # @return [SquareSet]
    def excluding_piece(piece_type)
      select { |s| s.piece && !s.piece.is_a?(piece_type) }
    end

    # Returns all squares with pieces that haven't moved
    #
    # @return [SquareSet]
    def unmoved
      select { |s| s.piece && s.piece.has_not_moved? }
    end

    # Returns all squares threatened by the specified player
    #
    # @param [Fixnum] player_number
    #   the player's number.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def threatened_by(player_number, game_state)
      _squares = occupied_by_player(player_number).map do |s|
        s.piece.potential_capture_squares(s, game_state).squares
      end.flatten.uniq

      self.class.new(squares: _squares)
    end
  end
end