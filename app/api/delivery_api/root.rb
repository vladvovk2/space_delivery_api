module DeliveryApi
  class Root < Grape::API
    format  :json

    rescue_from :all

    add_swagger_documentation(
      api_version: 'v1',
      hide_documantation_path: true,
      hide_format: true,
      info: {
        title: 'API documantation'
  })
  end
end
