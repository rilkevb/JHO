class CreateMovementLogs < ActiveRecord::Migration
  def change
    create_table :movement_logs do |t|

      t.timestamps null: false
    end
  end
end
