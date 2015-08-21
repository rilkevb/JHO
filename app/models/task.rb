class Task < ActiveRecord::Base
  belongs_to :card, touch: true
  # sets card's updated_at timestamp when task is saved/deleted

  validates :card_id, presence: true, numericality: { only_integer: true }
  validates :title, presence: true, length: { minimum: 3 }

  # def complete
  #   self.update(completed: true)
  # end
end
