require 'minitest/autorun'
require 'minitest/spec'
require 'just_chess/game_state'

en_passant_state = JustChess::GameState.new(
  current_player_number: 1,
  last_double_step_pawn_id: 10,
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
    { id: 'b7', x: 1, y: 1, piece: nil },
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

    { id: 'a5', x: 0, y: 3, piece: { id: 17, player_number: 1, type: 'pawn' } },
    { id: 'b5', x: 1, y: 3, piece: { id: 10, player_number: 2, type: 'pawn' } },
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

    { id: 'a2', x: 0, y: 6, piece: nil },
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
)

castle_state = JustChess::GameState.new(
  current_player_number: 1,
  last_double_step_pawn_id: nil,
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
    { id: 'b7', x: 1, y: 1, piece: nil },
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

    { id: 'a5', x: 0, y: 3, piece: { id: 17, player_number: 1, type: 'pawn' } },
    { id: 'b5', x: 1, y: 3, piece: { id: 10, player_number: 2, type: 'pawn' } },
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

    { id: 'a2', x: 0, y: 6, piece: nil },
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
    { id: 'f1', x: 5, y: 7, piece: nil },
    { id: 'g1', x: 6, y: 7, piece: nil },
    { id: 'h1', x: 7, y: 7, piece: { id: 32, player_number: 1, type: 'rook' } },
  ]
)

promotion_state = JustChess::GameState.new(
  current_player_number: 1,
  last_double_step_pawn_id: nil,
  squares: [
    { id: 'a8', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'rook' } },
    { id: 'b8', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'knight' } },
    { id: 'c8', x: 2, y: 0, piece: { id: 3, player_number: 2, type: 'bishop' } },
    { id: 'd8', x: 3, y: 0, piece: { id: 4, player_number: 2, type: 'queen' } },
    { id: 'e8', x: 4, y: 0, piece: { id: 5, player_number: 2, type: 'king' } },
    { id: 'f8', x: 5, y: 0, piece: { id: 6, player_number: 2, type: 'bishop' } },
    { id: 'g8', x: 6, y: 0, piece: { id: 7, player_number: 2, type: 'knight' } },
    { id: 'h8', x: 7, y: 0, piece: nil },

    { id: 'a7', x: 0, y: 1, piece: { id: 9, player_number: 2, type: 'pawn' } },
    { id: 'b7', x: 1, y: 1, piece: nil },
    { id: 'c7', x: 2, y: 1, piece: { id: 11, player_number: 2, type: 'pawn' } },
    { id: 'd7', x: 3, y: 1, piece: { id: 12, player_number: 2, type: 'pawn' } },
    { id: 'e7', x: 4, y: 1, piece: { id: 13, player_number: 2, type: 'pawn' } },
    { id: 'f7', x: 5, y: 1, piece: { id: 14, player_number: 2, type: 'pawn' } },
    { id: 'g7', x: 6, y: 1, piece: { id: 15, player_number: 2, type: 'pawn' } },
    { id: 'h7', x: 7, y: 1, piece: { id: 24, player_number: 1, type: 'pawn' } },

    { id: 'a6', x: 0, y: 2, piece: nil },
    { id: 'b6', x: 1, y: 2, piece: nil },
    { id: 'c6', x: 2, y: 2, piece: nil },
    { id: 'd6', x: 3, y: 2, piece: nil },
    { id: 'e6', x: 4, y: 2, piece: nil },
    { id: 'f6', x: 5, y: 2, piece: nil },
    { id: 'g6', x: 6, y: 2, piece: nil },
    { id: 'h6', x: 7, y: 2, piece: nil },

    { id: 'a5', x: 0, y: 3, piece: { id: 17, player_number: 1, type: 'pawn' } },
    { id: 'b5', x: 1, y: 3, piece: { id: 10, player_number: 2, type: 'pawn' } },
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

    { id: 'a2', x: 0, y: 6, piece: nil },
    { id: 'b2', x: 1, y: 6, piece: { id: 18, player_number: 1, type: 'pawn' } },
    { id: 'c2', x: 2, y: 6, piece: { id: 19, player_number: 1, type: 'pawn' } },
    { id: 'd2', x: 3, y: 6, piece: { id: 20, player_number: 1, type: 'pawn' } },
    { id: 'e2', x: 4, y: 6, piece: { id: 21, player_number: 1, type: 'pawn' } },
    { id: 'f2', x: 5, y: 6, piece: { id: 22, player_number: 1, type: 'pawn' } },
    { id: 'g2', x: 6, y: 6, piece: { id: 23, player_number: 1, type: 'pawn' } },
    { id: 'h2', x: 7, y: 6, piece: nil },

    { id: 'a1', x: 0, y: 7, piece: { id: 25, player_number: 1, type: 'rook' } },
    { id: 'b1', x: 1, y: 7, piece: { id: 26, player_number: 1, type: 'knight' } },
    { id: 'c1', x: 2, y: 7, piece: { id: 27, player_number: 1, type: 'bishop' } },
    { id: 'd1', x: 3, y: 7, piece: { id: 28, player_number: 1, type: 'queen' } },
    { id: 'e1', x: 4, y: 7, piece: { id: 29, player_number: 1, type: 'king' } },
    { id: 'f1', x: 5, y: 7, piece: nil },
    { id: 'g1', x: 6, y: 7, piece: nil },
    { id: 'h1', x: 7, y: 7, piece: { id: 32, player_number: 1, type: 'rook' } },
  ]
)

