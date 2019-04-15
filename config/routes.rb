require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount DeliveryApi::Root => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
  mount Sidekiq::Web => '/sidekiq'

  root 'blogs#index'
  get  'blogs/download_menu'

  resources :orders
  resources :blogs
  resources :sessions

  resources :users do
    member do
      get :confirm_email
      get :order_list
      get :send_confirm_email
      patch :change_receipt_status
    end
  end

  resources :favorites do
    member { post :make_favorite }
  end

  resources :categories, only: :show do
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

  get :signup,   to: 'users#new',        as: :signup
  get :login,    to: 'sessions#new',     as: :login
  get :logout,   to: 'sessions#destroy', as: :logout
end
