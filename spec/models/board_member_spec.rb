require 'rails_helper'

RSpec.describe BoardMember, type: :model do
  context 'has associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:board) }
  end

  context "valid Board Member" do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_numericality_of(:user_id).only_integer }
    it { is_expected.to validate_presence_of :board_id }
    it { is_expected.to validate_numericality_of(:board_id).only_integer }
    it { is_expected.to validate_presence_of :admin }
  end
end
