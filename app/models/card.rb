class Card < ActiveRecord::Base
  belongs_to :list
  has_many :movements
  has_many :statuses

  validates_presence_of :organization_name
end
