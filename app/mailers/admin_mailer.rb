class AdminMailer < ApplicationMailer
  def new_user_waiting_for_approval(user)
    @user = user
    admin = User.find()
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end