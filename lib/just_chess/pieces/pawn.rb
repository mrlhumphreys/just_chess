require 'just_chess/pieces/piece'
require 'just_chess/vector.rb'

module JustChess

  # = Pawn
  #
  # The piece that moves 1 forward or 2 forwards the first time, or 1 diagonal to capture.
  class Pawn < Piece

    # The forwards direction of the pawn for each player.
    FORWARDS_DIRECTION = { 1 => -1, 2 => 1 }

    # THe starting rank of the pawn for each player
    STARTING_RANK = { 1 => 6, 2 => 1 }

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
      moves = move_squares(square, game_state)
      captures = capture_squares(square, game_state)
      en_passant = en_passant_square(square, game_state)

      if en_passant
        (moves + captures) << en_passant
      else
        moves + captures
      end
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
      game_state.squares.in_range(square, range(square)).in_direction(square, forwards_direction).orthogonal(square).unoccupied.unblocked(square, game_state.squares)
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
      game_state.squares.in_range(square, 1).in_direction(square, forwards_direction).diagonal(square).occupied_by_opponent(player_number)
    end

    # The Square that a pawn can capture en passant.
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [Square]
    def en_passant_square(square, game_state)
      if square.rank_number(player_number) == 5 && game_state.last_double_step_pawn_id
        double_step = game_state.squares.find_by_piece_id(game_state.last_double_step_pawn_id)
        vector = Vector.new(square, double_step)
        if vector.magnitude.abs == 1
          x = double_step.x
          y = square.y + forwards_direction
          game_state.squares.find_by_x_and_y(x, y)
        else
          nil
        end
      else
        nil
      end
    end

    private

    def range(from)
      from.y == starting_rank ? 2 : 1
    end

    def forwards_direction
      FORWARDS_DIRECTION[player_number]
    end

    def starting_rank
      STARTING_RANK[player_number]
    end
  end
end