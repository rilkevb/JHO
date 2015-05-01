class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :card_id
      t.integer :list_id
      t.string :state

      t.timestamps null: false
    end
  end
end
