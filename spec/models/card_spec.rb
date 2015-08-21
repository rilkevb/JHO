require 'spec_helper'

describe Card do
  context 'has associations' do
    it { is_expected.to belong_to(:list) }
    it { is_expected.to have_many(:movements).dependent(:destroy) }
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end

  context 'valid Card' do
    it { is_expected.to validate_presence_of :organization_name }
    it { is_expected.to validate_length_of(:organization_name).is_at_least(3) }
    it { is_expected.to validate_presence_of :list_id }
    it { is_expected.to validate_numericality_of(:list_id).only_integer }
  end
end
