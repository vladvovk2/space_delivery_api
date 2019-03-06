module DeliveryApi
  module Controllers
    class AuthApi < Root
      resources :authentication do
        desc 'User login form.'
        params do
          requires :phone_number, type: String, desc: 'User phone number'
          requires :password,     type: String, desc: 'User password'
        end
        post do
          user = User.find_by(phone_number: declared_params[:phone_number])
          if user&.authenticate(declared_params[:password])
            present :token, user.auth_token
            present :user, user, with: DeliveryApi::Entities::UserResponce
          else
            unauthorized!
          end
        end
      end
    end
  end
end
