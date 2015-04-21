class Card < ActiveRecord::Base
  belongs_to :list
  has_many :movements
end
