class List < ActiveRecord::Base
  belongs_to :board
  has_many :cards

  validates :board_id, presence: true, numericality: { only_integer: true }
  validates :position_id, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, length: { minimum: 3 }

end
