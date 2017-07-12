describe JustChess::Pawn do
  describe 'a piece owned by player one' do
    describe "on player one's starting rank" do
      it 'must be able to move 2 spaces' do
        pawn = JustChess::Pawn.new(id: 1, player_number: 1)
        from = JustChess::Square.new(id: 'a2', x: 0, y: 6, piece: pawn)
        between = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: nil)
        to = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: nil)
        squares = JustChess::SquareSet.new(squares: [from, between, to])

        game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

        assert pawn.can_move?(from, to, game_state)
      end
    end

    describe "not on player one's starting rank" do
      it 'must not be able to move 2 spaces' do
        pawn = JustChess::Pawn.new(id: 1, player_number: 1)
        from = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: pawn)
        between = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: pawn)
        to = JustChess::Square.new(id: 'a5', x: 0, y: 3, piece: nil)
        squares = JustChess::SquareSet.new(squares: [from, between, to])

        game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

        refute pawn.can_move?(from, to, game_state)
      end
    end

    describe 'moving up the board' do
      it 'must be going the right direction' do
        pawn = JustChess::Pawn.new(id: 1, player_number: 1)
        from = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: pawn)
        to = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: nil)
        squares = JustChess::SquareSet.new(squares: [from, to])

        game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

        assert pawn.can_move?(from, to, game_state)
      end
    end

    describe 'moving down the board' do
      it 'must be going the wrong direction' do
        pawn = JustChess::Pawn.new(id: 1, player_number: 1)
        from = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: pawn)
        to = JustChess::Square.new(id: 'a2', x: 0, y: 6, piece: nil)
        squares = JustChess::SquareSet.new(squares: [from, to])

        game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

        refute pawn.can_move?(from, to, game_state)
      end
    end

    describe 'moving sideways' do
      it 'must be going the wrong direction' do
        pawn = JustChess::Pawn.new(id: 1, player_number: 1)
        from = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: pawn)
        to = JustChess::Square.new(id: 'b3', x: 1, y: 5, piece: nil)
        squares = JustChess::SquareSet.new(squares: [from, to])

        game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

        refute pawn.can_move?(from, to, game_state)
      end
    end

    describe 'moving diagonally forward' do
      describe 'to an enemy square' do
        it 'must be going the right direction' do
          pawn = JustChess::Pawn.new(id: 1, player_number: 1)
          enemy = JustChess::Pawn.new(id: 2, player_number: 2)
          from = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: pawn)
          to = JustChess::Square.new(id: 'b4', x: 1, y: 4, piece: enemy)
          squares = JustChess::SquareSet.new(squares: [from, to])

          game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

          assert pawn.can_move?(from, to, game_state)
        end
      end

      describe 'to an empty square' do
        describe 'next to an opposing pawn that double stepped last turn' do
          it 'must be able to move' do
            pawn = JustChess::Pawn.new(id: 1, player_number: 1)
            enemy = JustChess::Pawn.new(id: 2, player_number: 2)

            from = JustChess::Square.new(id: 'a5', x: 0, y: 3, piece: pawn)
            to = JustChess::Square.new(id: 'b6', x: 1, y: 2, piece: nil)
            besides = JustChess::Square.new(id: 'b5', x: 1, y: 3, piece: enemy)

            squares = JustChess::SquareSet.new(squares: [from, besides, to])

            game_state = JustChess::GameState.new(current_player_number: 1, squares: squares, last_double_step_pawn_id: enemy.id)

            assert pawn.can_move?(from, to, game_state)
          end
        end

        describe 'next to an opposing pawn that did not double step last turn' do
          it 'must not be able to move' do
            pawn = JustChess::Pawn.new(id: 1, player_number: 1)
            enemy = JustChess::Pawn.new(id: 2, player_number: 2)

            from = JustChess::Square.new(id: 'a5', x: 0, y: 3, piece: pawn)
            to = JustChess::Square.new(id: 'b6', x: 1, y: 2, piece: nil)
            besides = JustChess::Square.new(id: 'b5', x: 1, y: 3, piece: enemy)

            squares = JustChess::SquareSet.new(squares: [from, besides, to])

            game_state = JustChess::GameState.new(current_player_number: 1, squares: squares, last_double_step_pawn_id: nil)

            refute pawn.can_move?(from, to, game_state)
          end
        end

        describe 'next to empty' do
          it 'must be going the wrong direction' do
            pawn = JustChess::Pawn.new(id: 1, player_number: 1)
            from = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: pawn)
            to = JustChess::Square.new(id: 'b4', x: 1, y: 4, piece: nil)
            squares = JustChess::SquareSet.new(squares: [from, to])

            game_state = JustChess::GameState.new(current_player_number: 1, squares: squares)

            refute pawn.can_move?(from, to, game_state)
          end
        end
      end
    end
  end

  describe 'a piece owned by player two' do
    describe "on player two's starting rank" do
      it 'must be able to move 2 spaces' do
        pawn = JustChess::Pawn.new(id: 1, player_number: 2)
        from = JustChess::Square.new(id: 'a7', x: 0, y: 1, piece: pawn)
        between = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: nil)
        to = JustChess::Square.new(id: 'a5', x: 0, y: 3, piece: nil)
        squares = JustChess::SquareSet.new(squares: [from, between, to])

        game_state = JustChess::GameState.new(current_player_number: 2, squares: squares)

        assert pawn.can_move?(from, to, game_state)
      end
    end

    describe "not on player two's starting rank" do
      it 'must not be able to move 2 spaces' do
        pawn = JustChess::Pawn.new(id: 1, player_number: 2)
        from = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: pawn)
        between = JustChess::Square.new(id: 'a5', x: 0, y: 3, piece: nil)
        to = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: nil)
        squares = JustChess::SquareSet.new(squares: [from, between, to])

        game_state = JustChess::GameState.new(current_player_number: 2, squares: squares)

        refute pawn.can_move?(from, to, game_state)
      end
    end

    describe 'moving up the board' do
      it 'must be going the wrong direction' do
        pawn = JustChess::Pawn.new(id: 1, player_number: 2)
        from = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: pawn)
        to = JustChess::Square.new(id: 'a7', x: 0, y: 1, piece: nil)
        squares = JustChess::SquareSet.new(squares: [from, to])

        game_state = JustChess::GameState.new(current_player_number: 2, squares: squares)

        refute pawn.can_move?(from, to, game_state)
      end
    end

    describe 'moving down the board' do
      it 'must be going the right direction' do
        pawn = JustChess::Pawn.new(id: 1, player_number: 2)
        from = JustChess::Square.new(id: 'a6', x: 0, y: 2, piece: pawn)
        to = JustChess::Square.new(id: 'a5', x: 0, y: 3, piece: nil)
        squares = JustChess::SquareSet.new(squares: [from, to])

        game_state = JustChess::GameState.new(current_player_number: 2, squares: squares)

        assert pawn.can_move?(from, to, game_state)
      end
    end

    describe 'moving sideways' do
      it 'must be going in the wrong direction' do
        pawn = JustChess::Pawn.new(id: 1, player_number: 2)
        from = JustChess::Square.new(id: 'a3', x: 0, y: 5, piece: pawn)
        to = JustChess::Square.new(id: 'b3', x: 1, y: 5, piece: nil)
        squares = JustChess::SquareSet.new(squares: [from, to])

        game_state = JustChess::GameState.new(current_player_number: 2, squares: squares)

        refute pawn.can_move?(from, to, game_state)
      end
    end

    describe 'moving diagonally forward' do
      describe 'to an enemy square' do
        it 'must be going in the right direction' do
          pawn = JustChess::Pawn.new(id: 1, player_number: 2)
          enemy = JustChess::Pawn.new(id: 2, player_number: 1)
          from = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: pawn)
          to = JustChess::Square.new(id: 'b3', x: 1, y: 5, piece: enemy)
          squares = JustChess::SquareSet.new(squares: [from, to])

          game_state = JustChess::GameState.new(current_player_number: 2, squares: squares)

          assert pawn.can_move?(from, to, game_state)
        end
      end

      describe 'to an empty square' do
        describe 'next to an opposing pawn that double stepped last turn' do
          it 'must be able to move' do
            pawn = JustChess::Pawn.new(id: 1, player_number: 2)
            enemy = JustChess::Pawn.new(id: 2, player_number: 1)

            from = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: pawn)
            to = JustChess::Square.new(id: 'b3', x: 1, y: 5, piece: nil)
            besides = JustChess::Square.new(id: 'b4', x: 1, y: 4, piece: enemy)

            squares = JustChess::SquareSet.new(squares: [from, besides, to])

            game_state = JustChess::GameState.new(current_player_number: 2, squares: squares, last_double_step_pawn_id: enemy.id)

            assert pawn.can_move?(from, to, game_state)
          end
        end

        describe 'next to an opposing pawn that did not double step last turn' do
          it 'must not be able to move' do
            pawn = JustChess::Pawn.new(id: 1, player_number: 2)
            enemy = JustChess::Pawn.new(id: 2, player_number: 1)

            from = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: pawn)
            to = JustChess::Square.new(id: 'b3', x: 1, y: 5, piece: nil)
            besides = JustChess::Square.new(id: 'b4', x: 1, y: 4, piece: enemy)

            squares = JustChess::SquareSet.new(squares: [from, besides, to])

            game_state = JustChess::GameState.new(current_player_number: 2, squares: squares, last_double_step_pawn_id: nil)

            refute pawn.can_move?(from, to, game_state)
          end
        end

        describe 'next to empty' do
          it 'must be going in the wrong direction' do
            pawn = JustChess::Pawn.new(id: 1, player_number: 2)
            from = JustChess::Square.new(id: 'a4', x: 0, y: 4, piece: pawn)
            to = JustChess::Square.new(id: 'b3', x: 1, y: 5, piece: nil)
            squares = JustChess::SquareSet.new(squares: [from, to])

            game_state = JustChess::GameState.new(current_player_number: 2, squares: squares)

            refute pawn.can_move?(from, to, game_state)
          end
        end
      end
    end
  end
end