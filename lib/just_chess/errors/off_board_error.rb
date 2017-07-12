require 'just_chess/errors/error'

module JustChess

  # = OffBoardError
  #
  # An off board error with a message
  class OffBoardError < Error

    # New off board errors can be instantiated with
    #
    # @option [String] message
    #   the message to display.
    #
    # ==== Example:
    #   # Instantiates a new OffBoardError
    #   JustChess::OffBoardError.new("Custom Message")
    def initialize(message="Cannot move off board.")
      super
    end
  end
end