class PromoCode < ApplicationRecord
  belongs_to :user

  private

  after_create :generate

  def generate
    update(code: "invite_#{SecureRandom.hex(5)}")
  end
end
