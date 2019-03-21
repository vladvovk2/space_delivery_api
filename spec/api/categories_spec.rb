require 'rails_helper'

describe DeliveryApi::Controllers::CategoryApi, type: :api do
  def app
    DeliveryApi::Controllers::CategoryApi
  end

  describe 'Categories' do
    let(:user) { create(:user) }
    let(:category_with_products) { create(:category_with_products, products_count: 1) }
    let(:category_responce) do
      {
        categories: [
          {
            id: category_with_products.id,
            title: category_with_products.title,
            image_url: category_with_products.picture.image_name.url,
            products: [
              {
                id: category_with_products.products.first.id,
                title: category_with_products.products.first.title,
                price: category_with_products.products.first.product_types.first.price,
                image_url: category_with_products.products.first.picture.image_name.url,
                description: category_with_products.products.first.description
              }
            ]
          }
        ]
      }
    end
    before { header 'Authorization', user.auth_token }

    context 'GET /api/categories' do
      it 'shoud return positive status' do
        get '/api/categories'
        expect(last_response.status).to eq(200)
      end

      it 'should return valid params' do
        category_with_products
        get '/api/categories'
        expect(responce_body).to eq(category_responce)
      end
    end
  end
end
