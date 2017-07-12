describe JustChess::Rook do
  it 'must be able to move horizontally' do
    rook = JustChess::Rook.new(id: 1, player_number: 1)
    from = JustChess::Square.new(id: 'e4', x: 4, y: 4, piece: rook)
    to = JustChess::Square.new(id: 'e2', x: 4, y: 6, piece: nil)

    squares = JustChess::SquareSet.new(squares: [from, to])

    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    assert rook.can_move?(from, to, game_state)
  end

  it 'must not be able to move diagonally' do
    rook = JustChess::Rook.new(id: 1, player_number: 1)
    from = JustChess::Square.new(id: 'e4', x: 4, y: 4, piece: rook)
    to = JustChess::Square.new(id: 'g2', x: 6, y: 6, piece: nil)

    squares = JustChess::SquareSet.new(squares: [from, to])

    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    refute rook.can_move?(from, to, game_state)
  end
end