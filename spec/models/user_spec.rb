require 'spec_helper'

describe User do
  context 'associations' do
    it { should have_many(:boards) }
  end

  context 'valid User'
  context 'invalid User'
end
