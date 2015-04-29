require 'spec_helper'

describe Card do
  context 'associations' do
    it { should belong_to(:list) }
    it { should have_many(:movements) }
  end

  context 'valid Card'
  context 'invalid Card'
end
