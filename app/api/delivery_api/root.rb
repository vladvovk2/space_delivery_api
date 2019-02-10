module DeliveryApi
  class Root < Grape::API
    version 'v1', using: :header, vendor: 'delivery'
    format :json
    prefix :api

    rescue_from :all

    helpers Api::BaseHelpers
    helpers Api::SessionHelpers

    mount DeliveryApi::Control::ProductApi
    mount DeliveryApi::Control::CategoryApi
    mount DeliveryApi::Control::LineItemApi
    mount DeliveryApi::Control::CartApi
    mount DeliveryApi::Control::OrderApi
    mount DeliveryApi::Control::UserApi
    mount DeliveryApi::Control::SessionApi
    mount DeliveryApi::Control::FavoriteApi

    add_swagger_documentation(
      api_version: 'v1',
      hide_documantation_path: true,
      hide_format: true,
      info: {
        title: 'API documantation'
      })
  end
end
