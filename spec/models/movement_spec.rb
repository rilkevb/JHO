require 'spec_helper'

describe Movement do
  context 'associations' do
    it { is_expected.to belong_to(:card).touch(:true) }
  end

  context 'valid Movement' do
    it { is_expected.to validate_presence_of :card_id }
    it { is_expected.to validate_numericality_of(:card_id).only_integer }
    it { is_expected.to validate_presence_of :current_list }
    it { is_expected.to validate_length_of(:current_list).is_at_least(3) }
  end
end
