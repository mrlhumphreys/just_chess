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

  describe 'union' do
    it 'combines the two square sets' do
      square_a = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: nil)
      square_b = JustChess::Square.new(id: 'b6', x: 1, y: 2, piece: nil)

      square_set_a = JustChess::SquareSet.new(squares: [square_a])
      square_set_b = JustChess::SquareSet.new(squares: [square_b])

      square_set_result = square_set_a + square_set_b

      assert_includes square_set_result, square_a
      assert_includes square_set_result, square_b
    end
  end

  describe 'minus' do
    it 'subtracts the contents of one square set with the other' do
      square_a = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: nil)
      square_b = JustChess::Square.new(id: 'b6', x: 1, y: 2, piece: nil)

      square_set_a = JustChess::SquareSet.new(squares: [square_a, square_b])
      square_set_b = JustChess::SquareSet.new(squares: [square_b])

      square_set_result = square_set_a - square_set_b

      assert_includes square_set_result, square_a
      refute_includes square_set_result, square_b
    end
  end

  describe 'push' do
    it 'pushes a square onto the square set' do
      square_a = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: nil)
      square_b = JustChess::Square.new(id: 'b6', x: 1, y: 2, piece: nil)

      square_set = JustChess::SquareSet.new(squares: [square_a])

      square_set << square_b

      assert_includes square_set, square_b
    end
  end

  describe 'intersection' do
    it 'returns the common squares' do
      square_a = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: nil)
      square_b = JustChess::Square.new(id: 'b6', x: 1, y: 2, piece: nil)
      square_c = JustChess::Square.new(id: 'c6', x: 2, y: 2, piece: nil)

      square_set_a = JustChess::SquareSet.new(squares: [square_a, square_b])
      square_set_b = JustChess::SquareSet.new(squares: [square_b, square_c])

      square_set_result = square_set_a & square_set_b

      refute_includes square_set_result, square_a
      assert_includes square_set_result, square_b
      refute_includes square_set_result, square_c
    end
  end

  describe 'select' do
    it 'returns the squares matching the block' do
      square_a = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: nil)
      square_b = JustChess::Square.new(id: 'b6', x: 1, y: 2, piece: nil)

      square_set = JustChess::SquareSet.new(squares: [square_a, square_b])

      square_set_result = square_set.select { |s| s.x.odd? }

      assert_includes square_set_result, square_b
    end
  end

  describe 'find_by_id' do
    it 'returns the square matching the id' do
      square = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: nil)
      squares = JustChess::SquareSet.new(squares: [square])

      found = squares.find_by_id('a6')
      assert_equal square, found
    end
  end

  describe 'find_by_x_and_y' do
    it 'returns the square matching the co-ordinates' do
      square = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: nil)
      squares = JustChess::SquareSet.new(squares: [square])

      found = squares.find_by_x_and_y(0, 2)
      assert_equal square, found
    end
  end

  describe 'find_by_piece_id' do
    it 'returns the square with the matching piece' do
      piece = JustChess::Pawn.new(id: 1, player_number: 2)
      square = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: piece)
      squares = JustChess::SquareSet.new(squares: [square])

      found = squares.find_by_piece_id(1)
      assert_equal square, found
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

  describe 'between' do
    it 'returns the set of squares between' do
      first = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: nil)
      middle = JustChess::Square.new(id: 'a5', x: 0, y: 3, piece: nil)
      last = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: nil)

      squares = JustChess::SquareSet.new(squares: [first, middle, last])
      filtered = squares.between(first, last)

      assert_includes filtered, middle
      refute_includes filtered, first
      refute_includes filtered, last
    end
  end

  describe 'in_range' do
    it 'returns the squares within range' do
      origin = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: nil)
      one_square_away = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: nil)
      two_square_away = JustChess::Square.new(id: 'a5', x: 0, y: 3, piece: nil)
      squares = JustChess::SquareSet.new(squares: [origin, one_square_away, two_square_away])

      filtered = squares.in_range(origin, 1)

      assert_includes filtered, one_square_away
      refute_includes filtered, two_square_away
    end
  end

  describe 'at_range' do
    it 'returns the squares at range' do
      origin = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: nil)
      one_square_away = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: nil)
      two_square_away = JustChess::Square.new(id: 'a5', x: 0, y: 3, piece: nil)
      squares = JustChess::SquareSet.new(squares: [origin, one_square_away, two_square_away])

      filtered = squares.at_range(origin, 2)

      refute_includes filtered, one_square_away
      assert_includes filtered, two_square_away
    end
  end

  describe 'in direction' do
    it 'returns the squares in the specified direction' do
      forward = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: nil)
      origin = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: nil)
      backward = JustChess::Square.new(id: 'a2', x: 0, y: 6, piece: nil)

      squares = JustChess::SquareSet.new(squares: [backward, origin, forward])

      filtered = squares.in_direction(origin, -1)

      assert_includes filtered, forward
      refute_includes filtered, backward
    end
  end

  describe 'orthogonal' do
    it 'returns the squares orthogonal to it' do
      orthogonal = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: nil)
      origin = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: nil)
      diagonal = JustChess::Square.new(id: 'b4', x: 1, y: 4, piece: nil)

      squares = JustChess::SquareSet.new(squares: [orthogonal, origin, diagonal])

      filtered = squares.orthogonal(origin)

      assert_includes filtered, orthogonal
      refute_includes filtered, diagonal
    end
  end

  describe 'diagonal' do
    it 'returns the squares diagonal to it' do
      orthogonal = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: nil)
      origin = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: nil)
      diagonal = JustChess::Square.new(id: 'b4', x: 1, y: 4, piece: nil)

      squares = JustChess::SquareSet.new(squares: [orthogonal, origin, diagonal])

      filtered = squares.diagonal(origin)

      assert_includes filtered, diagonal
      refute_includes filtered, orthogonal
    end
  end

  describe 'orthogonal_or_diagonal' do
    it 'returns the squares orthogonal or diagonal to it' do
      orthogonal = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: nil)
      origin = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: nil)
      diagonal = JustChess::Square.new(id: 'b4', x: 1, y: 4, piece: nil)

      squares = JustChess::SquareSet.new(squares: [orthogonal, origin, diagonal])

      filtered = squares.orthogonal_or_diagonal(origin)

      assert_includes filtered, diagonal
      assert_includes filtered, orthogonal
    end
  end

  describe 'not_orthogonal_or_diagonal' do
    it 'returns the squares orthogonal or diagonal to it' do
      orthogonal = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: nil)
      origin = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: nil)
      diagonal = JustChess::Square.new(id: 'b4', x: 1, y: 4, piece: nil)

      squares = JustChess::SquareSet.new(squares: [orthogonal, origin, diagonal])

      filtered = squares.not_orthogonal_or_diagonal(origin)

      refute_includes filtered, diagonal
      refute_includes filtered, orthogonal
    end
  end

  describe 'unoccupied' do
    it 'returns the squares without pieces' do
      piece = JustChess::Pawn.new(id: 1, player_number: 2)
      without_piece = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: nil)
      with_piece = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: piece)

      squares = JustChess::SquareSet.new(squares: [with_piece, without_piece])

      filtered = squares.unoccupied

      assert_includes filtered, without_piece
      refute_includes filtered, with_piece
    end
  end

  describe 'occupied_by_player' do
    it 'returns squares occupied by the player' do
      friendly = JustChess::Pawn.new(id: 1, player_number: 2)
      opposing = JustChess::Pawn.new(id: 2, player_number: 1)
      with_friendly = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: friendly)
      with_opposing = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: opposing)

      squares = JustChess::SquareSet.new(squares: [with_friendly, with_opposing])

      filtered = squares.occupied_by_player(2)

      refute_includes filtered, with_opposing
      assert_includes filtered, with_friendly
    end
  end

  describe 'occupied_by_opponent' do
    it 'returns the squares occupied by the opposing player' do
      friendly = JustChess::Pawn.new(id: 1, player_number: 2)
      opposing = JustChess::Pawn.new(id: 2, player_number: 1)
      with_friendly = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: friendly)
      with_opposing = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: opposing)

      squares = JustChess::SquareSet.new(squares: [with_friendly, with_opposing])

      filtered = squares.occupied_by_opponent(2)

      assert_includes filtered, with_opposing
      refute_includes filtered, with_friendly
    end
  end

  describe 'unoccupied_or_occupied_by_opponent' do
    it 'returns squares unoccupied or occupied by opponent' do
      friendly = JustChess::Pawn.new(id: 1, player_number: 2)
      opposing = JustChess::Pawn.new(id: 2, player_number: 1)
      with_friendly = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: friendly)
      with_opposing = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: opposing)
      without_piece = JustChess::Square.new(id: 'a2', x: 0, y: 5, piece: nil)

      squares = JustChess::SquareSet.new(squares: [with_friendly, with_opposing, without_piece])

      filtered = squares.unoccupied_or_occupied_by_opponent(2)

      assert_includes filtered, without_piece
      assert_includes filtered, with_opposing
      refute_includes filtered, with_friendly
    end
  end

  describe 'occupied_by_piece' do
    it 'returns squares occupied by piece' do
      pawn = JustChess::Pawn.new(id: 1, player_number: 1)
      rook = JustChess::Rook.new(id: 2, player_number: 1)
      with_pawn = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: pawn)
      with_rook = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: rook)

      squares = JustChess::SquareSet.new(squares: [with_pawn, with_rook])

      filtered = squares.occupied_by_piece(JustChess::Rook)

      assert_includes filtered, with_rook
      refute_includes filtered, with_pawn
    end
  end

  describe 'excluding_piece' do
    it 'excludes squares occupied by that piece type' do
      pawn = JustChess::Pawn.new(id: 1, player_number: 1)
      rook = JustChess::Rook.new(id: 2, player_number: 1)
      with_pawn = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: pawn)
      with_rook = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: rook)

      squares = JustChess::SquareSet.new(squares: [with_pawn, with_rook])

      filtered = squares.excluding_piece(JustChess::Rook)

      refute_includes filtered, with_rook
      assert_includes filtered, with_pawn
    end
  end

  describe 'unblocked' do
    it 'returns the squares that have cleared paths' do
      block = JustChess::Pawn.new(id: 1, player_number: 2)

      origin = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: nil)
      between = JustChess::Square.new(id: 'a5', x: 0, y: 3, piece: nil)
      destination = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: nil)
      occupied = JustChess::Square.new(id: 'a7', x: 0, y: 1, piece: block)
      beyond = JustChess::Square.new(id: 'a8', x: 0, y: 0, piece: nil)

      squares = JustChess::SquareSet.new(squares: [origin, between, destination, occupied, beyond])

      filtered = squares.unblocked(origin, squares)

      assert_includes filtered, destination
      refute_includes filtered, beyond
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
  end

  describe 'as_json' do
    it 'serializes the data' do
      json = [{ id: 'a6', x: 0, y: 2, piece: nil }]
      squares = JustChess::SquareSet.new(squares: json)

      assert_equal json, squares.as_json
    end
  end
end