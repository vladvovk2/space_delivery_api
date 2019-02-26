module DeliveryApi
  class Root < Grape::API
    version 'v1', using: :path, vendor: 'delivery'
    format :json
    prefix :api

    rescue_from :all

    rescue_from ActiveRecord::RecordNotFound do
      error!('Record not found!', 404)
    end

    helpers DeliveryApi::Helpers::BaseHelpers
    helpers DeliveryApi::Helpers::SessionHelpers

    mount DeliveryApi::Controllers::ProductApi
    mount DeliveryApi::Controllers::CategoryApi
    mount DeliveryApi::Controllers::LineItemApi
    mount DeliveryApi::Controllers::CartApi
    mount DeliveryApi::Controllers::OrderApi
    mount DeliveryApi::Controllers::UserApi
    mount DeliveryApi::Controllers::SessionApi
    mount DeliveryApi::Controllers::FavoriteApi
    mount DeliveryApi::Controllers::PhoneVerificationApi

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
