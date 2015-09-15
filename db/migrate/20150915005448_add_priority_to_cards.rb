class AddPriorityToCards < ActiveRecord::Migration
  def change
    add_column :cards, :priority, :integer, default: 1
  end
end
