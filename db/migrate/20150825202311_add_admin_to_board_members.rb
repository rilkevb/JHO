class AddAdminToBoardMembers < ActiveRecord::Migration
  def change
    add_column :board_members, :admin, :boolean, default: false
  end
end
