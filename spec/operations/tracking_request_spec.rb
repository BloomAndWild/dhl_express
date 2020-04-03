# frozen_string_literal: true

RSpec.describe DHLExpress::Operations::TrackingRequest do
  before { configure_client }

  describe '#execute' do
    let(:payload) do
      {
        "Request": {
          "ServiceHeader": {
            "MessageTime": '2017-10-10T12:40:00Z',
            "MessageReference": '896ab310ba5311e38d9ffb21b7e57543'
          }
        },
        "AWBNumber": {
          "ArrayOfAWBNumberItem": tracking_number
        },
        "LevelOfDetails": 'ALL_CHECK_POINTS',
        "PiecesEnabled": 'B'
      }
    end

    let(:subject) { described_class.new(payload: payload) }

    context 'with invalid tracking number' do
      let(:tracking_number) { 1_234_567_890 }

      it 'returns error response body' do
        VCR.use_cassette('tracking_request/invalid_request') do
          result = subject.execute

          expect(result).to match(
            hash_including(
              "Response": {
                "ServiceHeader": {
                  "MessageTime": '2020-04-03T10:29:08',
                  "MessageReference": '896ab310ba5311e38d9ffb21b7e57543'
                }
              },
              "AWBInfo": {
                "ArrayOfAWBInfoItem": {
                  "AWBNumber": tracking_number,
                  "Status": {
                    "ActionStatus": 'No Shipments Found',
                    "Condition": {
                      "ArrayOfConditionItem": {
                        "ConditionCode": 101,
                        "ConditionData": "No Shipments Found for AWBNumber | #{tracking_number}"
                      }
                    }
                  }
                }
              }
            )
          )
        end
      end
    end

    context 'with valid tracking number' do
      let(:tracking_number) { 3_898_464_710 }

      it 'returns response body' do
        VCR.use_cassette('tracking_request/valid_request') do
          result = subject.execute

          expect(result).to match(
            hash_including(
              "Response": {
                "ServiceHeader": {
                  "MessageTime": '2020-04-03T08:54:20',
                  "MessageReference": '896ab310ba5311e38d9ffb21b7e57543'
                }
              },
              "AWBInfo": {
                "ArrayOfAWBInfoItem": {
                  "AWBNumber": tracking_number,
                  "Status": {
                    "ActionStatus": 'Success'
                  },
                  "ShipmentInfo": {
                    "OriginServiceArea": a_kind_of(Hash),
                    "DestinationServiceArea": a_kind_of(Hash),
                    "ShipperName": 'FRESIA AGUIRRE RIVERA',
                    "ConsigneeName": 'EMEC INT TRADING',
                    "ShipmentDate": '1970-01-02T00:00:00',
                    "Pieces": 1,
                    "Weight": 1.0,
                    "WeightUnit": 'G',
                    "ShipmentEvent": {
                      "ArrayOfShipmentEventItem": array_including(
                        [
                          {
                            "Date": '2015-10-12',
                            "Time": '00:00:00',
                            "ServiceEvent": a_kind_of(Hash),
                            "ServiceArea": a_kind_of(Hash)
                          }
                        ]
                      )
                    }
                  }
                }
              }
            )
          )
        end
      end
    end
  end
end
