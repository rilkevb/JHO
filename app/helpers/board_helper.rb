module BoardHelper
  def generate_board_lists(board)
    list_names = ["Organizations of Interest", "Find Advocate",
    "Application", "Cultural", "Code Challenge", "Tech Screen",
    "Onsite", "Negotiation", "Outcome"]

    list_names.each_with_index do |name,index|
      board.lists.create(name: name, position_id: (index+1) )
    end
  end
end
