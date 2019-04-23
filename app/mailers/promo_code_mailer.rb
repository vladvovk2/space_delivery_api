class PromoCodeMailer < ApplicationMailer
  def promocode(email, promocode)
    @email     = email
    @promocode = promocode
    mail(to: @email, subject: 'Подарочный промокод.')
  end
end
