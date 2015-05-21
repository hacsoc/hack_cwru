class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    @url = sign_in_url
    mail(to: @user.email, subject: 'Welcome to HackCWRU!')
  end
end
