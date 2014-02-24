class UserMailer < ActionMailer::Base
  default from: "#{APP_CONFIG[:email][:from_name]} <#{APP_CONFIG[:email][:from_email]}>"

  def welcome_email(user, password)
    @user = user
    @password = password
    @url = APP_CONFIG[:base_url] + "/login"
    mail(to: @user.email_address, subject: APP_CONFIG[:email][:welcome_subject])
  end
end
