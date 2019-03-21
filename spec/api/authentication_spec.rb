require 'rails_helper'

describe DeliveryApi::Controllers::AuthApi, type: :api do
  def app
    DeliveryApi::Controllers::AuthApi
  end

  describe 'User authentication' do
    context 'POST /api/authentication' do
      let!(:user)  { create(:user) }
      let(:header) { { 'Content-Type' => 'application/json' } }
      let(:valid_body) do
        {
          phone_number: '+380687285102',
          password: 'vladvovk2'
        }
      end
      let(:invalid_body) do
        {
          phone_number: '@!@#',
          password: '@!@#'
        }
      end
      let(:error) do
        {
          code: 'NOT_AUTHORIZED',
          message: 'Invalid email or password'
        }
      end

      # <--- RESPONCE STATUS --->
      context 'responce status' do
        it 'valid params should return status 201' do
          post '/api/authentication', valid_body, header
          expect(last_response.status).to eq(201)
        end

        it 'invalid params should return status 401' do
          post '/api/authentication', invalid_body, header
          expect(last_response.status).to eq(401)
        end
      end

      # <--- ERROR MESSAGES --->
      context 'error messages' do
        it 'ensure error if params invalid' do
          post '/api/authentication', invalid_body, header
          expect(responce_body).to eq(error)
        end

        it 'ensure error if params empty' do
          post '/api/authentication'
          expect(responce_body).to eq(error: 'phone_number is missing, password is missing')
        end

        it 'ensure error if params[:phone_number] empty' do
          post '/api/authentication', password: 'vladvovk2'
          expect(responce_body).to eq(error: 'phone_number is missing')
        end

        it 'ensure error if params[:password] empty' do
          post '/api/authentication', phone_number: user.phone_number
          expect(responce_body).to eq(error: 'password is missing')
        end
      end

      # <--- RESPONCE PARAMS --->
      context 'responce params' do
        before { post '/api/authentication', valid_body, header }

        it 'should return token' do
          expect(responce_body[:token]).to eq(user.auth_token)
        end

        it 'should return user[:id]' do
          expect(responce_body[:user][:id]).to eq(user.id)
        end

        it 'should return user[:first_name]' do
          expect(responce_body[:user][:first_name]).to eq(user.first_name)
        end

        it 'should return user[:last_name]' do
          expect(responce_body[:user][:last_name]).to eq(user.last_name)
        end

        it 'should return user[:phone_number]' do
          expect(responce_body[:user][:phone_number]).to eq(user.phone_number)
        end

        it 'should return user[:email]' do
          expect(responce_body[:user][:email]).to eq(user.email)
        end

        it 'should return user[:email_confirm]' do
          expect(responce_body[:user][:email_confirm]).to eq(user.email_confirm)
        end

        it 'should return user[:user_balance]' do
          expect(responce_body[:user][:user_balance]).to eq(user.user_balance.balance)
        end

        it 'should return user[:user_promo_code]' do
          expect(responce_body[:user][:user_promo_code]).to eq(user.promo_code.code)
        end
      end
    end
  end
end
