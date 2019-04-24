class SendPromocodeJob < ApplicationJob
  queue_as :promocode

  def perform(params)
    User.all.find_each do |user|
      @promocode = PromoCode.create(params)
      PromoCodeMailer.promocode(user.email, @promocode).deliver_later
    end
  end
end
