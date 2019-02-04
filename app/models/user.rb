class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_one  :promo_code

  def serializer_clazz
    DeliveryApi::Entities::UserResponce
  end

  after_create :assign_promo

  private

  def assign_promo
    PromoCode.create(user_id: self.id)
  end
end
