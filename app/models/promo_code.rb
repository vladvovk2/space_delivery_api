class PromoCode < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order, optional: true
  belongs_to :category, optional: true

  private

  before_create :generate

  def generate
    self.code = SecureRandom.hex(6)
    generate if PromoCode.where(code: code).exists?
  end
end
