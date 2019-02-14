module DeliveryApi
  module Control
    class PhoneVerificationApi < Grape::API
      resources :phone_verification do
        params do
          requires :confirmation_code, type: String
        end
        post :confirmation do
          current_user.phone_verification.verify(declared_params[:confirmation_code])
        end
      end
    end
  end
end
