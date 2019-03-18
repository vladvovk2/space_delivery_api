class User < ApplicationRecord
  has_secure_password
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/.freeze

  has_one  :promo_code,   dependent: :destroy
  has_one  :user_balance, dependent: :destroy
  has_one  :cart,         dependent: :destroy
  has_many :favorites,    dependent: :destroy
  has_many :orders,       dependent: :destroy

  def favorite_records
    @favorite_records ||= favorites
  end

  def auth_token
    payload = { user_id: id }
    JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256'
  end

  def verify(value)
    update(verification: value)
  end

  def email_activate
    self.email_confirm = true
    self.confirm_token = nil
    save!(validate: false)
  end

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
  before_create :confirmation_token

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

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end
end
