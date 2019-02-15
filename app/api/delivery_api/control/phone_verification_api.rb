module DeliveryApi
  module Control
    class PhoneVerificationApi < Grape::API
      helpers do 
        def customer
          current_user.phone_verification
        end

        def verification_code_nil?
          customer.verification_code.nil?
        end
      end

      resources :phone_verification do
        desc 'Send to user verification code.'
        get :message do
          return error!('Not yet! Time is not over.') unless verification_code_nil?
 
          code = customer.generated_verification_code
          SendVerificationMessageJob.perform_later(
            number: customer.phone_number,
            code: customer.verification_code
          )

          DeleteVerificationCodeJob.set(wait: 1.minute).perform_later(customer)
        end

        desc 'Activation account with verification code.'
        params do
          requires :confirmation_code, type: String
        end
        post :confirmation do
          return error!('Code is nil') if verification_code_nil?
          
          if customer.verify(declared_params[:confirmation_code])
            { message: 'Successful verification!' }
          else
            error!('Confirmation code is wrong!')
          end
        end
      end
    end
  end
end
