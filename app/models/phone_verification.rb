class PhoneVerification < ApplicationRecord
  belongs_to :user, optional: true

  def verify(entered_pin)
    update(verifycation: true) if verifycation_code.eql? entered_pin
  end

  private

  before_create :generated_verification_code

  def generated_verification_code
    self.verifycation_code = SecureRandom.hex(2)
  end
end
