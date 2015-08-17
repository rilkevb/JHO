class Movement < ActiveRecord::Base
  belongs_to :card
  # need to add touch true here

  # why current list as a string instead of list id as an integer?
  # shouldn't we have a list_id for the originating list and new/current list?
  validates_presence_of :card_id, :current_list
end
