require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { expect(described_class.ancestors).to include ApplicationRecord }

  describe 'associations' do
    it { should belong_to(:order) }
  end
end
