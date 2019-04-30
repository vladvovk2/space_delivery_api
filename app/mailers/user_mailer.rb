class UserMailer < ApplicationMailer
  def confirm_email(id)
    @user = User.find(id)
    mail(to: @user.email, subject: 'Подтверждение email адреса.')
  end
end
