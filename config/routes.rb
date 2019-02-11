require 'sidekiq/web'

Rails.application.routes.draw do
  mount DeliveryApi::Root => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
  mount Sidekiq::Web => '/sidekiq'
end
