class User < ActiveRecord::Base

  def self.search(search)
    if search
      where("email_address like :search", { search: '%' + search + '%' })
    else
      scoped
    end
  end
end
