class UserMailer < ApplicationMailer
  def confrim_email(user)
    @user = user
    mail(to: @user.email, subject: 'Подтверждение email адреса.')
  end
end
