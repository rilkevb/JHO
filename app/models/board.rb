class Board < ActiveRecord::Base
  belongs_to :user
  has_many :lists, dependent: :destroy

  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, length: { minimum: 3 }

  after_create :generate_board_lists

  def generate_board_lists
    list_names = ["Organizations of Interest", "Find Advocate", "Advocate Found",
                  "Application", "Cultural", "Code Challenge", "Tech Screen",
                  "Onsite", "Negotiation", "Outcome"]

    list_names.each_with_index do |name,index|
      self.lists.create(name: name, position_id: (index+1) )
    end
  end

  def build_dashboard
    lists = self.lists
    cards = lists.map { |list| list.cards }

    # create a hash of the board's attributes
    board_hash = self.attributes
    board_hash["lists"] = []

    # build out nested board hash by adding lists and cards
    self.lists.each_with_index do |list, index|
      board_hash["lists"] << list.attributes
      board_hash["lists"][index]['cards'] = list.cards
    end

    # should refactor this to use ActiveModel::Serializer
    # refactor for efficiency
    # board.lists.include(:cards).to_json
    dashboard = { board: board_hash, lists: lists, cards: cards }
  end
end
