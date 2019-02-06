class PromoCode < ApplicationRecord
  belongs_to :user

  private

  before_create :generate

  def generate
    self.code = "INVITE-#{SecureRandom.hex(5)}"
    generate if PromoCode.where(code: code).exists?
  end
end
