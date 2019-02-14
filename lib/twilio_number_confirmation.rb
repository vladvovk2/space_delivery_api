class TwilioNumberConfirmation
  class << self
    def send_verify_message(number: nil, code: nil)
      client.messages.create(
        from: ENV['TWILIO_NUMBER'],
        to: "+380#{number}",
        body: "Your verification code: #{code}!"
      )
    end

    private

    def client
      Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
    end
  end
end
