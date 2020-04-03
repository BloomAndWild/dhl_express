# frozen_string_literal: true

RSpec.describe DHLExpress::Operations::ShipmentDeleteRequest do
  before { configure_client }

  describe '#execute' do
    subject { described_class.new(payload: payload) }

    context 'with invalid payload' do
      let(:payload) do
        {
          "PickupDate": "2017-07-24",
          "PickupCountry": "SG",
          "DispatchConfirmationNumber": "SIN-952041",
          "RequestorName": "Terry Kelly",
        }
      end

      let(:failed_cancellation_message) do
        "Cancellation of booking was not successful. Requested Pickup was not found"
      end

      it 'returns error response body' do
        VCR.use_cassette('shipment_delete_request/invalid_request') do
          result = subject.execute

          expect(result).to match(
            hash_including(
              "Notification": array_including(
                [
                  { "@code": '410928', "Message": failed_cancellation_message },
                  { "@code": '444', "Message": a_kind_of(String) }
                ]
              )
            )
          )
        end
      end
    end

    context 'with valid payload' do
      let(:payload) do
        {
          "PickupDate": "2020-04-04",
          "PickupCountry": "SG",
          "DispatchConfirmationNumber": "1149268120",
          "RequestorName": "Terry Kelly",
        }
      end

      it 'successfully cancels the booking' do
        VCR.use_cassette('shipment_delete_request/valid_request') do
          expect(subject.execute).to match(
            hash_including(
              "Notification": hash_including(
                "@code": "0",
                "Message": "Successfully cancelled",
              )
            )
          )
        end
      end
    end

    context 'with cancelled booking' do
      let(:payload) do
        {
          "PickupDate": "2020-04-04",
          "PickupCountry": "SG",
          "DispatchConfirmationNumber": "CBJ180121002626",
          "RequestorName": "Terry Kelly",
        }
      end

      let(:failed_cancellation_message) do
        "Booking already cancelled or completed."
      end

      it 'returns error response body' do
        VCR.use_cassette('shipment_delete_request/cancelled_booking_request') do
          result = subject.execute

          expect(result).to match(
            hash_including(
              "Notification": array_including(
                [
                  { "@code": '410928', "Message": failed_cancellation_message },
                  { "@code": '444', "Message": a_kind_of(String) }
                ]
              )
            )
          )
        end
      end
    end
  end
end
