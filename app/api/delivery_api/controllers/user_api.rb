module DeliveryApi
  module Controllers
    class UserApi < Root
      helpers do
        params :create_user_params do
          requires :user, type: Hash do
            requires :email,                  type: String, desc: 'User email.'
            requires :phone_number,           type: String, desc: 'User number.'
            requires :first_name,             type: String, desc: 'User first name.'
            requires :last_name,              type: String, desc: 'User last name.'
            requires :password,               type: String, desc: 'User password.'
            requires :password_confirmation,  type: String, desc: 'Confirm user password typed above.'
          end
        end

        params :update_user_params do
          requires :user, type: Hash do
            optional :email,      type: String, desc: 'User email.'
            optional :first_name, type: String, desc: 'User first name.'
            optional :last_name,  type: String, desc: 'User last name.'
          end
        end
      end

      resources :users do
        desc 'User registration form.', entity: DeliveryApi::Entities::UserResponce
        params { use :create_user_params }
        post do
          user = User.new(declared_params[:user])
          if user.save
            present :user, user, with: DeliveryApi::Entities::UserResponce
          else
            error!(user.errors.messages, 422)
          end
        end

        namespace :profile do
          before { authenticate! }

          desc 'User information.'
          get { present :user, current_user, with: DeliveryApi::Entities::UserResponce }

          params { use :update_user_params }
          put do
            if current_user.update(declared_params[:user])
              present :user, current_user, with: DeliveryApi::Entities::UserResponce
            else
              error!(current_user.errors.messages, 422)
            end
          end
        end
      end
    end
  end
end
