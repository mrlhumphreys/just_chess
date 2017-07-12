describe JustChess::Knight do
  it 'must be able to move in an l shape' do
    knight = JustChess::Knight.new(id: 1, player_number: 1)
    from = JustChess::Square.new(id: 'e4', x: 4, y: 4, piece: knight)
    to = JustChess::Square.new(id: 'f2', x: 5, y: 6, piece: nil)

    squares = JustChess::SquareSet.new(squares: [from, to])

    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    assert knight.can_move?(from, to, game_state)
  end

  it 'must not be able to move diagonally' do
    knight = JustChess::Knight.new(id: 1, player_number: 1)
    from = JustChess::Square.new(id: 'e4', x: 4, y: 4, piece: knight)
    to = JustChess::Square.new(id: 'g2', x: 6, y: 6, piece: nil)

    squares = JustChess::SquareSet.new(squares: [from, to])

    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    refute knight.can_move?(from, to, game_state)
  end

  it 'must not be able to move orthogonally' do
    knight = JustChess::Knight.new(id: 1, player_number: 1)
    from = JustChess::Square.new(id: 'e4', x: 4, y: 4, piece: knight)
    to = JustChess::Square.new(id: 'e2', x: 4, y: 6, piece: nil)

    squares = JustChess::SquareSet.new(squares: [from, to])

    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    refute knight.can_move?(from, to, game_state)
  end

  it 'must not be able to move 3 spaces away' do
    knight = JustChess::Knight.new(id: 1, player_number: 1)
    from = JustChess::Square.new(id: 'e4', x: 4, y: 4, piece: knight)
    to = JustChess::Square.new(id: 'f1', x: 5, y: 7, piece: nil)

    squares = JustChess::SquareSet.new(squares: [from, to])

    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    refute knight.can_move?(from, to, game_state)
  end

  it 'must be able to move 2 spaces away' do
    knight = JustChess::Knight.new(id: 1, player_number: 1)
    from = JustChess::Square.new(id: 'e4', x: 4, y: 4, piece: knight)
    to = JustChess::Square.new(id: 'f2', x: 5, y: 6, piece: nil)

    squares = JustChess::SquareSet.new(squares: [from, to])

    game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

    assert knight.can_move?(from, to, game_state)
  end
end