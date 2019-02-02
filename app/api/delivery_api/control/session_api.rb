module DeliveryApi
  module Control
    class SessionApi < Grape::API
      helpers do 
        params :session_params do
          requires :session, type: Hash do 
            requires :email,    type: String, desc: 'User email'
            requires :password, type: String, desc: 'User password'
          end
        end
      end

      resources :session do
        get :user do
          present_with_entities(current_user)
        end
        params do
          use :session_params
        end
        post :login do
          user = AuthenticateUser.call(params[:session][:email], params[:session][:password])
          user.success? ? login(user) : { error: user.errors }
        end

        delete :logout do
          logout
        end
      end
    end
  end
end
