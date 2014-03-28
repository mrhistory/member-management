require 'securerandom'

class LoginController < ApplicationController
  # GET /login
  def login
    set_tab(:login)
  end

  # POST /login
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

  # GET /forgot
  def forgot_password
    set_tab(:login)
  end

  # POST /forgot
  def new_password
    @user = User.where(email_address: params[:email_address]).first
    if @user
      @password = SecureRandom.urlsafe_base64(8)
      if @user.update( { password: @password, password_confirmation: @password })
        UserMailer.forgot_password_email(@user, @password).deliver
        @success = 'A new password has been emailed to you.'
      else
        @error = 'Unable to reset password at this time.'
      end
      render action: 'login'
    else
      @error = 'Email address not found.'
      render action: 'login'
    end
    set_tab(:login)
  end

end