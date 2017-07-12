require 'just_chess/pieces/pawn'
require 'just_chess/pieces/rook'
require 'just_chess/pieces/knight'
require 'just_chess/pieces/bishop'
require 'just_chess/pieces/queen'
require 'just_chess/pieces/king'

module JustChess

  # = Piece Factory
  #
  # Generates pieces from a hash of arguments
  class PieceFactory

    # A mapping of type descriptions to classes
    CLASSES = {
      'pawn' => Pawn,
      'rook' => Rook,
      'knight' => Knight,
      'bishop' => Bishop,
      'queen' => Queen,
      'king' => King
    }

    # New objects can be instantiated by passing in a hash or the piece.
    #
    # @param [Hash,Piece] args
    #   the initial attributes of the piece, hash requires type key
    #
    # ==== Example:
    #   # Instantiates a new PieceFactory
    #   JustChess::PieceFactory.new({
    #     type: 'pawn',
    #     id: 1,
    #     player_number: 2
    #   })
    def initialize(args)
      @args = args
    end

    # Returns a piece based on the initial arguments.
    #
    # @return [Piece]
    def build
      case @args
      when Hash
        build_from_hash
      when Piece
        @args
      when nil
        nil
      else
        raise ArgumentError, "piece must be Hash or NilClass"
      end
    end

    private

    def build_from_hash
      klass = CLASSES[@args[:type]]
      if klass
        klass.new(@args)
      else
        raise ArgumentError, "invalid piece type: #{@args[:type].to_s}"
      end
    end
  end
end