class Card < ActiveRecord::Base
  belongs_to :list
  has_many :movements, dependent: :destroy
  has_many :tasks, dependent: :destroy
  # Destroys associated tasks & movements when card is destroyed
  # Can also use delete, which ignores callbacks (deletes from the database directly)

  validates :list_id, presence: true, numericality: { only_integer: true }
  validates :title, presence: true, length: { minimum: 3 }

  after_create :generate_tasks
  after_save :set_next_task

  def generate_tasks
    tasks = ["Find advocate", "Contact advocate for meeting", "Apply to company", "Follow up with hiring manager about application"]
    tasks.each do |title|
      self.tasks.create(title: title)
    end
  end

  def set_next_task
    # using this implementation will require us marking skipped tasks complete
    # probably best to find a different way to handle this
    current = self.next_task
    possible = self.tasks.where(completed: false).first
    if current == possible.title
      possible.update(completed: true)
      next_task = self.tasks.where(completed: false).first
      next_task.nil? ? self.next_task = next_task.title : false
    end
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
