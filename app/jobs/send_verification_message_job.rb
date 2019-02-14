class SendVerificationMessageJob < ApplicationJob
  queue_as :default

  def perform(number: nil, code: nil)
    TwilioNumberConfirmation.send_verify_message(
      number: number,
      code: code
    )
  end
end
