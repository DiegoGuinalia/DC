require 'rails_helper'

RSpec.describe Order, type: :model do
  it { expect(described_class.ancestors).to include ApplicationRecord }

  describe 'associations' do
    it { should belong_to(:customer) }
    it { should have_many(:order_items) }
    it { should have_many(:payments) }
    it { should have_one(:address) }
  end
end
