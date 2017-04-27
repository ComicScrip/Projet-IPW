class AdminMailer < ApplicationMailer
  def new_user_waiting_for_approval(user)
    @user = user
    admins = User.with_role(:admin)
    admins.each do |admin|
      @admin = admin
      mail(to: @admin.email, subject: 'Demande d\'activation du compte')
    end
  end
end