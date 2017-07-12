require 'just_chess/errors/error'

module JustChess

  # = MovedIntoCheckError
  #
  # A moved into check error with a message
  class MovedIntoCheckError < Error

    # New moved into check errors can be instantiated with
    #
    # @option [String] message
    #   the message to display.
    #
    # ==== Example:
    #   # Instantiates a new MovedIntoCheckError
    #   JustChess::MovedIntoCheckError.new("Custom Message")
    def initialize(message="This move would leave the king in check.")
      super
    end
  end
end