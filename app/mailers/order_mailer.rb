class OrderMailer < ApplicationMailer
  def issued_order(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome')
  end
end
