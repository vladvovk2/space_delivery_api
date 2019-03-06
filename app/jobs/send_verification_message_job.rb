class SendVerificationMessageJob < ApplicationJob
  queue_as :messages

  def perform(number: nil, code: nil)
    TwilioNumberConfirmation.send_verification_message(
      number: number,
      code: code
    )
  end
end