potential_check_state = JustChess::GameState.new(
  current_player_number: 1,
  last_double_step_pawn_id: nil,
  squares: [
    { id: 'a8', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'rook' } },
    { id: 'b8', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'knight' } },
    { id: 'c8', x: 2, y: 0, piece: { id: 3, player_number: 2, type: 'bishop' } },
    { id: 'd8', x: 3, y: 0, piece: { id: 4, player_number: 2, type: 'queen' } },
    { id: 'e8', x: 4, y: 0, piece: nil },
    { id: 'f8', x: 5, y: 0, piece: { id: 6, player_number: 2, type: 'bishop' } },
    { id: 'g8', x: 6, y: 0, piece: { id: 7, player_number: 2, type: 'knight' } },
    { id: 'h8', x: 7, y: 0, piece: nil },

    { id: 'a7', x: 0, y: 1, piece: { id: 9, player_number: 2, type: 'pawn' } },
    { id: 'b7', x: 1, y: 1, piece: nil },
    { id: 'c7', x: 2, y: 1, piece: { id: 11, player_number: 2, type: 'pawn' } },
    { id: 'd7', x: 3, y: 1, piece: { id: 12, player_number: 2, type: 'rook' } },
    { id: 'e7', x: 4, y: 1, piece: { id: 13, player_number: 2, type: 'pawn' } },
    { id: 'f7', x: 5, y: 1, piece: { id: 14, player_number: 2, type: 'pawn' } },
    { id: 'g7', x: 6, y: 1, piece: { id: 15, player_number: 2, type: 'pawn' } },
    { id: 'h7', x: 7, y: 1, piece: { id: 24, player_number: 1, type: 'pawn' } },

    { id: 'a6', x: 0, y: 2, piece: nil },
    { id: 'b6', x: 1, y: 2, piece: nil },
    { id: 'c6', x: 2, y: 2, piece: nil },
    { id: 'd6', x: 3, y: 2, piece: nil },
    { id: 'e6', x: 4, y: 2, piece: nil },
    { id: 'f6', x: 5, y: 2, piece: nil },
    { id: 'g6', x: 6, y: 2, piece: nil },
    { id: 'h6', x: 7, y: 2, piece: nil },

    { id: 'a5', x: 0, y: 3, piece: { id: 17, player_number: 1, type: 'pawn' } },
    { id: 'b5', x: 1, y: 3, piece: { id: 10, player_number: 2, type: 'pawn' } },
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
    { id: 'f3', x: 5, y: 5, piece: { id: 5, player_number: 2, type: 'king' } },
    { id: 'g3', x: 6, y: 5, piece: nil },
    { id: 'h3', x: 7, y: 5, piece: nil },

    { id: 'a2', x: 0, y: 6, piece: nil },
    { id: 'b2', x: 1, y: 6, piece: { id: 18, player_number: 1, type: 'pawn' } },
    { id: 'c2', x: 2, y: 6, piece: { id: 19, player_number: 1, type: 'pawn' } },
    { id: 'd2', x: 3, y: 6, piece: nil },
    { id: 'e2', x: 4, y: 6, piece: nil },
    { id: 'f2', x: 5, y: 6, piece: nil },
    { id: 'g2', x: 6, y: 6, piece: nil },
    { id: 'h2', x: 7, y: 6, piece: nil },

    { id: 'a1', x: 0, y: 7, piece: { id: 25, player_number: 1, type: 'rook' } },
    { id: 'b1', x: 1, y: 7, piece: { id: 26, player_number: 1, type: 'knight' } },
    { id: 'c1', x: 2, y: 7, piece: { id: 27, player_number: 1, type: 'bishop' } },
    { id: 'd1', x: 3, y: 7, piece: nil },
    { id: 'e1', x: 4, y: 7, piece: { id: 29, player_number: 1, type: 'king' } },
    { id: 'f1', x: 5, y: 7, piece: nil },
    { id: 'g1', x: 6, y: 7, piece: nil },
    { id: 'h1', x: 7, y: 7, piece: { id: 32, player_number: 1, type: 'rook' } },
  ]
)

