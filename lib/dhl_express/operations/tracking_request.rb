# frozen_string_literal: true

module DHLExpress
  module Operations
    class TrackingRequest < Operation
      SERVICE_NAME = 'TrackingRequest'

      private

      def handle_response_body(body)
        body.dig(:trackShipmentRequestResponse, :trackingResponse, :TrackingResponse)
      end

      def service
        SERVICE_NAME
      end

      def payload
        {
          trackShipmentRequest: {
            trackingRequest: {
              TrackingRequest: options[:payload]
            }
          }
        }
      end
    end
  end
end
