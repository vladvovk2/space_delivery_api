GrapeSwaggerRails.options.api_key_type = 'header'
GrapeSwaggerRails.options.api_key_name = 'Authorization'
GrapeSwaggerRails.options.url          = '/api/swagger_doc.json'
GrapeSwaggerRails.options.app_name     = 'Kryla API'
GrapeSwaggerRails.options.before_action do
  if request.present?
    GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
    GrapeSwaggerRails.options.headers['Accept-Version'] = request&.params&.dig(:version)
  end
  GrapeSwaggerRails.options.headers['Accept-Version'] ||= 'v1'
end