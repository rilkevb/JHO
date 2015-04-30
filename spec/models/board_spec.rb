require 'spec_helper'
require "rails_helper"

describe Board do
  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:lists) }
  end

  context 'valid Board'
  context 'invalid Board'
end
