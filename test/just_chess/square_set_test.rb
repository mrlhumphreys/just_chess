describe JustChess::SquareSet do
  describe 'with hash' do
    it 'initializes' do
      squares = JustChess::SquareSet.new(squares: [{ id: 'a6', x: 0, y: 2, piece: nil }])
      assert_equal 1, squares.size
    end
  end

  describe 'with squares' do
    it 'initializes' do
      square = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: nil)
      squares = JustChess::SquareSet.new(squares: [square])
      assert_equal 1, squares.size
    end
  end

  describe 'find_king_for_player' do
    it 'returns the king owned by that player' do
      king_square = JustChess::Square.new(id: 'e8', x: 4, y: 0, piece: { id: 5, player_number: 2, type: 'king' })
      not_king_square = JustChess::Square.new(id: 'f8', x: 5, y: 0, piece: { id: 6, player_number: 2, type: 'bishop' })

      square_set = JustChess::SquareSet.new(squares: [king_square, not_king_square])

      result = square_set.find_king_for_player(2)

      assert_equal king_square, result
    end
  end

  describe 'unmoved' do
    it 'returns squares with pieces that have yet to move' do
      moved = JustChess::Pawn.new(id: 1, player_number: 1, has_moved: true)
      unmoved = JustChess::Rook.new(id: 2, player_number: 1, has_moved: false)
      with_moved = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: moved)
      with_unmoved = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: unmoved)

      squares = JustChess::SquareSet.new(squares: [with_moved, with_unmoved])

      filtered = squares.unmoved

      assert_includes filtered, with_unmoved
      refute_includes filtered, with_moved
    end
  end

  describe 'threatend_by' do
    it 'returns squares threatened by a player' do
      attacker = JustChess::Rook.new(id: 2, player_number: 1, has_moved: false)
      attacker_square = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: attacker)
      threatened_square = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: nil)
      ignored_square = JustChess::Square.new(id: 'b3', x: 1, y: 5, piece: nil)

      squares = JustChess::SquareSet.new(squares: [attacker_square, threatened_square, ignored_square])

      game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

      filtered = squares.threatened_by(1, game_state)

      assert_includes filtered, threatened_square
      refute_includes filtered, ignored_square
    end

    it 'returns squares threatened by a player including pawns' do
      attacker = JustChess::Pawn.new(id: 16, player_number: 2, has_moved: false)
      attacker_square = JustChess::Square.new(id: 'h7', x: 7, y: 1, piece: attacker)
      threatened_square = JustChess::Square.new(id: 'g6', x: 6, y: 2, piece: nil)

      squares = JustChess::SquareSet.new(squares: [attacker_square, threatened_square])

      game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

      filtered = squares.threatened_by(2, game_state)

      assert_includes filtered, threatened_square
    end
  end
end

