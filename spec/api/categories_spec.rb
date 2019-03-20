require 'rails_helper'

describe DeliveryApi::Controllers::CategoryApi, type: :api do
  def app
    DeliveryApi::Controllers::CategoryApi
  end

  describe 'Categories' do
    let(:user) { create(:user) }

    before { header 'Authorization', user.auth_token }

    context 'GET /api/categories' do
      it 'shoud return positive status' do
        get '/api/categories'
        expect(last_response.status).to eq(200)
      end

      # <--- RESPONCE PARAMS --->
    end
  end
end
