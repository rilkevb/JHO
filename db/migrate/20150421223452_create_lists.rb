class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :board_id
      t.string :name
      t.integer :position_id

      t.timestamps null: false
    end
  end
end
