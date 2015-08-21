require 'spec_helper'

describe User do
  context 'associations' do
    it { is_expected.to have_many(:boards).dependent(:destroy) }
  end

  context 'valid User' do
    it { is_expected.to have_secure_password }

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }

    it { is_expected.to validate_presence_of :email }
    it { is_expected.to allow_value('test@test.com').for(:email) }
    it { is_expected.to allow_value('first.last@mail.com').for(:email) }
    it { is_expected.to allow_value('startup@test.io').for(:email) }
    it { should_not allow_value('fraud').for(:email) }
    it { should_not allow_value('not@okay').for(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it { is_expected.to validate_uniqueness_of :email }

    it { is_expected.to validate_presence_of :password }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end
end
