class AddNextTaskToCards < ActiveRecord::Migration
  def change
    add_column :cards, :next_task, :string, default: "Find Advocate"
  end
end
