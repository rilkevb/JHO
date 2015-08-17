class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :card_id
      t.string :title
      t.boolean :completed, null: false, default: false
    end
  end
end
