class User < ApplicationRecord

  def favorite_records
    @favorite_records ||= self.favorites
  end

  def balance_record
    @balance ||= self.user_balance.balance
  end

  def auth_token
    payload = { user_id: id }
    JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256'
  end

  def verify(value)
    update(verification: value)
  end

  has_secure_password
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/.freeze

  has_one  :promo_code,         dependent: :destroy
  has_one  :user_balance,       dependent: :destroy
  has_one  :cart,               dependent: :destroy
  has_many :favorites,          dependent: :destroy
  has_many :orders,             dependent: :destroy

  validates :first_name, :last_name, presence: true,
                                     length: { in: 2..20 }
  validates :phone_number, presence: true,
                           length: { is: 9 },
                           uniqueness: true,
                           numericality: { only_integer: true },
                           on: :create
  validates :email, presence: true,
                    format: { with: EMAIL_REGEXP },
                    uniqueness: { case_sensitive: false }

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
