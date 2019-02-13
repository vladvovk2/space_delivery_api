class TwilioNumberConfirmation < Rectify::Command
  def initialize(user_number)
    @user_number = user_number
  end

  def call
    return broadcast(:invalid) unless user_number_valid?

  end

  private

  attr_reader :user_number

  def client
    Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
  end

  def send_verify_message(to: nil)
    client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: to,
      body: generate_verify_code
    )
  end

  def generate_verify_code
    SecureRandom.hex(4)
  end

  def converted_number
    user_number = "+380#{user_number}"
  end

  def user_number_valid?
    number_size_valid? && number_is_uniq?
  end

  def number_size_valid?
    user_number.size.eql?(9)
  end

  def number_is_uniq?
    User.where(number: user_number).exists?
  end
end
