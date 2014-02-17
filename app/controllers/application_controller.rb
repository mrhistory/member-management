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
        redirect_to login_path
      else
        session[:user] = cookies[:user]
    end 
  end
end
