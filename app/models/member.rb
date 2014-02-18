class Member < ActiveRecord::Base

  def self.search(search)
    if search
      if search.include? ';'
        search_params = search.split(pattern = ';')
        where("first_name like ? and
               last_name like ? and
               email_address like ? and
               address1 like ? and
               city like ? and
               state like ? and
               zipcode like ? and
               phone_number like ?",
               parameterize(search_params[0]),
               parameterize(search_params[1]),
               parameterize(search_params[2]),
               parameterize(search_params[3]),
               parameterize(search_params[4]),
               parameterize(search_params[5]),
               parameterize(search_params[6]),
               parameterize(search_params[7]))
      else
        where("first_name like :search or
               last_name like :search or
               email_address like :search or
               phone_number like :search or
               address1 like :search or
               city like :search or
               state like :search or
               zipcode like :search", { search: parameterize(search) })
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
