class SessionForm < BaseForm
  attribute :phone_number
  attribute :password

  validates :phone_number, presence: true
  validates :password, presence: true

  validate do
    errors.add(:base, :wrong_phone_number_or_password) unless user.try(:authenticate, password)
  end

  def user
    @user ||= User.find_by(phone_number: "+380#{phone_number}")
  end
end
