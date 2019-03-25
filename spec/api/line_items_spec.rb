require 'rails_helper'

describe DeliveryApi::Controllers::LineItemApi, type: :api do
  def app
    DeliveryApi::Controllers::LineItemApi
  end

  describe 'LineItem' do

    # <--- Authenticate --->
    context 'Authenticate' do
      it 'ensure error in /api/line_items/:id' do
        delete '/api/line_items/1'
        expect(response_body).to eq(auth_error)
      end

      it 'ensure error in /api/line_items/:id/quantity' do
        patch '/api/line_items/1'
        expect(response_body).to eq(auth_error)
      end
    end
  end
end
