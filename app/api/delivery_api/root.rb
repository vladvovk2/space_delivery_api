module DeliveryApi
  class Root < Grape::API
    version 'v1', using: :header, vendor: 'delivery'
    format :json

    rescue_from :all
    helpers Api::BaseHelpers
    
    mount DeliveryApi::Control::ProductApi

    add_swagger_documentation(
      api_version: 'v1',
      hide_documantation_path: true,
      hide_format: true,
      info: {
        title: 'API documantation'
  })
  end
end
