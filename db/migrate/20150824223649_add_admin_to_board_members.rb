class AddAdminToBoardMembers < ActiveRecord::Migration
  def change
    add_column :board_members, :admin, :boolean, null: false, default: false
  end
end
