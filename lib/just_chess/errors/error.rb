module JustChess

  # = Error
  #
  # An error with a message
  class Error

    # New errors can be instantiated with
    #
    # @option [String] message
    #   the message to display.
    #
    # ==== Example:
    #   # Instantiates a new Error
    #   JustChess::Error.new("Custom Message")
    def initialize(message="Generic Error")
      @message = message
    end
  end
end