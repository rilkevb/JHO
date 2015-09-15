class AddPointsToCards < ActiveRecord::Migration
  def change
    add_column :cards, :points, :integer, default: 1
  end
end
