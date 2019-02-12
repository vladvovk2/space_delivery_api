class User < ApplicationRecord
  has_secure_password

  has_many :orders,       dependent: :destroy
  has_one  :promo_code,   dependent: :destroy
  has_one  :user_balance, dependent: :destroy
  has_many :favorites,    dependent: :destroy

  def serializer_clazz
    DeliveryApi::Entities::UserResponce
  end

  private

  after_create :assign_promo_code
  after_create :assign_balance

  def assign_promo_code
    PromoCode.create(user_id: id, invite: true)
  end

  def assign_balance
    UserBalance.create(user_id: id)
  end
end
