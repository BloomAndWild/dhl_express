# frozen_string_literal: true

module DHLExpress
  module Errors
    class ResponseError < StandardError
      attr_reader :payload, :status, :body

      def initialize(payload:, status:, body:)
        @payload = payload
        @status = status
        @body = body

        super(build_message)
      end

      private

      def build_message
        return status unless body.is_a?(Hash)

        body.dig(:reasons, 0, :msg) || status
      end
    end
  end
end
