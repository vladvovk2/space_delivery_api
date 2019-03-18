require 'spec_helper'

describe DeliveryApi::Controllers::ProductApi do
  def app
    DeliveryApi::Controllers::ProductApi
  end

  context 'api/products' do
    it 'shoud return positive status' do
      get '/api/products'
      expect(last_response.status).to eq(200)
    end
  end
end
