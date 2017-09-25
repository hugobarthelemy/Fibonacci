class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail to: @user.email, subject: "Welcome at Enercoop !"
  end
end
