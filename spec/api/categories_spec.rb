require 'rails_helper'

describe DeliveryApi::Controllers::CategoryApi, type: :api do
  def app
    DeliveryApi::Controllers::CategoryApi
  end

  describe 'Categories' do
    let(:user)       { create(:user) }
    let(:category_1) { create(:category_with_products, products_count: 1) }
    let(:category_2) { create(:category_with_products, products_count: 2) }
    let(:category_3) { create(:category_with_products, products_count: 3) }

    let(:category_responce) do
      lambda do |category|
        {
          id: category.id,
          title: category.title,
          image_url: category.picture.image_name.url,
          products: [
            product_attributes[category]
          ].flatten
        }
      end
    end

    let(:product_attributes) do
      lambda do |category|
        category.products.map do |product|
          {
            id: product.id,
            category_id: product.category_id,
            title: product.title,
            description: product.description,
            image_url: product.picture.image_name.url,
            product_types: [
              product_type_attributes[product]
            ].flatten
          }
        end
      end
    end

    let(:product_type_attributes) do
      lambda do |product|
        product.product_types.map do |type|
          {
            id: type.id,
            product_id: type.product_id,
            price: type.price,
            weight: type.weight,
            proportion: type.proportion
          }
        end
      end
    end

    # <--- Authenticate --->
    context 'Authenticate' do
      it 'ensure error in /api/categories' do
        get '/api/categories'
        expect(response_body).to eq(auth_error)
      end

      it 'ensure error in /api/categories/:id/products/:id' do
        get "/api/categories/#{category_3.id}/products/#{category_3.products.first.id}"
        expect(response_body).to eq(auth_error)
      end

      it 'ensure error in /api/cart/add/1' do
        get '/api/categories/:id/products/:id'
        expect(response_body).to eq(auth_error)
      end
    end

    # <--- GET /api/categories --->
    context 'GET /api/categories' do
      before { header 'Authorization', user.auth_token }

      it 'shoud return positive status' do
        get '/api/categories'
        expect(last_response.status).to eq(200)
      end

      it 'should return valid params' do
        responce = category_1
        get '/api/categories'
        expect(response_body[:categories][0]).to eq(category_responce[responce])
      end
    end

    # <--- GET /api/categories/:id/products --->
    context 'GET /api/categories/:id/products' do
      before { header 'Authorization', user.auth_token }

      it 'shoud return positive status' do
        get "/api/categories/#{category_1.id}/products"
        expect(last_response.status).to eq(200)
      end

      it 'should return valid params' do
        responce = category_2
        get "/api/categories/#{category_2.id}/products"
        expect(response_body[:category]).to eq(category_responce[responce])
      end

      context 'invalid :id' do
        before { get '/api/categories/0/products' }

        it 'should return error message' do
          expect(response_body).to eq(error: 'Category not found!')
        end

        it 'should return status 404' do
          expect(last_response.status).to eq(404)
        end
      end
    end

    # <--- GET /api/categories/:id/products/:id --->
    context 'GET /api/categories/:id/products/:id' do
      before { header 'Authorization', user.auth_token }

      it 'shoud return positive status' do
        get "/api/categories/#{category_3.id}/products/#{category_3.products.first.id}"
        expect(last_response.status).to eq(200)
      end

      context 'invalid :id' do
        before { get "/api/categories/#{category_3.id}/products/0" }

        it 'should return error message' do
          expect(response_body).to eq(error: 'Product not found!')
        end

        it 'should return status 404' do
          expect(last_response.status).to eq(404)
        end
      end
    end
  end
end
