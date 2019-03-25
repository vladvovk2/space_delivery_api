require 'rails_helper'

describe DeliveryApi::Controllers::LineItemApi, type: :api do
  def app
    DeliveryApi::Root
  end

  describe 'LineItem' do
    let(:user) { create(:user) }
    let(:cart) { user.cart }
    let(:product) { create(:product) }

    # <--- Authenticate --->
    context 'Authenticate' do
      it 'ensure error in /api/line_items/:id' do
        delete '/api/line_items/1'
        expect(response_body).to eq(auth_error)
      end

      it 'ensure error in /api/line_items/:id/quantity' do
        patch '/api/line_items/1/quantity?quantity=1'
        expect(response_body).to eq(auth_error)
      end
    end

    context 'PATCH /api/line_items/:id/quantity' do
      before { header 'Authorization', user.auth_token }

      context 'invalid data' do
        context 'quantity negative value' do
          before do
            post "/api/cart/add/#{product.product_types.first.id}"
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
    end
  end
end
