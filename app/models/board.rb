class Board < ActiveRecord::Base
  belongs_to :user
  has_many :lists

  validates_presence_of :user_id, :name
  # need to check numericality of user id and length of name (no nils)

  # moved list creation to callback instead using module in seed file
  after_create: :generate_board_lists

  def generate_board_lists
    list_names = ["Organizations of Interest", "Find Advocate",
    "Application", "Cultural", "Code Challenge", "Tech Screen",
    "Onsite", "Negotiation", "Outcome"]

    list_names.each_with_index do |name,index|
      self.lists.create(name: name, position_id: (index+1) )
    end
  end
end
