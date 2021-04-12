require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { expect(described_class.ancestors).to include ApplicationRecord }

  describe 'associations' do
    it { should have_many(:orders) }
  end
end
