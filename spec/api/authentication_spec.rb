require 'rails_helper'

describe DeliveryApi::Controllers::AuthApi, type: :api do
  def app
    DeliveryApi::Controllers::AuthApi
  end

  describe 'User authentication' do
    context 'POST /api/authentication' do
      let(:user) { FactoryBot.create(:user) }
      let(:body) do
        {
          phone_number: '+380687285102',
          password: 'vladvovk2'
        }
      end
      it 'shoud return positive status' do
        post '/api/authentication', body, { 'Content-Type' => 'application/json' }
        expect(last_response.status).to eq(201)
      end
    end
  end
end
