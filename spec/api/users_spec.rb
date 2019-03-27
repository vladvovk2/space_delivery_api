require 'rails_helper'

describe DeliveryApi::Controllers::AuthApi, type: :api do
  let(:user_response) do
    lambda do |user|
      {
        user: {
          id: user.id,
          email: user.email,
          email_confirm: user.email_confirm,
          last_name: user.last_name,
          first_name: user.first_name,
          phone_number: user.phone_number,
          balance: user.user_balance.balance,
          promo_code: user.promo_code.code
        }
      }
    end
  end

  let(:valid_params) do
    {
      user: {
        email: Faker::Internet.unique.email,
        phone_number: Faker::Number.unique.number(9),
        first_name: Faker::Name.unique.first_name,
        last_name: Faker::Name.unique.last_name,
        password: 'vladvovk2',
        password_confirmation: 'vladvovk2'
      }
    }
  end

  let(:invalid_params) do
    {
      user: {
        email: 'Invalid',
        phone_number: Faker::Number.unique.number(9),
        first_name: Faker::Name.unique.first_name,
        last_name: Faker::Name.unique.last_name,
        password: 'vladvovk2',
        password_confirmation: 'vladvovk2'
      }
    }
  end

  context 'Authenticate' do
    it 'ensure error in GET /api/users/profile' do
      get '/api/users/profile'
      expect(response_body).to eq(auth_error)
    end

    it 'ensure error in PATCH /api/users/profile' do
      patch '/api/users/profile'
      expect(response_body).to eq(auth_error)
    end
  end

  context 'POST /api/users' do
    context 'valid data' do
      before { post '/api/users', valid_params }
      it 'should return status 201' do
        expect(last_response.status).to eq(201)
      end

      it 'should return confirm message' do
        expect(response_body).to eq(user_response[User.last])
      end
    end

    context 'invalid data' do
      it 'should return status 422' do
        post '/api/users', invalid_params
        expect(last_response.status).to eq(422)
      end
    end
  end

  context 'GET /api/users/profile' do
  end

  context 'PUT /api/users/profile' do
  end
end
