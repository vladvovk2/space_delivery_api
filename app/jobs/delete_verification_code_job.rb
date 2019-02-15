class DeleteVerificationCodeJob < ApplicationJob
  queue_as :messages

  def perform(customer)
    customer.delete_verification_code!
  end
end
