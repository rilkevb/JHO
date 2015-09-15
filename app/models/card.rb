class Card < ActiveRecord::Base
  belongs_to :list
  has_many :movements, dependent: :destroy
  has_many :tasks, dependent: :destroy
  # Destroys associated tasks & movements when card is destroyed
  # Can also use delete, which ignores callbacks (deletes from the database directly)

  validates :list_id, presence: true, numericality: { only_integer: true }
  validates :title, presence: true, length: { minimum: 3 }

  def recalculate_priority
    puts "Before recalculation the card's new list is #{self.list.name} at position: #{self.list.position_id} and the priority is #{self.priority}"
    case self.list.position_id
    when 0
      self.update(priority: 1) # Interested
      puts "&&&&&& IN CASE STATEMENT ******"
      puts "Card's new list is #{self.list.name} at position: #{self.list.position_id} and the priority is #{self.priority}"
    when 1
      self.update(priority: 2) # Find Advocate - In progress
      puts "&&&&&& IN CASE STATEMENT ******"
      puts "Card's new list is #{self.list.name} at position: #{self.list.position_id} and the priority is #{self.priority}"
    when 2
      self.update(priority: 1) # Apply - Done
      puts "&&&&&& IN CASE STATEMENT ******"
      puts "Card's new list is #{self.list.name} at position: #{self.list.position_id} and the priority is #{self.priority}"
    when 3
      self.update(priority: 2) # Apply - In progress
      puts "&&&&&& IN CASE STATEMENT ******"
      puts "Card's new list is #{self.list.name} at position: #{self.list.position_id} and the priority is #{self.priority}"
    when 4
      self.update(priority: 1) # Apply - Done
      puts "&&&&&& IN CASE STATEMENT ******"
      puts "Card's new list is #{self.list.name} at position: #{self.list.position_id} and the priority is #{self.priority}"
    when 5
      self.update(priority: 3) # Interview
      puts "&&&&&& IN CASE STATEMENT ******"
      puts "Card's new list is #{self.list.name} at position: #{self.list.position_id} and the priority is #{self.priority}"
    end
    # Will need to extend this later if we want more lists.
    p self.attributes
  end

  # schema attributes
  # :list_id,
  # :organization_name,
  # :organization_summary,
  # :position_applied_for,
  # :position_description,
  # :advocate,
  # :tech_stack,
  # :recent_articles,
  # :glassdoor_rating,
  # :title,
  # :description
  # "points",               default: 1
  # "priority",             default: 1
  # "next_task"
  # "archived",             default: false
end
