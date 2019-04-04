require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount DeliveryApi::Root => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
  mount Sidekiq::Web => '/sidekiq'

  root 'blogs#index'

  resources :users do
    member { get :confirm_email }
  end

  resources :categories do
    resources :products, only: :show
  end

  resources :carts do
    member { put :add_product }
  end

  resources :line_items do
    member do
      put :quantity_reduce
      put :quantity_increase
    end
  end

  resources :orders
  resources :blogs

  resources :places do
    collection do
      put :get_locations
    end
  end
end
