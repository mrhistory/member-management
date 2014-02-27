class AddPermissionsColumnsToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :view_members, :boolean
    add_column :users, :edit_members, :boolean
    add_column :users, :view_users, :boolean
    add_column :users, :edit_users, :boolean
  end
end
