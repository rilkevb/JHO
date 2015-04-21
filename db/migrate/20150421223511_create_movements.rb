class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movement_logs do |t|
      t.string :current_list
      t.integer :card_id

      t.timestamps null: false
    end
  end
end
