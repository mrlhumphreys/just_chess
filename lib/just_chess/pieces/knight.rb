require 'just_chess/pieces/piece'

module JustChess

  # = Knight
  #
  # The piece that jumps over pieces 1v2h or 2v1h
  class Knight < Piece

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
      game_state.squares.not_orthogonal_or_diagonal(square).at_range(square,2).unoccupied_or_occupied_by_opponent(player_number)
    end
  end
end