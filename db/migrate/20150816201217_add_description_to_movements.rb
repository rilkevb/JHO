class AddDescriptionToMovements < ActiveRecord::Migration
  def change
    add_column :movements, :description, :string
  end
end
