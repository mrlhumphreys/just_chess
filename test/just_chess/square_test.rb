require 'minitest/autorun'
require 'minitest/spec'
require 'just_chess/square'

describe JustChess::Square do
  describe '.new' do
    it 'initializes a square' do
      square = JustChess::Square.new(id: 'a1', x: 2, y: 3, piece: { id: 4, player_number: 2, type: 'pawn' })  

      assert_instance_of(JustChess::Square, square)
      assert_equal('a1', square.id)
      assert_instance_of(JustChess::Pawn, square.piece)
    end
  end

  describe '#rank_number' do
    describe 'for player 1' do
      it "returns the rank from player 1's perspective" do
        square = JustChess::Square.new(id: 'a1', x: 2, y: 3, piece: nil)  

        assert_equal(5, square.rank_number(1))
      end
    end

    describe 'for player 2' do
      it "returns the rank from player 2's perspective" do
        square = JustChess::Square.new(id: 'a1', x: 2, y: 3, piece: nil)  

        assert_equal(4, square.rank_number(2))
      end
    end
  end

  describe '#last_rank' do
    describe 'for player 1' do
      describe 'when furthest away from the player' do
        it 'returns true' do
          square = JustChess::Square.new(id: 'a8', x: 0, y: 0, piece: nil)  

          assert(square.last_rank(1))
        end
      end

      describe 'when not furthest away from the player' do
        it 'returns false' do
          square = JustChess::Square.new(id: 'a7', x: 0, y: 1, piece: nil)  

          refute(square.last_rank(1))

        end
      end
    end

    describe 'for player 2' do
      describe 'when furthest away from the player' do
        it 'returns true' do
          square = JustChess::Square.new(id: 'a1', x: 0, y: 7, piece: nil)  

          assert(square.last_rank(2))
        end
      end

      describe 'when not furthest away from the player' do
        it 'returns false' do
          square = JustChess::Square.new(id: 'a2', x: 0, y: 6, piece: nil)  

          refute(square.last_rank(2))
        end
      end
    end
  end
end
