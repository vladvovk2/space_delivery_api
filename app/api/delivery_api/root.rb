module DeliveryApi
  class Root < Grape::API
    version 'v1', using: :accept_version_header, vendor: 'delivery'
    format :json
    prefix :api

    rescue_from :all

    rescue_from ActiveRecord::RecordNotFound do |e|
      record_class = e.to_s.split(' ').fetch(2)
      error!("#{record_class} not found!", 404)
    end

    helpers DeliveryApi::Helpers::AuthenticationHelpers
    helpers DeliveryApi::Helpers::BaseHelpers

    mount DeliveryApi::Controllers::AuthApi
    mount DeliveryApi::Controllers::CartApi
    mount DeliveryApi::Controllers::CategoryApi
    mount DeliveryApi::Controllers::FavoriteApi
    mount DeliveryApi::Controllers::LineItemApi
    mount DeliveryApi::Controllers::OrderApi
    mount DeliveryApi::Controllers::PhoneVerificationApi
    mount DeliveryApi::Controllers::UserApi

    add_swagger_documentation(
      api_version: 'v1',
      hide_documantation_path: true,
      hide_format: true,
      info: {
        title: 'Kryla API documantation'
      }
    )
  end
end
