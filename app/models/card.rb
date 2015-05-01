class Card < ActiveRecord::Base
  belongs_to :list
  has_many :movements

  validates_presence_of :organization_name
end
