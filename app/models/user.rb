class User < ApplicationRecord
  has_secure_password

  has_one  :promo_code,         dependent: :destroy
  has_one  :user_balance,       dependent: :destroy
  has_one  :cart,               dependent: :destroy
  has_many :favorites,          dependent: :destroy
  has_many :orders,             dependent: :destroy

  def verify(value)
    update(verification: value)
  end

  def serializer_clazz
    DeliveryApi::Entities::UserResponce
  end

  private

  after_create  :assign_promo_code
  after_create  :assign_balance
  after_create  :assign_cart
  before_create :convert_phone_number

  def assign_promo_code
    PromoCode.create(user_id: id, invite: true)
  end

  def assign_balance
    UserBalance.create(user_id: id)
  end

  def assign_cart
    Cart.create(user_id: id)
  end

  def convert_phone_number
    self.phone_number = "+380#{phone_number}"
  end
end
