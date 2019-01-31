Rails.application.routes.draw do
  mount DeliveryApi::Root => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
