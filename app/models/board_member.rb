class BoardMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :board

  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :board_id, presence: true, numericality: { only_integer: true }
  # validates :admin, presence: true
end
