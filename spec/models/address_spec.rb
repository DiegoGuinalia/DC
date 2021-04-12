require 'rails_helper'

RSpec.describe Address, type: :model do
  it { expect(described_class.ancestors).to include ApplicationRecord }

  describe 'associations' do
    it { should belong_to(:order) }
  end
end
