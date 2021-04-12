require 'rails_helper'

RSpec.describe "Order", type: :request do

  let(:stub) { double('interactor') }

  describe 'POST #parse_order' do
    before do
      allow(PlaceOrder).to receive(:call) { stub }
      allow(stub).to receive(:error) { error }
      allow(stub).to receive(:failure?) { status }
    end

    context 'when receive a correct payload' do
      let(:error) { nil }
      let(:status) { false }

      it 'should return success' do
        post '/api/v1/orders/normalize_data'
        body = JSON.parse(response.body)

        expect(body['result']).to eq('success')
        expect(response.status).to eq(200)
      end
    end

    context 'when receive an incorrect payload' do
      let(:error) { { msg: 'test' } }
      let(:status) { true }


      it 'should return failure' do
        post '/api/v1/orders/normalize_data'
        body = JSON.parse(response.body)

        expect(body['error']).not_to be nil
        expect(body['result']).to eq('failed')
        expect(response.status).to eq(422)
      end
    end
  end
end
