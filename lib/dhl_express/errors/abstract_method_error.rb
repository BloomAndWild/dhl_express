# frozen_string_literal: true

module DHLExpress
  module Errors
    class AbstractMethodError < StandardError
      ERROR_MSG = 'method must be implemented in a subclass'

      def initialize
        super(ERROR_MSG)
      end
    end
  end
end
