describe JustChess::King do
  it 'must be able to move 1 space away' do
    king = JustChess::King.new(id: 1, player_number: 1)
    other_king = JustChess::King.new(id: 2, player_number: 2)

    other_king_square = JustChess::Square.new(id: 'a8', x: 0, y: 0, piece: other_king)
    from = JustChess::Square.new(id: 'e4', x: 4, y: 4, piece: king)
    to = JustChess::Square.new(id: 'e3', x: 4, y: 5, piece: nil)

    squares = JustChess::SquareSet.new(squares: [from, to, other_king_square])

    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    assert king.can_move?(from, to, game_state)
  end

  it 'must not be able to move 2 spaces away' do
    king = JustChess::King.new(id: 1, player_number: 1)
    other_king = JustChess::King.new(id: 2, player_number: 2)

    other_king_square = JustChess::Square.new(id: 'a8', x: 0, y: 0, piece: other_king)
    from = JustChess::Square.new(id: 'e4', x: 4, y: 4, piece: king)
    to = JustChess::Square.new(id: 'e2', x: 4, y: 6, piece: nil)

    squares = JustChess::SquareSet.new(squares: [from, to, other_king_square])

    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    refute king.can_move?(from, to, game_state)
  end

  it 'must not be able to move near a king' do
    king = JustChess::King.new(id: 1, player_number: 1)
    other_king = JustChess::King.new(id: 2, player_number: 2)

    other_king_square = JustChess::Square.new(id: 'a8', x: 0, y: 0, piece: other_king)
    from = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: king)
    to = JustChess::Square.new(id: 'a7', x: 0, y: 1, piece: nil)

    squares = JustChess::SquareSet.new(squares: [from, to, other_king_square])

    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    refute king.can_move?(from, to, game_state)
  end

  it 'must be able to castle' do
    king = JustChess::King.new(id: 1, player_number: 1)
    rook = JustChess::Rook.new(id: 2, player_number: 1)

    king_square = JustChess::Square.new(id: 'e1', x: 4, y: 7, piece: king)
    square_a = JustChess::Square.new(id: 'f1', x: 5, y: 7, piece: nil)
    square_b = JustChess::Square.new(id: 'g1', x: 6, y: 7, piece: nil)
    rook_square = JustChess::Square.new(id: 'h1', x: 7, y: 7, piece: rook)

    squares = JustChess::SquareSet.new(squares: [king_square, square_a, square_b, rook_square])
    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    assert king.can_move?(king_square, square_b, game_state)
  end

  it 'must not be able to move into check' do
    king = JustChess::King.new(id: 1, player_number: 1)
    rook = JustChess::Rook.new(id: 2, player_number: 2)

    king_square = JustChess::Square.new(id: 'f1', x: 5, y: 7, piece: king)
    checked_square = JustChess::Square.new(id: 'g1', x: 6, y: 7, piece: nil)
    rook_square = JustChess::Square.new(id: 'h1', x: 7, y: 7, piece: rook)

    squares = JustChess::SquareSet.new(squares: [king_square, checked_square, rook_square])
    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    refute king.can_move?(king_square, checked_square, game_state)
  end
end