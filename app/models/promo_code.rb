class PromoCode < ApplicationRecord
  belongs_to :user
  after_create :generate

  private

  def generate
    self.code = "invite_#{SecureRandom.hex 6}"
    self.save
  end
end
