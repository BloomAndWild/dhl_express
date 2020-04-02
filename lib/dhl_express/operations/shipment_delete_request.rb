# frozen_string_literal: true

module DHLExpress
  module Operations
    class ShipmentDeleteRequest < Operation
      SERVICE_NAME = "DeleteShipment"

      protected

      def service
        SERVICE_NAME
      end

      private

      def payload
        { "DeleteRequest" => options[:payload] }
      end
    end
  end
end
