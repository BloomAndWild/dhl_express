# frozen_string_literal: true

module DHLExpress
  module Operations
    class ShipmentDeleteRequest < Operation
      SERVICE_NAME = "DeleteShipment"

      private

      def handle_response_body(body)
        body[:DeleteResponse]
      end

      def service
        SERVICE_NAME
      end

      def payload
        { "DeleteRequest": options[:payload] }
      end
    end
  end
end
