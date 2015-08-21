require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:card).touch(:true) }
  end

  context 'valid Task' do
    it { is_expected.to validate_presence_of :card_id }
    it { is_expected.to validate_numericality_of(:card_id).only_integer }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_length_of(:title).is_at_least(3) }
  end
end
