class UserMailer < ApplicationMailer
  def user_was_approved(user)
    @user = user
    mail(to: @user.email, subject: 'Assessme - Votre compte vient d\'être activé !')
  end
end