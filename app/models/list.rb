class List < ActiveRecord::Base
  belongs_to :board
  has_many :cards

  validates_presence_of :board_id, :position_id, :name
end
