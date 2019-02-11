class Order < ApplicationRecord
  has_many :line_items
  belongs_to :user

  def get_product(cart)
    cart.line_items.each do |line_item|
      line_item.cart_id = nil
      line_items.push(line_item)
    end
  end

  def serializer_clazz
    DeliveryApi::Entities::OrderResponce
  end

  private

  before_update :charge_bonuses_to_promo_code_owner

  def charge_bonuses_to_promo_code_owner
    if status_changed? && (self.status.eql? true) && self.promo_code
      ChargeBonusesJob.perform_later(self.promo_code)
    end
  end
end