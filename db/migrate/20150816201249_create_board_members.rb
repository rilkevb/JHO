class CreateBoardMembers < ActiveRecord::Migration
  def change
    create_table :board_members do |t|
      t.integer :user_id
      t.integer :board_id
    end
  end
end
