class User < ActiveRecord::Base
  has_secure_password

  def self.search(search)
    if search
      where("email_address like :search", { search: '%' + search + '%' })
    else
      all
    end
  end
end
