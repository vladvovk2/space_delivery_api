require 'rails_helper'

describe DeliveryApi::Controllers::CartApi, type: :api do
  let(:user) { create(:user) }
  let(:cart) { user.cart }
  let(:product) { create(:product) }
  let(:product_response) do
    lambda do |cart|
      cart.line_items.map do |line_item|
        {
          id: line_item.id,
          title: line_item.product_type.product.title,
          proportion: line_item.product_type.proportion,
          quantity: line_item.quantity,
          price: line_item.product_type.price,
          total_price: line_item.quantity * line_item.product_type.price,
          image_url: line_item.product_type.product.picture.image_name.url
        }
      end
    end
  end

  let(:cart_response) do
    {
      total_price: cart.total_price,
      products: [
        product_response[cart]
      ].flatten
    }
  end

  # <--- Authenticate --->
  context 'Authenticate' do
    it 'ensure error in GET /api/cart' do
      get '/api/cart'
      expect(response_body).to eq(auth_error)
    end

    it 'ensure error in POST /api/cart/add/:id' do
      put "/api/cart/add/#{product.product_types.first.id}"
      expect(response_body).to eq(auth_error)
    end
  end

  # <--- GET /api/cart --->
  context 'GET /api/cart' do
    before { header 'Authorization', user.auth_token }

    context 'empty cart' do
      before { get '/api/cart' }

      it 'should return status 200' do
        expect(last_response.status).to eq(200)
      end

      it 'should return message' do
        expect(response_body).to eq(message: 'Cart is empty.')
      end
    end

    context 'non-empty cart' do
      before do
        put "/api/cart/add/#{product.product_types.first.id}"
        get '/api/cart'
      end

      it 'should return status 200' do
        expect(last_response.status).to eq(200)
      end

      it 'should return valid responce' do
        expect(response_body).to eq(cart_response)
      end
    end
  end

  # <--- POST /api/cart/add/:id --->
  context 'POST /api/cart/add/:id' do
    before { header 'Authorization', user.auth_token }

    context 'valid data' do
      before { put "/api/cart/add/#{product.product_types.first.id}" }

      it 'should return status 200' do
        expect(last_response.status).to eq(200)
      end

      it 'should return confirm message' do
        expect(response_body).to eq(message: 'Added to cart.')
      end

      it 'should return other message if product already added to cart' do
        put "/api/cart/add/#{product.product_types.first.id}"
        expect(response_body).to eq(message: 'Quantity  increased.')
      end
    end

    context 'invalid data' do
      before do
        header 'Authorization', user.auth_token
        put '/api/cart/add/0'
      end

      it 'should return status 404' do
        expect(last_response.status).to eq(404)
      end

      it 'should return error message' do
        expect(response_body).to eq(error: 'ProductType not found!')
      end
    end
  end
end
