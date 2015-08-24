class CardAssignment < ActiveRecord::Base
  belongs_to :card
  belongs_to :user

  validates :card_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
end
