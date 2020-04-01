# frozen_string_literal: true

module DHLExpress
  module Operations
    class ShipmentRequest < Operation
      SERVICE_NAME = 'ShipmentRequest'

      private

      def service
        SERVICE_NAME
      end
    end
  end
end