check_state = JustChess::GameState.new(
  current_player_number: 1,
  last_double_step_pawn_id: nil,
  squares: [
    { id: 'a8', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'rook' } },
    { id: 'b8', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'knight' } },
    { id: 'c8', x: 2, y: 0, piece: { id: 3, player_number: 2, type: 'bishop' } },
    { id: 'd8', x: 3, y: 0, piece: { id: 4, player_number: 2, type: 'queen' } },
    { id: 'e8', x: 4, y: 0, piece: nil },
    { id: 'f8', x: 5, y: 0, piece: { id: 6, player_number: 2, type: 'bishop' } },
    { id: 'g8', x: 6, y: 0, piece: { id: 7, player_number: 2, type: 'knight' } },
    { id: 'h8', x: 7, y: 0, piece: nil },

    { id: 'a7', x: 0, y: 1, piece: { id: 9, player_number: 2, type: 'pawn' } },
    { id: 'b7', x: 1, y: 1, piece: nil },
    { id: 'c7', x: 2, y: 1, piece: { id: 11, player_number: 2, type: 'pawn' } },
    { id: 'd7', x: 3, y: 1, piece: { id: 12, player_number: 2, type: 'rook' } },
    { id: 'e7', x: 4, y: 1, piece: { id: 13, player_number: 2, type: 'pawn' } },
    { id: 'f7', x: 5, y: 1, piece: { id: 14, player_number: 2, type: 'pawn' } },
    { id: 'g7', x: 6, y: 1, piece: { id: 15, player_number: 2, type: 'pawn' } },
    { id: 'h7', x: 7, y: 1, piece: { id: 24, player_number: 1, type: 'pawn' } },

    { id: 'a6', x: 0, y: 2, piece: nil },
    { id: 'b6', x: 1, y: 2, piece: nil },
    { id: 'c6', x: 2, y: 2, piece: nil },
    { id: 'd6', x: 3, y: 2, piece: nil },
    { id: 'e6', x: 4, y: 2, piece: nil },
    { id: 'f6', x: 5, y: 2, piece: nil },
    { id: 'g6', x: 6, y: 2, piece: nil },
    { id: 'h6', x: 7, y: 2, piece: nil },

    { id: 'a5', x: 0, y: 3, piece: { id: 17, player_number: 1, type: 'pawn' } },
    { id: 'b5', x: 1, y: 3, piece: { id: 10, player_number: 2, type: 'pawn' } },
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
    { id: 'f3', x: 5, y: 5, piece: { id: 5, player_number: 2, type: 'king' } },
    { id: 'g3', x: 6, y: 5, piece: nil },
    { id: 'h3', x: 7, y: 5, piece: nil },

    { id: 'a2', x: 0, y: 6, piece: nil },
    { id: 'b2', x: 1, y: 6, piece: { id: 18, player_number: 1, type: 'pawn' } },
    { id: 'c2', x: 2, y: 6, piece: { id: 19, player_number: 1, type: 'pawn' } },
    { id: 'd2', x: 3, y: 6, piece: nil },
    { id: 'e2', x: 4, y: 6, piece: nil },
    { id: 'f2', x: 5, y: 6, piece: nil },
    { id: 'g2', x: 6, y: 6, piece: nil },
    { id: 'h2', x: 7, y: 6, piece: nil },

    { id: 'a1', x: 0, y: 7, piece: { id: 25, player_number: 1, type: 'rook' } },
    { id: 'b1', x: 1, y: 7, piece: { id: 26, player_number: 1, type: 'knight' } },
    { id: 'c1', x: 2, y: 7, piece: { id: 27, player_number: 1, type: 'bishop' } },
    { id: 'd1', x: 3, y: 7, piece: nil },
    { id: 'e1', x: 4, y: 7, piece: { id: 29, player_number: 1, type: 'king' } },
    { id: 'f1', x: 5, y: 7, piece: nil },
    { id: 'g1', x: 6, y: 7, piece: nil },
    { id: 'h1', x: 7, y: 7, piece: { id: 32, player_number: 1, type: 'rook' } },
  ]
)

