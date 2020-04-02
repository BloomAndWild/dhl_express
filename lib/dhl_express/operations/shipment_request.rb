# frozen_string_literal: true

module DHLExpress
  module Operations
    class ShipmentRequest < Operation
      SERVICE_NAME = 'ShipmentRequest'

      private

      def handle_response_body(body)
        body[:ShipmentResponse]
      end

      def service
        SERVICE_NAME
      end

      def payload
        { service => options[:payload] }
      end
    end
  end
end
