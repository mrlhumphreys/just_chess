describe JustChess::Piece do
  describe 'moved' do
    it 'must mark the piece as moved' do
      piece = JustChess::Piece.new(id: 1, player_number: 1, has_moved: false)

      assert piece.has_not_moved?
      piece.moved
      assert piece.has_moved?
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
