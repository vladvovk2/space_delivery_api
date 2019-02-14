module DeliveryApi
  module Control
    class UserApi < Grape::API
      helpers do
        params :user_params do
          requires :user, type: Hash do
            requires :email,                  type: String, desc: 'User email.'
            requires :first_name,             type: String, desc: 'User nickname.'
            requires :last_name,              type: String, desc: 'User nickname.'
            requires :number,                 type: String, desc: 'User number.'
            requires :password,               type: String, desc: 'User password.'
            requires :password_confirmation,  type: String, desc: 'Confirm user password typed above.'
          end
        end
      end

      resources :users do
        get :all do
          user = User.all
          present_with_entities(user)
        end

        desc 'User form for registration', entity: DeliveryApi::Entities::UserResponce
        params do
          use :user_params
        end
        post :sing_up do
          user = User.new(declared_params[:user])
          if user.save
            user.phone_verification.update(phone_number: declared_params[:user][:number])

            SendVerificationMessageJob.perform_later(
              number: user.phone_verification.phone_number,
              code: user.phone_verification.verifycation_code
            )
          else
            error!(user.errors.full_messages)
          end
        end

        delete ':id' do
          User.find(params[:id]).destroy
        end
      end
    end
  end
end