check_state = JustChess::GameState.new(
  current_player_number: 1,
  last_double_step_pawn_id: nil,
  squares: [
    { id: 'a8', x: 0, y: 0, piece: nil },
    { id: 'b8', x: 1, y: 0, piece: nil },
    { id: 'c8', x: 2, y: 0, piece: nil },
    { id: 'd8', x: 3, y: 0, piece: nil },
    { id: 'e8', x: 4, y: 0, piece: nil },
    { id: 'f8', x: 5, y: 0, piece: nil },
    { id: 'g8', x: 6, y: 0, piece: nil },
    { id: 'h8', x: 7, y: 0, piece: nil },

    { id: 'a7', x: 0, y: 1, piece: nil },
    { id: 'b7', x: 1, y: 1, piece: nil },
    { id: 'c7', x: 2, y: 1, piece: nil },
    { id: 'd7', x: 3, y: 1, piece: nil },
    { id: 'e7', x: 4, y: 1, piece: nil },
    { id: 'f7', x: 5, y: 1, piece: nil },
    { id: 'g7', x: 6, y: 1, piece: nil },
    { id: 'h7', x: 7, y: 1, piece: nil },

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
    { id: 'h4', x: 7, y: 4, piece: { id: 1, player_number: 2, type: 'rook' } },

    { id: 'a3', x: 0, y: 5, piece: nil },
    { id: 'b3', x: 1, y: 5, piece: nil },
    { id: 'c3', x: 2, y: 5, piece: nil },
    { id: 'd3', x: 3, y: 5, piece: nil },
    { id: 'e3', x: 4, y: 5, piece: { id: 5, player_number: 2, type: 'king' } },
    { id: 'f3', x: 5, y: 5, piece: nil },
    { id: 'g3', x: 6, y: 5, piece: nil },
    { id: 'h3', x: 7, y: 5, piece: nil },

    { id: 'a2', x: 0, y: 6, piece: nil },
    { id: 'b2', x: 1, y: 6, piece: nil },
    { id: 'c2', x: 2, y: 6, piece: nil },
    { id: 'd2', x: 3, y: 6, piece: nil },
    { id: 'e2', x: 4, y: 6, piece: nil },
    { id: 'f2', x: 5, y: 6, piece: nil },
    { id: 'g2', x: 6, y: 6, piece: nil },
    { id: 'h2', x: 7, y: 6, piece: nil },

    { id: 'a1', x: 0, y: 7, piece: nil },
    { id: 'b1', x: 1, y: 7, piece: nil },
    { id: 'c1', x: 2, y: 7, piece: nil },
    { id: 'd1', x: 3, y: 7, piece: nil },
    { id: 'e1', x: 4, y: 7, piece: nil },
    { id: 'f1', x: 5, y: 7, piece: nil },
    { id: 'g1', x: 6, y: 7, piece: nil },
    { id: 'h1', x: 7, y: 7, piece: { id: 29, player_number: 1, type: 'king' } },
  ]
)

