describe JustChess::Queen do
  it 'must be able to move horizontally' do
    queen = JustChess::Queen.new(id: 1, player_number: 1)
    from = JustChess::Square.new(id: 'e4', x: 4, y: 4, piece: queen)
    to = JustChess::Square.new(id: 'e2', x: 4, y: 6, piece: nil)

    squares = JustChess::SquareSet.new(squares: [from, to])

    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    assert queen.can_move?(from, to, game_state)
  end

  it 'must be able to move diagonally' do
    queen = JustChess::Queen.new(id: 1, player_number: 1)
    from = JustChess::Square.new(id: 'e4', x: 4, y: 4, piece: queen)
    to = JustChess::Square.new(id: 'g2', x: 6, y: 6, piece: nil)

    squares = JustChess::SquareSet.new(squares: [from, to])

    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    assert queen.can_move?(from, to, game_state)
  end

  it 'must not be able to move in an l shape' do
    queen = JustChess::Queen.new(id: 1, player_number: 1)
    from = JustChess::Square.new(id: 'e4', x: 4, y: 4, piece: queen)
    to = JustChess::Square.new(id: 'g3', x: 6, y: 5, piece: nil)

    squares = JustChess::SquareSet.new(squares: [from, to])

    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    refute queen.can_move?(from, to, game_state)
  end
end