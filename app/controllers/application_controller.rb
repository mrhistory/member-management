class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_tab(tab_name)
    session[:tab] = tab_name
  end

  def authenticate!
    if session[:user].nil?
      if cookies.signed[:user].nil?
        redirect_to(login_path)
        return false
      else
        session[:user] = cookies[:user]
        return true
      end
    end 
  end

  def redirect_if_view_members_not_allowed!
    user = User.find(session[:user])
    if !user.view_members_allowed?
      if user.view_users_allowed?
        redirect_to(users_path)
        return false
      else
        redirect_to(settings_path)
        return false
      end
    else
      return true
    end
  end

  def redirect_if_edit_members_not_allowed!
    if !User.find(session[:user]).edit_members_allowed?
      redirect_to(members_path)
      return false
    else
      return true
    end
  end

  def redirect_if_view_users_not_allowed!
    user = User.find(session[:user])
    if !user.view_users_allowed?
      if user.view_members_allowed?
        redirect_to(members_path)
        return false
      else
        redirect_to(settings_path)
        return false
      end
    else
      return true
    end
  end

  def redirect_if_edit_users_not_allowed!
    if !User.find(session[:user]).edit_users_allowed?
      redirect_to(users_path)
      return false
    else
      return true
    end
  end
end
