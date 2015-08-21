class Movement < ActiveRecord::Base
  belongs_to :card, touch: true
  # updated_at on the associated object will be set to the current time whenever this object is saved or destroyed

  # why current list as a string instead of list id as an integer?
  # shouldn't we have a list_id for the originating list and new/current list?
  validates :card_id, presence: true, numericality: { only_integer: true }
  validates :current_list, presence: true, length: { minimum: 3 }
end
