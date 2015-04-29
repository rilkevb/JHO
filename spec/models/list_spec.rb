require 'spec_helper'

describe List do
  context 'associations' do
    it { should belong_to(:board) }
    it { should have_many(:cards) }
  end

  context 'valid List'
  context 'invalid List'
end
