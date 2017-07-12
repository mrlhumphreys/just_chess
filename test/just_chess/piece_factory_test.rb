describe JustChess::PieceFactory do
  describe 'with a piece type that exists' do
    it 'must be able to build a piece of that type' do
      piece_factory = JustChess::PieceFactory.new(id: 1, type: 'pawn', player_number: 1)
      piece = piece_factory.build
      assert_instance_of JustChess::Pawn, piece
    end
  end

  describe "with a piece type that doesn't exist" do
    it 'must raise error' do
      piece_factory = JustChess::PieceFactory.new(id: 1, type: 'unicorn', player_number: 1)
      assert_raises ArgumentError do
        piece_factory.build
      end
    end
  end

  describe 'with a nil piece' do
    it 'must return nil' do
      piece_factory = JustChess::PieceFactory.new(nil)
      piece = piece_factory.build
      assert_nil piece
    end
  end
end