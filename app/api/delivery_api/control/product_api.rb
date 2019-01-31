module DeliveryApi
  module Control
    class ProductApi < Grape::API
      resources :items do 
        get 'products' do
          Product.all
        end
        params do
          requires :product, type: Hash do
            requires :title,       type: String
            requires :description, type: String
            requires :price,       type: Integer
          end
        end
        post do 
          product = Product.create(declared_params[:product])
          present product, with: DeliveryApi::Entities::ProductResponce
        end
      end
    end
  end
end