require 'just_chess/pieces/piece'

module JustChess

  # = King
  #
  # The piece that moves 1 space away. Can castle and must not be put into check.
  class King < Piece

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
      base_destinations(square, game_state) + castle(square, game_state) - checked_squares(square, game_state) - shared_king_squares(game_state)
    end

    # All the squares that the king could move to normally.
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def base_destinations(square, game_state)
      game_state.squares.at_range(square, 1).unoccupied_or_occupied_by_opponent(player_number)
    end

    # All the squares that the king could castle to.
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def castle(square, game_state)
      rooks = game_state.squares.occupied_by_piece(Rook).occupied_by_player(player_number).unmoved()

      if has_not_moved? && rooks.any?
        _squares = rooks.map do |s|
          vector = Vector.new(square, s)
          x = square.x + (2 * vector.direction.x)
          y = square.y
          game_state.squares.find_by_x_and_y(x, y)
        end

        potential = SquareSet.new(squares: _squares)

        potential.unoccupied().unblocked(square, game_state.squares)
      else
        SquareSet.new(squares: [])
      end
    end

    # All the squares that the king could not move to because of check.
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def checked_squares(square, game_state)
      dup = game_state.clone
      dup.squares.find_king_for_player(player_number).piece = nil
      dup.squares.threatened_by(opponent, dup)
    end

    # All the squares that the king could not move to because another king is nearby.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def shared_king_squares(game_state)
      all = game_state.squares.occupied_by_piece(King).map { |s| s.piece.base_destinations(s, game_state) }

      all.reduce(nil) do |memo, set|
        if memo
          memo & set
        else
          set
        end
      end
    end
  end
end