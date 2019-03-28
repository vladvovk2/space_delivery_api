require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount DeliveryApi::Root => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
  mount Sidekiq::Web => '/sidekiq'

  root 'categories#index'

  resources :users do
    member { get :confirm_email }
  end

  resources :categories do
    resources :products, only: :show
  end

  resources :carts do
    member { get :add_product }
  end

  resources :line_items
  resources :orders
end
