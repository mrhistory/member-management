class AddUserColumnToMembersTable < ActiveRecord::Migration
  def change
    add_reference :members, :user, index: true
  end
end
