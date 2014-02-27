class User < ActiveRecord::Base
  has_secure_password
  has_one :member

  scope :with_members, joins('LEFT JOIN members ON members.id = users.member_id')

  validates :email_address, uniqueness: true

  def self.search(search)
    if search
      if search.include? ';'
        search_params = search.split(pattern = ';')
        with_members.where("users.email_address like ? and
                           members.first_name like ? and
                           members.last_name like ? and
                           members.city like ? and
                           members.state like ? and
                           members.phone_number like ?",
                           parameterize(search_params[0]),
                           parameterize(search_params[1]),
                           parameterize(search_params[2]),
                           parameterize(search_params[3]),
                           parameterize(search_params[4]),
                           parameterize(search_params[5]))
      else
        with_members.where("users.email_address like :search or
                            members.first_name like :search or
                            members.last_name like :search or
                            members.city like :search or
                            members.state like :search or
                            members.phone_number like :search", { search: parameterize(search) })
      end
    else
      with_members
    end
  end

  def self.parameterize(parameter)
    parameter = '' if parameter.nil?
    '%' + parameter + '%'
  end

  def view_members_allowed?
    view_members
  end

  def edit_members_allowed?
    if APP_CONFIG[:allow_member_record_edits]
      edit_members
    else
      false
    end
  end

  def view_users_allowed?
    view_users
  end

  def edit_users_allowed?
    edit_users
  end
end
