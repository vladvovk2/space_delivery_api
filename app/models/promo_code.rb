class PromoCode < ApplicationRecord
  belongs_to :user

  private

  before_create :generate

  def generate
    self.code = SecureRandom.hex(6)
    generate if PromoCode.where(code: code).exists?
  end
end
