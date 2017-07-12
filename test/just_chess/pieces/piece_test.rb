describe JustChess::Piece do
  describe 'opponent' do
    describe 'of player one' do
      it 'must be two' do
        piece = JustChess::Piece.new(id: 1, player_number: 1)
        assert_equal 2, piece.opponent
      end
    end

    describe 'of player two' do
      it 'must be one' do
        piece = JustChess::Piece.new(id: 1, player_number: 2)
        assert_equal 1, piece.opponent
      end
    end
  end

  describe 'moved' do
    it 'must mark the piece as moved' do
      piece = JustChess::Piece.new(id: 1, player_number: 1, has_moved: false)

      assert piece.has_not_moved?
      piece.moved
      assert piece.has_moved?
    end
  end

  describe 'type' do
    it 'must be the downcased class name' do
      piece = JustChess::Pawn.new(id: 1, player_number: 1)
      assert_equal 'pawn', piece.type
    end
  end

  describe 'piece by default' do
    it 'must not be able to move' do
      piece = JustChess::Piece.new(id: 1, player_number: 1)
      refute piece.can_move?(nil, nil, nil)
    end

    it 'must not have any destinations' do
      piece = JustChess::Piece.new(id: 1, player_number: 1)
      assert_empty piece.destinations(nil, nil)
    end

    it 'must not have any capture squares' do
      piece = JustChess::Piece.new(id: 1, player_number: 1)
      assert_empty piece.capture_squares(nil, nil)
    end

    it 'must not have any move squares' do
      piece = JustChess::Piece.new(id: 1, player_number: 1)
      assert_empty piece.move_squares(nil, nil)
    end
  end

  describe 'as_json' do
    it 'must serialize the piece' do
      piece = JustChess::Piece.new(id: 1, player_number: 1)
      json = {id: 1, player_number: 1, type: 'piece', has_moved: false}

      assert_equal json, piece.as_json
    end
  end
end