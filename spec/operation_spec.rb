# frozen_string_literal: true

RSpec.describe DHLExpress::Operation do
  describe 'bad requests' do
    let(:default_op_class) do
      Class.new(described_class) do
        def service
          'ShipmentRequest'
        end
      end
    end

    context 'with wrong credentials' do
      before do
        configure_client(username: 'wrong', password: 'credentials')
      end

      it 'raises an exception' do
        VCR.use_cassette('operation/wrong_credentials') do
          expect { default_op_class.new.execute }.to raise_error(DHLExpress::Errors::ResponseError) do |err|
            expect(err.message).to eq('Invalid Credentials')
            expect(err.status).to eq(401)
          end
        end
      end
    end

    context 'with invalid request body' do
      before do
        configure_client
      end

      it 'raises an exception' do
        VCR.use_cassette('operation/invalid_request') do
          expect { default_op_class.new.execute }.to raise_error(DHLExpress::Errors::ResponseError) do |err|
            expect(err.message).to eq('500')
          end
        end
      end
    end

    context 'with invalid service' do
      let(:op_class) do
        Class.new(default_op_class) do
          def service
            'ShipmentRequests'
          end
        end
      end

      before do
        configure_client
      end

      it 'raises an exception' do
        VCR.use_cassette('operation/invalid_service') do
          expect { op_class.new.execute }.to raise_error(DHLExpress::Errors::ResponseError) do |err|
            expect(err.message).to eq('404')
          end
        end
      end
    end
  end
end
