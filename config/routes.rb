require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount DeliveryApi::Root => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
  mount Sidekiq::Web => '/sidekiq'

  resources :users do
    member { get :confirm_email }
  end
end
