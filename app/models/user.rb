class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_one  :promo_code
  has_one  :user_balance

  def serializer_clazz
    DeliveryApi::Entities::UserResponce
  end

  private

  after_create :assign_promo

  def assign_promo
    PromoCode.create(user_id: id)
  end
end
