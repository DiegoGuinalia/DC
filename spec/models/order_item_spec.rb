require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { expect(described_class.ancestors).to include ApplicationRecord }

  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:item) }
  end
end
