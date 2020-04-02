# frozen_string_literal: true

RSpec.describe DHLExpress::Operations::ShipmentRequest do
  before { configure_client }

  describe '#execute' do
    let(:payload) do
      {
        "RequestedShipment": {
          "ShipmentInfo": {
            "DropOffType": 'REGULAR_PICKUP',
            "ServiceType": 'P',
            "Account": account,
            "Currency": 'SGD',
            "UnitOfMeasurement": 'SI'
          },
          "ShipTimestamp": '2020-04-04T16:40:40GMT+01:00',
          "PaymentInfo": 'DAP',
          "InternationalDetail": {
            "Commodities": {
              "NumberOfPieces": 2,
              "Description": 'Customer Reference 1',
              "CountryOfManufacture": 'CN',
              "Quantity": 1,
              "UnitPrice": 5,
              "CustomsValue": 10
            },
            "Content": 'NON_DOCUMENTS'
          },
          "Ship": {
            "Shipper": {
              "Contact": {
                "PersonName": 'Tester 1',
                "CompanyName": 'DHL',
                "PhoneNumber": 2_175_441_239,
                "EmailAddress": 'jb@acme.com'
              },
              "Address": {
                "StreetLines": '#05-33 Singapore Post Centre',
                "City": 'Singapore ',
                "PostalCode": 408_600,
                "CountryCode": 'SG'
              }
            },
            "Recipient": {
              "Contact": {
                "PersonName": 'Tester 2',
                "CompanyName": 'Acme Inc',
                "PhoneNumber": 88_347_346_643,
                "EmailAddress": 'jackie.chan@eei.com'
              },
              "Address": {
                "StreetLines": '500 Hunt Valley Road',
                "City": 'New Kensington PA',
                "StateOrProvinceCode": 'PA',
                "PostalCode": 15_068,
                "CountryCode": 'US'
              }
            }
          },
          "Packages": {
            "RequestedPackages": [
              {
                "@number": '1',
                "Weight": 2,
                "Dimensions": {
                  "Length": 1,
                  "Width": 2,
                  "Height": 3
                },
                "CustomerReferences": 'Piece 1'
              },
              {
                "@number": '2',
                "Weight": 2,
                "Dimensions": {
                  "Length": 1,
                  "Width": 2,
                  "Height": 3
                },
                "CustomerReferences": 'Piece 2'
              }
            ]
          }
        }
      }
    end

    let(:subject) { described_class.new(payload: payload) }

    context 'with invalid request' do
      let(:account) { '140533138' }

      it 'returns error response body' do
        VCR.use_cassette('shipment_request/invalid_request') do
          result = subject.execute

          expect(result).to match(
            hash_including(
              "Notification": array_including(
                [
                  { "@code": '8009', "Message": a_kind_of(String) },
                  { "@code": '999', "Message": a_kind_of(String) }
                ]
              )
            )
          )
        end
      end
    end

    context 'with valid request' do
      let(:account) { '952670377' }

      it 'returns response body' do
        VCR.use_cassette('shipment_request/valid_request') do
          result = subject.execute

          expect(result).to match(
            hash_including(
              "Notification": [
                {
                  "@code": '0',
                  "Message": nil
                }
              ],
              "PackagesResult": {
                "PackageResult": [
                  {
                    "@number": '1',
                    "TrackingNumber": 'JD011100003640077171'
                  },
                  {
                    "@number": '2',
                    "TrackingNumber": 'JD011100003640077172'
                  }
                ]
              },
              "LabelImage": [
                {
                  "LabelImageFormat": 'PDF',
                  "GraphicImage": a_kind_of(String)
                }
              ],
              "ShipmentIdentificationNumber": 1_149_080_192
            )
          )
        end
      end
    end
  end
end
