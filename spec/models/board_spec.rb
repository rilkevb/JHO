require 'spec_helper'
require "rails_helper"

describe Board do
  context 'has associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:lists).dependent(:destroy) }
  end

  context "valid Board" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_length_of(:name).is_at_least(3) }
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_numericality_of(:user_id).only_integer }
  end
end
