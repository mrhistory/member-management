class Member < ActiveRecord::Base

  def self.search(search)
    if search
      where("first_name like :search or
             last_name like :search or
             email_address like :search or
             phone_number like :search or
             address1 like :search or
             city like :search or
             state like :search or
             zipcode like :search", { search: '%' + search + '%' })
    else
      scoped
    end
  end
end