checkmate_state = JustChess::GameState.new(
  current_player_number: 1,
  last_double_step_pawn_id: nil,
  squares: [
    { id: 'a8', x: 0, y: 0, piece: nil },
    { id: 'b8', x: 1, y: 0, piece: nil },
    { id: 'c8', x: 2, y: 0, piece: nil },
    { id: 'd8', x: 3, y: 0, piece: nil },
    { id: 'e8', x: 4, y: 0, piece: nil },
    { id: 'f8', x: 5, y: 0, piece: nil },
    { id: 'g8', x: 6, y: 0, piece: nil },
    { id: 'h8', x: 7, y: 0, piece: nil },

    { id: 'a7', x: 0, y: 1, piece: nil },
    { id: 'b7', x: 1, y: 1, piece: nil },
    { id: 'c7', x: 2, y: 1, piece: nil },
    { id: 'd7', x: 3, y: 1, piece: nil },
    { id: 'e7', x: 4, y: 1, piece: nil },
    { id: 'f7', x: 5, y: 1, piece: nil },
    { id: 'g7', x: 6, y: 1, piece: nil },
    { id: 'h7', x: 7, y: 1, piece: nil },

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
    { id: 'h4', x: 7, y: 4, piece: { id: 1, player_number: 2, type: 'rook' } },

    { id: 'a3', x: 0, y: 5, piece: nil },
    { id: 'b3', x: 1, y: 5, piece: nil },
    { id: 'c3', x: 2, y: 5, piece: nil },
    { id: 'd3', x: 3, y: 5, piece: nil },
    { id: 'e3', x: 4, y: 5, piece: { id: 5, player_number: 2, type: 'king' } },
    { id: 'f3', x: 5, y: 5, piece: nil },
    { id: 'g3', x: 6, y: 5, piece: { id: 12, player_number: 2, type: 'rook' } },
    { id: 'h3', x: 7, y: 5, piece: nil },

    { id: 'a2', x: 0, y: 6, piece: nil },
    { id: 'b2', x: 1, y: 6, piece: nil },
    { id: 'c2', x: 2, y: 6, piece: nil },
    { id: 'd2', x: 3, y: 6, piece: nil },
    { id: 'e2', x: 4, y: 6, piece: nil },
    { id: 'f2', x: 5, y: 6, piece: nil },
    { id: 'g2', x: 6, y: 6, piece: nil },
    { id: 'h2', x: 7, y: 6, piece: nil },

    { id: 'a1', x: 0, y: 7, piece: nil },
    { id: 'b1', x: 1, y: 7, piece: nil },
    { id: 'c1', x: 2, y: 7, piece: nil },
    { id: 'd1', x: 3, y: 7, piece: nil },
    { id: 'e1', x: 4, y: 7, piece: nil },
    { id: 'f1', x: 5, y: 7, piece: nil },
    { id: 'g1', x: 6, y: 7, piece: nil },
    { id: 'h1', x: 7, y: 7, piece: { id: 29, player_number: 1, type: 'king' } },
  ]
)

no_moves_state = JustChess::GameState.new(
  current_player_number: 2,
  last_double_step_pawn_id: nil,
  squares: [
    { id: 'a8', x: 0, y: 0, piece: nil },
    { id: 'b8', x: 1, y: 0, piece: nil },
    { id: 'c8', x: 2, y: 0, piece: nil },
    { id: 'd8', x: 3, y: 0, piece: nil },
    { id: 'e8', x: 4, y: 0, piece: nil },
    { id: 'f8', x: 5, y: 0, piece: nil },
    { id: 'g8', x: 6, y: 0, piece: nil },
    { id: 'h8', x: 7, y: 0, piece: nil },

    { id: 'a7', x: 0, y: 1, piece: nil },
    { id: 'b7', x: 1, y: 1, piece: nil },
    { id: 'c7', x: 2, y: 1, piece: nil },
    { id: 'd7', x: 3, y: 1, piece: nil },
    { id: 'e7', x: 4, y: 1, piece: nil },
    { id: 'f7', x: 5, y: 1, piece: nil },
    { id: 'g7', x: 6, y: 1, piece: nil },
    { id: 'h7', x: 7, y: 1, piece: nil },

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
    { id: 'd5', x: 3, y: 3, piece: { id: 29, player_number: 1, type: 'king' } },
    { id: 'e5', x: 4, y: 3, piece: nil },
    { id: 'f5', x: 5, y: 3, piece: nil },
    { id: 'g5', x: 6, y: 3, piece: nil },
    { id: 'h5', x: 7, y: 3, piece: { id: 28, player_number: 1, type: 'queen' } },

    { id: 'a4', x: 0, y: 4, piece: nil },
    { id: 'b4', x: 1, y: 4, piece: nil },
    { id: 'c4', x: 2, y: 4, piece: nil },
    { id: 'd4', x: 3, y: 4, piece: nil },
    { id: 'e4', x: 4, y: 4, piece: nil },
    { id: 'f4', x: 5, y: 4, piece: { id: 5, player_number: 2, type: 'king' } },
    { id: 'g4', x: 6, y: 4, piece: nil },
    { id: 'h4', x: 7, y: 4, piece: nil },

    { id: 'a3', x: 0, y: 5, piece: { id: 25, player_number: 1, type: 'rook' } },
    { id: 'b3', x: 1, y: 5, piece: nil },
    { id: 'c3', x: 2, y: 5, piece: nil },
    { id: 'd3', x: 3, y: 5, piece: nil },
    { id: 'e3', x: 4, y: 5, piece: nil },
    { id: 'f3', x: 5, y: 5, piece: nil },
    { id: 'g3', x: 6, y: 5, piece: nil },
    { id: 'h3', x: 7, y: 5, piece: nil },

    { id: 'a2', x: 0, y: 6, piece: nil },
    { id: 'b2', x: 1, y: 6, piece: nil },
    { id: 'c2', x: 2, y: 6, piece: nil },
    { id: 'd2', x: 3, y: 6, piece: nil },
    { id: 'e2', x: 4, y: 6, piece: nil },
    { id: 'f2', x: 5, y: 6, piece: nil },
    { id: 'g2', x: 6, y: 6, piece: nil },
    { id: 'h2', x: 7, y: 6, piece: nil },

    { id: 'a1', x: 0, y: 7, piece: nil },
    { id: 'b1', x: 1, y: 7, piece: nil },
    { id: 'c1', x: 2, y: 7, piece: nil },
    { id: 'd1', x: 3, y: 7, piece: nil },
    { id: 'e1', x: 4, y: 7, piece: nil },
    { id: 'f1', x: 5, y: 7, piece: nil },
    { id: 'g1', x: 6, y: 7, piece: nil },
    { id: 'h1', x: 7, y: 7, piece: nil },
  ]
)

