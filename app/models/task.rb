class Task < ActiveRecord::Base
  belongs_to :card, touch: true

  validates_presence_of :card_id, :title

  # def complete
  #   self.update(completed: true)
  # end
end
