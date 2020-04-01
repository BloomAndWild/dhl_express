# frozen_string_literal: true

RSpec.describe DHLExpress::Operations::ShipmentRequest do
  before { configure_client }

  describe '#execute' do
    let(:payload) do
      {
        "ShipmentRequest": {
          "RequestedShipment": {
            "ShipmentInfo": {
              "DropOffType": "REGULAR_PICKUP",
              "ServiceType": "P",
              "Account": "952670377",
              "Currency": "GBP",
              "UnitOfMeasurement": "SI"
            },
            "ShipTimestamp": "2020-04-04T16:40:40GMT+01:00",
            "PaymentInfo": "DAP",
            "InternationalDetail": {
              "Commodities": {
                "NumberOfPieces": 2,
                "Description": "Customer Reference 1",
                "CountryOfManufacture": "GB",
                "Quantity": 1,
                "UnitPrice": 5,
                "CustomsValue": 10
              },
              "Content": "NON_DOCUMENTS"
            },
            "Ship": {
              "Shipper": {
                "Contact": {
                  "PersonName": "Tester 1",
                  "CompanyName": "Bloom&Wild",
                  "PhoneNumber": "02031370535",
                  "EmailAddress": "hello@bloomandwild.com"
                },
                "Address": {
                  "StreetLines": "Unit W.301, Vox Studios",
                  "City": "London",
                  "PostalCode": "SE11 5JH",
                  "CountryCode": "GB"
                }
              },
              "Recipient": {
                "Contact": {
                  "PersonName": "Boris Johnson",
                  "CompanyName": "The Government",
                  "PhoneNumber": "02079250918",
                  "EmailAddress": "boris.johnson@gov.uk"
                },
                "Address": {
                  "StreetLines": "10 Downing St, Westminster",
                  "City": "London",
                  "PostalCode": "SW1A 2AA",
                  "CountryCode": "GB"
                }
              }
            },
            "Packages": {
              "RequestedPackages": [
                {
                  "@number": "1",
                  "Weight": 2,
                  "Dimensions": {
                    "Length": 1,
                    "Width": 2,
                    "Height": 3
                  },
                  "CustomerReferences": "Piece 1"
                },
                {
                  "@number": "2",
                  "Weight": 2,
                  "Dimensions": {
                    "Length": 1,
                    "Width": 2,
                    "Height": 3
                  },
                  "CustomerReferences": "Piece 2"
                }
              ]
            }
          }
        }
      }
    end

    let(:subject) { described_class.new(payload: payload) }

    it 'returns response body' do
      # expect(subject.execute).to eq({})
    end
  end
end
