class User < ApplicationRecord
  has_secure_password

  has_one  :promo_code,         dependent: :destroy
  has_one  :user_balance,       dependent: :destroy
  has_one  :phone_verification, dependent: :destroy
  has_many :favorites,          dependent: :destroy
  has_many :orders,             dependent: :destroy

  def serializer_clazz
    DeliveryApi::Entities::UserResponce
  end

  private

  after_create :assign_promo_code
  after_create :assign_balance
  after_create :assign_phone_verification

  def assign_promo_code
    PromoCode.create(user_id: id, invite: true)
  end

  def assign_balance
    UserBalance.create(user_id: id)
  end

  def assign_phone_verification
    PhoneVerification.create(user_id: id)
  end
end