no_moves_and_threatened_state = JustChess::GameState.new(
  :current_player_number=>1,
  :squares=>[
    {:id=>"a8", :x=>0, :y=>0, :piece=>nil},
    {:id=>"b8", :x=>1, :y=>0, :piece=>nil},
    {:id=>"c8", :x=>2, :y=>0, :piece=>nil},
    {:id=>"d8", :x=>3, :y=>0, :piece=>nil},
    {:id=>"e8", :x=>4, :y=>0, :piece=>nil},
    {:id=>"f8", :x=>5, :y=>0, :piece=>nil},
    {:id=>"g8", :x=>6, :y=>0, :piece=>{:id=>5, :player_number=>2, :type=>"king", :has_moved=>true}},
    {:id=>"h8", :x=>7, :y=>0, :piece=>nil},

    {:id=>"a7", :x=>0, :y=>1, :piece=>nil},
    {:id=>"b7", :x=>1, :y=>1, :piece=>nil},
    {:id=>"c7", :x=>2, :y=>1, :piece=>nil},
    {:id=>"d7", :x=>3, :y=>1, :piece=>nil},
    {:id=>"e7", :x=>4, :y=>1, :piece=>nil},
    {:id=>"f7", :x=>5, :y=>1, :piece=>{:id=>14, :player_number=>2, :type=>"pawn", :has_moved=>false}},
    {:id=>"g7", :x=>6, :y=>1, :piece=>{:id=>15, :player_number=>2, :type=>"pawn", :has_moved=>false}},
    {:id=>"h7", :x=>7, :y=>1, :piece=>nil},

    {:id=>"a6", :x=>0, :y=>2, :piece=>{:id=>32, :player_number=>1, :type=>"rook", :has_moved=>true}},
    {:id=>"b6", :x=>1, :y=>2, :piece=>nil},
    {:id=>"c6", :x=>2, :y=>2, :piece=>nil},
    {:id=>"d6", :x=>3, :y=>2, :piece=>nil},
    {:id=>"e6", :x=>4, :y=>2, :piece=>nil},
    {:id=>"f6", :x=>5, :y=>2, :piece=>nil},
    {:id=>"g6", :x=>6, :y=>2, :piece=>nil},
    {:id=>"h6", :x=>7, :y=>2, :piece=>{:id=>16, :player_number=>2, :type=>"pawn", :has_moved=>true}},

    {:id=>"a5", :x=>0, :y=>3, :piece=>nil},
    {:id=>"b5", :x=>1, :y=>3, :piece=>nil},
    {:id=>"c5", :x=>2, :y=>3, :piece=>nil},
    {:id=>"d5", :x=>3, :y=>3, :piece=>nil},
    {:id=>"e5", :x=>4, :y=>3, :piece=>nil},
    {:id=>"f5", :x=>5, :y=>3, :piece=>{:id=>1, :player_number=>2, :type=>"rook", :has_moved=>true}},
    {:id=>"g5", :x=>6, :y=>3, :piece=>{:id=>6, :player_number=>2, :type=>"bishop", :has_moved=>true}},
    {:id=>"h5", :x=>7, :y=>3, :piece=>nil},

    {:id=>"a4", :x=>0, :y=>4, :piece=>nil},
    {:id=>"b4", :x=>1, :y=>4, :piece=>nil},
    {:id=>"c4", :x=>2, :y=>4, :piece=>nil},
    {:id=>"d4", :x=>3, :y=>4, :piece=>nil},
    {:id=>"e4", :x=>4, :y=>4, :piece=>nil},
    {:id=>"f4", :x=>5, :y=>4, :piece=>nil},
    {:id=>"g4", :x=>6, :y=>4, :piece=>nil},
    {:id=>"h4", :x=>7, :y=>4, :piece=>nil},

    {:id=>"a3", :x=>0, :y=>5, :piece=>nil},
    {:id=>"b3", :x=>1, :y=>5, :piece=>nil},
    {:id=>"c3", :x=>2, :y=>5, :piece=>nil},
    {:id=>"d3", :x=>3, :y=>5, :piece=>{:id=>25, :player_number=>1, :type=>"rook", :has_moved=>true}},
    {:id=>"e3", :x=>4, :y=>5, :piece=>nil},
    {:id=>"f3", :x=>5, :y=>5, :piece=>nil},
    {:id=>"g3", :x=>6, :y=>5, :piece=>nil},
    {:id=>"h3", :x=>7, :y=>5, :piece=>{:id=>24, :player_number=>1, :type=>"pawn", :has_moved=>true}},

    {:id=>"a2", :x=>0, :y=>6, :piece=>{:id=>17, :player_number=>1, :type=>"pawn", :has_moved=>false}},
    {:id=>"b2", :x=>1, :y=>6, :piece=>{:id=>18, :player_number=>1, :type=>"pawn", :has_moved=>false}},
    {:id=>"c2", :x=>2, :y=>6, :piece=>nil},
    {:id=>"d2", :x=>3, :y=>6, :piece=>nil},
    {:id=>"e2", :x=>4, :y=>6, :piece=>nil},
    {:id=>"f2", :x=>5, :y=>6, :piece=>{:id=>22, :player_number=>1, :type=>"pawn", :has_moved=>false}},
    {:id=>"g2", :x=>6, :y=>6, :piece=>{:id=>23, :player_number=>1, :type=>"pawn", :has_moved=>false}},
    {:id=>"h2", :x=>7, :y=>6, :piece=>nil},

    {:id=>"a1", :x=>0, :y=>7, :piece=>nil},
    {:id=>"b1", :x=>1, :y=>7, :piece=>{:id=>29, :player_number=>1, :type=>"king", :has_moved=>true}},
    {:id=>"c1", :x=>2, :y=>7, :piece=>{:id=>8, :player_number=>2, :type=>"rook", :has_moved=>true}},
    {:id=>"d1", :x=>3, :y=>7, :piece=>nil},
    {:id=>"e1", :x=>4, :y=>7, :piece=>nil},
    {:id=>"f1", :x=>5, :y=>7, :piece=>nil},
    {:id=>"g1", :x=>6, :y=>7, :piece=>nil},
    {:id=>"h1", :x=>7, :y=>7, :piece=>nil}
  ],
  :last_double_step_pawn_id=>nil
)

