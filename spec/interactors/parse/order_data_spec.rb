require 'rails_helper'

RSpec.describe ::Parse::OrderData, type: :service do
  include PayloadData
  include ParsedData

  let(:operation) { described_class }
  let(:result) { operation.call(params: payload) }

  describe 'parse data' do
    context 'when success' do
      let(:payload) { ActionController::Parameters.new(
        JSON.parse(valid_payload, symbolize_names: true))
      }

      it { expect(result.success?).to be true }
      it { expect(result.customer_data).to eq(customer) }
      it { expect(result.order_data).to eq(order) }
      it { expect(result.address_data).to eq(address) }
      it { expect(result.items_data).to eq(items) }
      it { expect(result.payments_data).to eq(payments) }
    end

    context 'when failed' do
      let(:payload) { ActionController::Parameters.new(
        JSON.parse(invalid_payload, symbolize_names: true))
      }

      it { expect(result.success?).to be false }
      it { expect(result.error).not_to be nil }
    end
  end
end
