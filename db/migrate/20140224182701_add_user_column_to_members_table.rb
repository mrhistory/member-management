class AddUserColumnToMembersTable < ActiveRecord::Migration
  def change
    add_column :members, :user, :integer, index: true
  end
end
