class PhoneVerification < ApplicationRecord
  belongs_to :user, optional: true

  def verify(entered_code)
    update(verification: true) if verification_code.eql? entered_code
  end

  def generated_verification_code
    update(verification_code: rand(1000..9999))
  end

  def delete_verification_code!
    update(verification_code: nil)
  end
  
  private

  after_create :set_number

  def set_number
    number = User.find(user_id).number
    update(phone_number: "+380#{number}")
  end
end

