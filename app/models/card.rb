class Card < ActiveRecord::Base
  belongs_to :list
  has_many :movements
  has_many :tasks

  validates_presence_of :organization_name, :list_id

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
