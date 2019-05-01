class ChargeBonusesJob < ApplicationJob
  queue_as :default

  after_enqueue { ActionCable.server.broadcast :notifiations, message: "Charged #{balance} bonuses." }

  def perform(user_id, promocode_id, price)
    @price     = price
    @user      = User.find(user_id) if user_id
    @promocode = PromoCode.find(promocode_id) if promocode_id

    charge_bonuses(@user, @price, @promocode)
  end

  attr_accessor :balance

  private

  def charge_bonuses(user, price, promocode)
    return nil unless user

    if promocode&.invite
      promocode_owner = PromoCode.user.user_balance
      promocode_owner.update(balance: promocode_owner.balance + 40)
    else
      user_balance = user.user_balance
      user_balance.update(balance: user_balance.balance + price * 0.05)
    end
  end
end
