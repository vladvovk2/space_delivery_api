require 'rails_helper'

describe DeliveryApi::Controllers::LineItemApi, type: :api do
  let(:user) { create(:user) }
  let(:cart) { user.cart }
  let(:product) { create(:product) }

  # <--- Authenticate --->
  context 'Authenticate' do
    it 'ensure error in DELETE /api/line_items/:id' do
      delete '/api/line_items/1'
      expect(response_body).to eq(auth_error)
    end

    it 'ensure error in PATCH /api/line_items/:id/quantity' do
      patch '/api/line_items/1/quantity?quantity=1'
      expect(response_body).to eq(auth_error)
    end
  end

  # <--- PATCH /api/line_items/:id/quantity --->
  context 'PATCH /api/line_items/:id/quantity' do
    before { header 'Authorization', user.auth_token }

    # <--- INVALID DATA --->
    context 'invalid data' do
      context 'quantity negative value' do
        before do
          put "/api/cart/add/#{product.product_types.first.id}"
          patch "/api/line_items/#{cart.line_items.first.id}/quantity?quantity=-1"
        end

        it 'should return status 400' do
          expect(last_response.status).to eq(400)
        end

        it 'should return error message' do
          expect(response_body).to eq(error: 'Quantity must be positive!')
        end
      end

      context 'line_item not found' do
        before { patch '/api/line_items/0/quantity?quantity=1' }

        it 'should return status 404' do
          expect(last_response.status).to eq(404)
        end

        it 'should return error message' do
          expect(response_body).to eq(error: 'LineItem not found!')
        end
      end

      context 'missing quantity' do
        before { patch '/api/line_items/0/quantity' }

        it 'should return status 500' do
          expect(last_response.status).to eq(500)
        end

        it 'should return error message' do
          expect(response_body).to eq(error: 'quantity is missing')
        end
      end
    end

    # <--- VALID DATA --->
    context 'valid data' do
      before do
        put "/api/cart/add/#{product.product_types.first.id}"
        patch "/api/line_items/#{cart.line_items.first.id}/quantity?quantity=#{rand(1..3)}"
      end

      it 'should return status 200' do
        expect(last_response.status).to eq(200)
      end

      it 'should return error message' do
        expect(response_body).to eq(message: 'Quantity updated!', quantity: cart.line_items.first.quantity)
      end
    end
  end

  # <--- DELETE /api/line_items/:id --->
  context 'DELETE /api/line_items/:id' do
    before do
      header 'Authorization', user.auth_token
      put "/api/cart/add/#{product.product_types.first.id}"
    end

    # <--- INVALID DATA --->
    context 'invalid data' do
      before { delete '/api/line_items/0' }

      it 'should return status 404' do
        expect(last_response.status).to eq(404)
      end

      it 'should return error message' do
        expect(response_body).to eq(error: 'LineItem not found!')
      end
    end

    # <--- VALID DATA --->
    context 'valid data' do
      before { delete "/api/line_items/#{cart.line_items.first.id}" }

      it 'should return status 200' do
        expect(last_response.status).to eq(200)
      end

      it 'should return error message' do
        expect(response_body).to eq(message: 'Deleted.')
      end
    end
  end
end
