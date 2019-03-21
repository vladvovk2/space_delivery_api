require 'rails_helper'

describe DeliveryApi::Controllers::CategoryApi, type: :api do
  def app
    DeliveryApi::Controllers::CategoryApi
  end

  describe 'Categories' do
    let(:user) { create(:user) }
    let!(:category) { create(:category) }
    let(:product) { build(:product)}
    before { header 'Authorization', user.auth_token }

    context 'GET /api/categories' do
      it 'shoud return positive status' do
        get '/api/categories'
        expect(last_response.status).to eq(200)
      end

      # <--- RESPONCE PARAMS --->
      context 'Responce params' do
        before { get '/api/categories' }

        it 'should return category[:title]' do
          expect(responce_body[:categories]).to eq(category.title)
        end
      end
    end
  end
end
