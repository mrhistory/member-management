module UsersHelper

  def display_permission(permission_field, permission_name)
    if permission_field
      (permission_name + "<br/>").html_safe
    end
  end

end
