class Card < ActiveRecord::Base
  belongs_to :list
  has_many :movements, dependent: :destroy
  has_many :tasks, dependent: :destroy
  # Destroys associated tasks & movements when card is destroyed
  # Can also use delete, which ignores callbacks (deletes from the database directly)

  validates :list_id, presence: true, numericality: { only_integer: true }
  validates :title, presence: true, length: { minimum: 3 }

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
end
