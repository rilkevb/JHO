require 'rails_helper'

RSpec.describe CardAssignment, type: :model do
  context 'has associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:card) }
  end

  context "valid CardAssignment" do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_numericality_of(:user_id).only_integer }
    it { is_expected.to validate_presence_of :card_id }
    it { is_expected.to validate_numericality_of(:card_id).only_integer }
  end
end
