class ChargeBonusesJob < ApplicationJob
  queue_as :default

  def perform(value)
    promo_code = PromoCode.find_by(code: value)
    balance = user_balance(promo_code.user_id)
    charge_bonuses(balance)
  end

  private

  def user_balance(id)
    UserBalance.find_by(user_id: id)
  end

  def charge_bonuses(user_balance)
    user_balance.balance += 50
    user_balance.save
  end
end
