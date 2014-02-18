class User < ActiveRecord::Base
  has_secure_password

  def self.search(search)
    if search
      if search.include? ';'
        search_params = search.split(pattern = ';')
        where("email_address like ?",
               parameterize(search_params[0]))
      else
        where("email_address like :search", { search: parameterize(search) })
      end
    else
      all
    end
  end

  def self.parameterize(parameter)
    parameter = '' if parameter.nil?
    '%' + parameter + '%'
  end
end
