class SettingsController < ApplicationController
  before_action :authenticate!

  # GET /settings
  def settings
    @user = User.find(session[:user])
    @errors = []
    @members = Member.where(email_address: @user.email_address)
    set_tab(:settings)
  end

  # PUT /settings
  def change_settings
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
    user.email_address = params[:email_address]
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    user.member = member
  else
    user.email_address = params[:email_address]
    user.member = member
  end
  user.save!
end

def get_member(params)
  if params[:member_record] != '0'
    Member.find(params[:member_record])
  else
    Member.new()
  end
end

def update_member(member, user, params)
  member.first_name = params[:first_name]
  member.last_name = params[:last_name]
  member.email_address = params[:email_address]
  member.phone_number = params[:phone_number]
  member.address1 = params[:address1]
  member.address2 = params[:address2]
  member.city = params[:city]
  member.state = params[:state]
  member.zipcode = params[:zipcode]
  member.user = user
  member.save!
end

# Sets Members with the User Id user_id to User Id of nil
def reset_user_ids(user)
  Member.where(user_id: user.id).each do |member|
    member.update(user_id: nil)
  end
end