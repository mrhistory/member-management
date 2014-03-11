class LoginController < ApplicationController
  # GET /login
  def login
    set_tab(:login)
  end

  # POST /authenticate
  def authenticate
    @user = User.where(email_address: params[:email_address]).first.try(:authenticate, params[:password])
    if @user
      session[:user] = @user.id
      cookies.signed[:user] = session[:user] unless params[:remember_me] != '1'
      if @user.member.nil?
        redirect_to settings_path
      else
        redirect_to members_path
      end
    else
      session[:user] = nil
      @error = 'Incorrect email address or password.'
      render action: 'login'
    end
    set_tab(:login)
  end

  # GET /logout
  def logout
    cookies.delete :user
    reset_session
    redirect_to login_path
  end

end