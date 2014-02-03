class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :email_address
      t.string :first_name
      t.string :last_name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone_number

      t.timestamps
    end
  end
end
