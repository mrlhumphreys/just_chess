require 'just_chess/errors/no_piece_error'
require 'just_chess/errors/not_players_turn_error'
require 'just_chess/errors/invalid_move_error'
require 'just_chess/errors/invalid_promotion_error'
require 'just_chess/errors/moved_into_check_error'
require 'just_chess/square_set'
require 'board_game_grid'

module JustChess

  # = Game State
  #
  # Represents a game of Chess in progress.
  class GameState

    # They piece types that a pawn can promote to.
    PROMOTABLE_PIECE_TYPES = ['queen', 'knight', 'bishop', 'rook']

    def initialize(current_player_number: , squares: [], last_double_step_pawn_id: nil)
      @current_player_number = current_player_number
      @squares = if squares.is_a?(SquareSet)
        squares
      else
        SquareSet.new(squares: squares)
      end
      @last_double_step_pawn_id = last_double_step_pawn_id
      @last_change = {}
      @errors = []
    end

    attr_reader :current_player_number, :squares, :last_change, :errors, :last_double_step_pawn_id

    # Instantiates a new GameState object in the starting position
    #
    # @return [GameState]
    def self.default
      new({
        current_player_number: 1,
        squares: [
          { id: 'a8', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'rook' } },
          { id: 'b8', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'knight' } },
          { id: 'c8', x: 2, y: 0, piece: { id: 3, player_number: 2, type: 'bishop' } },
          { id: 'd8', x: 3, y: 0, piece: { id: 4, player_number: 2, type: 'queen' } },
          { id: 'e8', x: 4, y: 0, piece: { id: 5, player_number: 2, type: 'king' } },
          { id: 'f8', x: 5, y: 0, piece: { id: 6, player_number: 2, type: 'bishop' } },
          { id: 'g8', x: 6, y: 0, piece: { id: 7, player_number: 2, type: 'knight' } },
          { id: 'h8', x: 7, y: 0, piece: { id: 8, player_number: 2, type: 'rook' } },

          { id: 'a7', x: 0, y: 1, piece: { id: 9, player_number: 2, type: 'pawn' } },
          { id: 'b7', x: 1, y: 1, piece: { id: 10, player_number: 2, type: 'pawn' } },
          { id: 'c7', x: 2, y: 1, piece: { id: 11, player_number: 2, type: 'pawn' } },
          { id: 'd7', x: 3, y: 1, piece: { id: 12, player_number: 2, type: 'pawn' } },
          { id: 'e7', x: 4, y: 1, piece: { id: 13, player_number: 2, type: 'pawn' } },
          { id: 'f7', x: 5, y: 1, piece: { id: 14, player_number: 2, type: 'pawn' } },
          { id: 'g7', x: 6, y: 1, piece: { id: 15, player_number: 2, type: 'pawn' } },
          { id: 'h7', x: 7, y: 1, piece: { id: 16, player_number: 2, type: 'pawn' } },

          { id: 'a6', x: 0, y: 2, piece: nil },
          { id: 'b6', x: 1, y: 2, piece: nil },
          { id: 'c6', x: 2, y: 2, piece: nil },
          { id: 'd6', x: 3, y: 2, piece: nil },
          { id: 'e6', x: 4, y: 2, piece: nil },
          { id: 'f6', x: 5, y: 2, piece: nil },
          { id: 'g6', x: 6, y: 2, piece: nil },
          { id: 'h6', x: 7, y: 2, piece: nil },

          { id: 'a5', x: 0, y: 3, piece: nil },
          { id: 'b5', x: 1, y: 3, piece: nil },
          { id: 'c5', x: 2, y: 3, piece: nil },
          { id: 'd5', x: 3, y: 3, piece: nil },
          { id: 'e5', x: 4, y: 3, piece: nil },
          { id: 'f5', x: 5, y: 3, piece: nil },
          { id: 'g5', x: 6, y: 3, piece: nil },
          { id: 'h5', x: 7, y: 3, piece: nil },

          { id: 'a4', x: 0, y: 4, piece: nil },
          { id: 'b4', x: 1, y: 4, piece: nil },
          { id: 'c4', x: 2, y: 4, piece: nil },
          { id: 'd4', x: 3, y: 4, piece: nil },
          { id: 'e4', x: 4, y: 4, piece: nil },
          { id: 'f4', x: 5, y: 4, piece: nil },
          { id: 'g4', x: 6, y: 4, piece: nil },
          { id: 'h4', x: 7, y: 4, piece: nil },

          { id: 'a3', x: 0, y: 5, piece: nil },
          { id: 'b3', x: 1, y: 5, piece: nil },
          { id: 'c3', x: 2, y: 5, piece: nil },
          { id: 'd3', x: 3, y: 5, piece: nil },
          { id: 'e3', x: 4, y: 5, piece: nil },
          { id: 'f3', x: 5, y: 5, piece: nil },
          { id: 'g3', x: 6, y: 5, piece: nil },
          { id: 'h3', x: 7, y: 5, piece: nil },

          { id: 'a2', x: 0, y: 6, piece: { id: 17, player_number: 1, type: 'pawn' } },
          { id: 'b2', x: 1, y: 6, piece: { id: 18, player_number: 1, type: 'pawn' } },
          { id: 'c2', x: 2, y: 6, piece: { id: 19, player_number: 1, type: 'pawn' } },
          { id: 'd2', x: 3, y: 6, piece: { id: 20, player_number: 1, type: 'pawn' } },
          { id: 'e2', x: 4, y: 6, piece: { id: 21, player_number: 1, type: 'pawn' } },
          { id: 'f2', x: 5, y: 6, piece: { id: 22, player_number: 1, type: 'pawn' } },
          { id: 'g2', x: 6, y: 6, piece: { id: 23, player_number: 1, type: 'pawn' } },
          { id: 'h2', x: 7, y: 6, piece: { id: 24, player_number: 1, type: 'pawn' } },

          { id: 'a1', x: 0, y: 7, piece: { id: 25, player_number: 1, type: 'rook' } },
          { id: 'b1', x: 1, y: 7, piece: { id: 26, player_number: 1, type: 'knight' } },
          { id: 'c1', x: 2, y: 7, piece: { id: 27, player_number: 1, type: 'bishop' } },
          { id: 'd1', x: 3, y: 7, piece: { id: 28, player_number: 1, type: 'queen' } },
          { id: 'e1', x: 4, y: 7, piece: { id: 29, player_number: 1, type: 'king' } },
          { id: 'f1', x: 5, y: 7, piece: { id: 30, player_number: 1, type: 'bishop' } },
          { id: 'g1', x: 6, y: 7, piece: { id: 31, player_number: 1, type: 'knight' } },
          { id: 'h1', x: 7, y: 7, piece: { id: 32, player_number: 1, type: 'rook' } },
        ]
      })
    end

    # serializes the game state as a hash
    #
    # @return [Hash]
    def as_json
      {
        current_player_number: current_player_number,
        squares: squares.as_json,
        last_double_step_pawn_id: last_double_step_pawn_id
      }
    end

    # deep clone of the game state
    #
    # @return [GameState]
    def clone
      self.class.new(as_json)
    end

    # Moves a piece owned by the player, from one square, to another, with an optional promotion.
    #
    # It moves the piece and returns true if the move is valid and it's the player's turn.
    # It returns false otherwise.
    #
    # ==== Example:
    #   # Moves a piece from a square to perform a move
    #   game_state.move(1, 'h7', 'h6')
    #
    # @param [Fixnum] player_number
    #   the player number, 1 or 2.
    #
    # @param [String] from_id
    #   the id of the from square
    #
    # @param [String] to_id
    #   the id of the to square
    #
    # @option [String] promote_to
    #   the type of the piece that the pawn will promote to
    #
    # @return [Boolean]
    def move(player_number, from_id, to_id, promote_to=nil)
      @errors = []

      from = squares.find_by_id(from_id)
      to = squares.find_by_id(to_id)

      if current_player_number != player_number
        @errors.push JustChess::NotPlayersTurnError.new
      elsif from.unoccupied?
        @errors.push JustChess::NoPieceError.new
      elsif !((0..7).include?(to.x) && (0..7).include?(to.y))
        @errors.push JustChess::OffBoardError.new
      elsif !promote_to.nil? && !PROMOTABLE_PIECE_TYPES.include?(promote_to)
        @errors.push JustChess::InvalidPromotion.new
      elsif from.piece.can_move?(from, to, self)

        duplicate = self.clone
        duplicate.perform_complete_move(player_number, from_id, to_id, promote_to)

        if duplicate.in_check?(current_player_number)
          @errors.push JustChess::MovedIntoCheckError.new
        else
          perform_complete_move(player_number, from_id, to_id, promote_to)
        end
      else
        @errors.push JustChess::InvalidMoveError.new
      end
      @errors.empty?
    end

    # The player number of the winner. It returns nil if there is no winner.
    #
    # @return [Fixnum,NilClass]
    def winner
      case
      when in_checkmate?(1)
        2
      when in_checkmate?(2)
        1
      else
        nil
      end
    end

    # Moves a piece owned by the player, from one square, to another, with an optional promotion without validation
    #
    # It handles castling, en passant and promotion.
    # It moves the piece and returns true if the move is valid and it's the player's turn.
    # It returns false otherwise.
    #
    # ==== Example:
    #   # Moves a piece from a square to perform a move
    #   game_state.move(1, 'h7', 'h6')
    #
    # @param [Fixnum] player_number
    #   the player number, 1 or 2.
    #
    # @param [String] from_id
    #   the id of the from square
    #
    # @param [String] to_id
    #   the id of the to square
    #
    # @option [String] promote_to
    #   the type of the piece that the pawn will promote to
    #
    # @return [Boolean]
    def perform_complete_move(player_number, from_id, to_id, promote_to=nil)
      from = squares.find_by_id(from_id)
      to = squares.find_by_id(to_id)

      captured = captured_square(from, to)
      double_step_pawn = from.piece.is_a?(JustChess::Pawn) && BoardGameGrid::Vector.new(from,to).magnitude == 2
      @last_double_step_pawn_id = double_step_pawn ? from.piece.id : nil

      @last_change = { type: 'move', data: {player_number: player_number, from: from_id, to: to_id} }

      rook_castle = rook_castle_move(from, to)
      perform_move(rook_castle.from, rook_castle.to, nil) if rook_castle

      perform_move(from, to, captured)

      promote(to, promote_to) if pawn_moved_to_last_rank(to)
      pass_turn
    end

    def in_check?(player_number)
      king_square = squares.find_king_for_player(player_number)
      threatened_by = squares.threatened_by(opposing_player_number(player_number), self)
      threatened_by.include?(king_square)
    end

    def in_checkmate?(player_number)
      (in_check?(player_number) || non_king_pieces_cannot_move?(player_number)) && king_cannot_move?(player_number)
    end

    def non_king_pieces_cannot_move?(player_number)
      squares.occupied_by_player(player_number).excluding_piece(JustChess::King).all? { |s| s.piece.destinations(s, self).empty? }
    end

    def king_cannot_move?(player_number)
      king_square = squares.find_king_for_player(player_number)
      threatened_by = squares.threatened_by(opposing_player_number(player_number), self)
      destinations = king_square.piece.destinations(king_square, self)
      remove_threats = destinations - threatened_by
      remove_threats.none?
    end

    private

    def captured_square(from, to)
      if to.occupied?
        to
      else
        if from.piece.is_a?(Pawn) && from.piece.en_passant_square(from, self)
          squares.find_by_piece_id(last_double_step_pawn_id)
        else
          nil
        end
      end
    end

    def rook_castle_move(from, to)
      if from.occupied? && from.piece.is_a?(King) && from.piece.castle(from, self).include?(to)
        vector = BoardGameGrid::Vector.new(from, to)

        rook_from_x = vector.direction.x > 0 ? 7 : 0
        rook_from_y = from.y
        rook_from = squares.find_by_x_and_y(rook_from_x, rook_from_y)

        rook_to_x = vector.direction.x > 0 ? (from.x + 1) : (from.x -1)
        rook_to_y = from.y
        rook_to = squares.find_by_x_and_y(rook_to_x, rook_to_y)

        Struct.new(:from, :to).new(rook_from, rook_to)
      else
        nil
      end
    end

    def pawn_moved_to_last_rank(square)
      square.piece && square.piece.is_a?(Pawn) && square.last_rank(square.piece.player_number)
    end

    def pass_turn
      @current_player_number = opposing_player_number
    end

    def opposing_player_number(player_number=nil)
      if player_number
        other_player_number(player_number)
      else
        other_player_number(@current_player_number)
      end
    end

    def other_player_number(player_number)
      (player_number == 1) ? 2 : 1
    end

    def perform_move(from, to, captured)
      captured.piece = nil if captured
      to.piece = from.piece
      from.piece = nil
      to.piece.moved
    end

    def promote(square, promote_to)
      new_piece = PieceFactory.new(type: promote_to, id: square.piece.id, player_number: square.piece.player_number).build
      square.piece = new_piece
    end
  end
end