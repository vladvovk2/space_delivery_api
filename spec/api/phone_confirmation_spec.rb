require 'rails_helper'

describe DeliveryApi::Controllers::PhoneVerificationApi, type: :api do
  let(:user) { create(:user) }

  context 'Authenticate' do
    it 'ensure error in PATCH /api/phone_verification/confirmation' do
      patch '/api/phone_verification/confirmation'
      expect(response_body).to eq(auth_error)
    end

    it 'ensure error in GET /api/phone_verification/message' do
      get '/api/phone_verification/message'
      expect(response_body).to eq(auth_error)
    end
  end

  context 'PATCH /api/phone_verification/confirmation' do
    before do
      header 'Authorization', user.auth_token
      patch '/api/phone_verification/confirmation', validation: true
    end

    it 'should return status 200' do
      expect(last_response.status).to eq(200)
    end

    it 'should return verification status' do
      expect(response_body).to include(:status)
    end

    it 'should return message if already verify' do
      patch '/api/phone_verification/confirmation', validation: true
      expect(response_body).to eq(message: 'Already verify!')
    end
  end

  context 'GET /api/phone_verification/message' do
    before do
      header 'Authorization', user.auth_token
      get '/api/phone_verification/message'
    end

    it 'should return status 200' do
      expect(last_response.status).to eq(200)
    end

    it 'should return message with code' do
      expect(response_body).to include(:verification_code)
    end
  end
end
