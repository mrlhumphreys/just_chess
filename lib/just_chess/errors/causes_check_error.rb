require 'just_chess/errors/error'

module JustChess

  # = CausesCheckError
  #
  # A causes check error with a message
  class CausesCheckError < Error

    # New causes check errors can be instantiated with
    #
    # @option [String] message
    #   the message to display.
    #
    # ==== Example:
    #   # Instantiates a new CausesCheckError
    #   JustChess::CausesCheckError.new("Custom Message")
    def initialize(message="That move would put the king in check.")
      super
    end
  end
end