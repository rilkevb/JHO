require 'spec_helper'

describe List do
  context 'has associations' do
    it { is_expected.to belong_to(:board) }
    it { is_expected.to have_many(:cards) }
  end

  context 'valid List' do
    it { is_expected.to validate_presence_of :board_id }
    it { is_expected.to validate_numericality_of(:board_id).only_integer }
    it { is_expected.to validate_presence_of :position_id }
    it { is_expected.to validate_numericality_of(:position_id).only_integer }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_length_of(:name).is_at_least(3) }
  end
end
