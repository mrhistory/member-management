class AddMemberColumnToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :member, :integer, index: true
  end
end
