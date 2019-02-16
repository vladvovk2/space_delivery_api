module DeliveryApi
  module Control
    class SessionApi < Grape::API
      helpers do
        params :session_params do
          requires :session, type: Hash do
            requires :phone_number,    type: String, desc: 'User email'
            requires :password, type: String, desc: 'User password'
          end
        end
      end

      resources :sessions do
        get :profile do
          present_with_entities(current_user)
        end
        params do
          use :session_params
        end
        post :login do
          user = AuthenticateUser.call(declared_params[:session])
          user.success? ? login(user) : error!(user.errors.full_messages)
        end

        delete :logout do
          logout
        end
      end
    end
  end
end
