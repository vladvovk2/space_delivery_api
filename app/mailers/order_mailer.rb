class OrderMailer < ApplicationMailer
  def issued_order(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Welcome')
  end
end
