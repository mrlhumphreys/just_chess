require 'just_chess/errors/error'

module JustChess

  # = InvalidPromotionError
  #
  # An invalid promotion error with a message
  class InvalidPromotionError < Error

    # New invalid promotion errors can be instantiated with
    #
    # @option [String] message
    #   the message to display.
    #
    # ==== Example:
    #   # Instantiates a new InvalidPromotionError
    #   JustChess::InvalidPromotionError.new("Custom Message")
    def initialize(message="Promotion is invalid.")
      super
    end
  end
end