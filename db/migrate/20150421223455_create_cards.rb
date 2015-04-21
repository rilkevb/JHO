class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :list_id
      t.string :organization_name
      t.text :organization_summary
      t.string :position_applied_for
      t.text :position_description
      t.string :advocate
      t.string :tech_stack
      t.text :recent_articles
      t.integer :glassdoor_rating

      t.timestamps null: false
    end
  end
end
