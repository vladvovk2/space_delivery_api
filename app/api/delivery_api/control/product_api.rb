module DeliveryApi
  module Control
    class ProductApi < Grape::API
      resources :products do
        get :list do
          products = Product.all
          present_with_entities(products)
        end

        get ':id/show' do
          product = Product.find(params[:id])
          present_with_entities(product)
        end
      end
    end
  end
end
