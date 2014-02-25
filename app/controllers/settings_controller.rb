class SettingsController < ApplicationController
  # GET /settings
  def settings
    authenticate!
    @user = User.find(session[:user])
    @errors = []
    @members = Member.where(email_address: @user.email_address)
    set_tab(:settings)
  end

  # PUT /settings
  def change_settings
    authenticate!
    @user = User.find(session[:user])
    @errors = []
    reset_user_ids(@user)
    @member = get_member(params)    
    update_member(@member, @user, params)
    update_user(@user, @member, params)
    redirect_to members_path
  rescue Exception => e
    @errors << e.message
    @user = User.find(session[:user])
    @members = Member.where(email_address: @user.email_address)
    set_tab(:settings)
    render :settings
  end
end


private

def update_user(user, member, params)
  if params[:password] != ''
    user.update(
      email_address: params[:email_address],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      member: member
    )
  else
    user.update(
      email_address: params[:email_address],
      member: member
    )
  end
end

def get_member(params)
  if params[:member_record] != '0'
    Member.find(params[:member_record])
  else
    Member.new()
  end
end

def update_member(member, user, params)
  member.update(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email_address: params[:email_address],
    phone_number: params[:phone_number],
    address1: params[:address1],
    address2: params[:address2],
    city: params[:city],
    state: params[:state],
    zipcode: params[:zipcode],
    user: user
  )
end

# Sets Members with the User Id user_id to User Id of nil
def reset_user_ids(user)
  Member.where(user_id: user.id).each do |member|
    member.update(user_id: nil)
  end
end