class Board < ActiveRecord::Base
  belongs_to :user
  has_many :lists, dependent: :destroy

  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, length: { minimum: 3 }

  after_create :generate_board_lists

  def generate_board_lists
    # Update these names to more accurately depict user / hiring
    list_names = ["Organizations of Interest", "Find Advocate", "Advocate Found",
    "Application", "Cultural", "Code Challenge", "Tech Screen",
    "Onsite", "Negotiation", "Outcome"]

    list_names.each_with_index do |name,index|
      self.lists.create(name: name, position_id: index )
    end
  end
end
