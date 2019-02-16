module DeliveryApi
  module Control
    class PhoneVerificationApi < Grape::API
      helpers do
        def verification_code
          rand(1000..9999)
        end
      end

      resources :phone_verification do
        desc 'Send to user verification code.'
        get :message do
          code = verification_code

          SendVerificationMessageJob.perform_later(
            number: current_user.phone_number,
            code: code
          )
          { verification_code: code }
        end

        desc 'Activation account with verification code.'
        params { requires :responce, type: Boolean }
        post(:confirmation) { current_user.verify(declared_params[:responce]) }
      end
    end
  end
end
