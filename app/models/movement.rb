class Movement < ActiveRecord::Base
  belongs_to :card, touch: true
  # updated_at on the associated object will be set to the current time whenever this object is saved or destroyed
  before_save :get_list_from_card

  # why current list as a string instead of list id as an integer?
  # shouldn't we have a list_id for the originating list and new/current list?
  validates :card_id, presence: true, numericality: { only_integer: true }
  validates :current_list, presence: true, length: { minimum: 3 }

  def get_list_from_card
    self.current_list = self.card.list.name
  end
end
