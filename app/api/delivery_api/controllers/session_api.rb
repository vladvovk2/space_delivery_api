module DeliveryApi
  module Controllers
    class SessionApi < Grape::API
      helpers do
        params :session_params do
          requires :session, type: Hash do
            requires :phone_number, type: String, desc: 'User email'
            requires :password,     type: String, desc: 'User password'
          end
        end
      end

      resources :sessions do
        desc 'User login form.'
        params { use :session_params }
        post :login do
          user = AuthenticateUser.call(declared_params[:session])
          user.success? ? login(user) : error!(user.errors)
        end

        desc 'User logout form.'
        delete(:logout) { logout }
      end
    end
  end
end