describe JustChess::GameState do
  describe 'default' do
    it 'must set the current player to 1' do
      game_state = JustChess::GameState.default
      assert_equal 1, game_state.current_player_number
    end

    it 'must have 64 squares' do
      game_state = JustChess::GameState.default
      assert_equal 64, game_state.squares.size
    end
  end

  describe 'move' do
    describe 'with no issues' do
      it 'must move the piece' do
        game_state = JustChess::GameState.default

        result = game_state.move(1, 'a7', 'a6')
        from = game_state.squares.find_by_id('a7')
        to = game_state.squares.find_by_id('a6')

        assert result
        assert game_state.errors.empty?
        assert_equal({:type=>"move", :data=>{:player_number=>1, :from=>"a7", :to=>"a6"}}, game_state.last_change)
        assert from.unoccupied?
        assert_instance_of JustChess::Pawn, to.piece
      end
    end

    describe "not on the player's turn" do
      it 'must not move the piece' do
        game_state = JustChess::GameState.default

        result = game_state.move(2, 'a2', 'a3')
        from = game_state.squares.find_by_id('a2')
        to = game_state.squares.find_by_id('a3')

        refute result
        refute game_state.errors.empty?
        assert_equal({}, game_state.last_change)
        assert_instance_of JustChess::Pawn, from.piece
        assert to.unoccupied?
      end
    end

    describe "that's invalid" do
      it 'must move the piece' do
        game_state = JustChess::GameState.default

        result = game_state.move(1, 'a7', 'a4')
        from = game_state.squares.find_by_id('a7')
        to = game_state.squares.find_by_id('a4')

        refute result
        refute game_state.errors.empty?
        assert_equal({}, game_state.last_change)
        assert_instance_of JustChess::Pawn, from.piece
        assert to.unoccupied?
      end
    end

    describe 'en passant' do
      it 'must move the piece and remove the captured' do
        game_state = en_passant_state

        result = game_state.move(1, 'a5', 'b6')
        from = game_state.squares.find_by_id('a5')
        to = game_state.squares.find_by_id('b6')
        captured = game_state.squares.find_by_id('b5')

        assert result
        assert game_state.errors.empty?
        assert_equal({:type=>"move", :data=>{:player_number=>1, :from=>"a5", :to=>"b6"}}, game_state.last_change)
        assert from.unoccupied?
        assert_instance_of JustChess::Pawn, to.piece
        assert captured.unoccupied?
      end
    end

    describe 'castle' do
      it 'must move the king 2 spaces and the rook to the other side' do
        game_state = castle_state

        result = game_state.move(1, 'e1', 'g1')
        from = game_state.squares.find_by_id('e1')
        to = game_state.squares.find_by_id('g1')

        rook_from = game_state.squares.find_by_id('h1')
        rook_to = game_state.squares.find_by_id('f1')

        assert result
        assert game_state.errors.empty?
        assert_equal({:type=>"move", :data=>{:player_number=>1, :from=>"e1", :to=>"g1"}}, game_state.last_change)
        assert from.unoccupied?
        assert_instance_of JustChess::King, to.piece
        assert rook_from.unoccupied?
        assert_instance_of JustChess::Rook, rook_to.piece
      end
    end

    describe 'promotion' do
      it 'must move the pawn and change it' do
        game_state = promotion_state

        result = game_state.move(1, 'h7', 'h8', 'queen')
        from = game_state.squares.find_by_id('h7')
        to = game_state.squares.find_by_id('h8')

        assert result
        assert game_state.errors.empty?
        assert_equal({:type=>"move", :data=>{:player_number=>1, :from=>"h7", :to=>"h8"}}, game_state.last_change)
        assert from.unoccupied?
        assert_instance_of JustChess::Queen, to.piece
      end
    end

    describe 'king threatened' do
      it 'must be in check state' do
        game_state = check_state

        assert game_state.in_check?(1)
        refute game_state.in_check?(2)

        refute game_state.in_checkmate?(1)
        refute game_state.in_checkmate?(2)

        refute game_state.winner
      end
    end

    describe 'king in potential check' do
      it 'must not be able to move into check' do
        game_state = potential_check_state

        result = game_state.move(1, 'e1', 'd1')
        from = game_state.squares.find_by_id('e1')
        to = game_state.squares.find_by_id('d1')

        refute result
        refute game_state.errors.empty?
        assert_equal({}, game_state.last_change)

        assert_instance_of JustChess::King, from.piece
        assert to.unoccupied?
      end
    end

    describe 'king cannot move and will be captured next turn' do
      it 'king must be in checkmate' do
        game_state = checkmate_state

        assert game_state.in_check?(1)

        assert game_state.in_checkmate?(1)
        refute game_state.in_checkmate?(2)

        assert_equal 2, game_state.winner
      end
    end

    describe 'king has no moves and is not threatened' do
      it 'king must be in checkmate' do
        game_state = no_moves_state

        assert game_state.in_checkmate?(2)
        refute game_state.in_checkmate?(1)

        assert_equal 1, game_state.winner
      end
    end

    describe 'king has no moves and is threatened' do
      it 'king must be in checkmate' do
        game_state = no_moves_and_threatened_state

        assert game_state.in_checkmate?(1)
        refute game_state.in_checkmate?(2)

        assert_equal 2, game_state.winner
      end
    end
  end
end
