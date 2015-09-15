class AddArchivedToCard < ActiveRecord::Migration
  def change
    add_column :cards, :archived, :boolean, default: false
  end
end
