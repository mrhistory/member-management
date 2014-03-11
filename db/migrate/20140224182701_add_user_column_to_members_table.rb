class AddUserColumnToMembersTable < ActiveRecord::Migration
  def change
    add_column :members, :user_id, :integer, index: true
  end
end
