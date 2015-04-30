module BoardHelper
  def generate_board_lists(board)
    list_names = ["Organizations of Interest", "Finding Advocate", "Found Advocate",
    "Preparing Application", "Application Submitted", "Cultural Interview Prep",
    "Cultural Interview", "Code Challenge", "Tech Screen Prep", "Tech Screen",
    "Onsite Interview Prep", "Onsite Interview", "Negotiation", "Outcome"]

    list_names.each_with_index do |name,index|
      board.lists.create(name: name, position_id: (index+1) )
    end
  end
end
