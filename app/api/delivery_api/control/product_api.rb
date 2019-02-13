module DeliveryApi
  module Control
    class ProductApi < Grape::API
      resources :products do
        before do
          authorized!
        end

        get :list do
          products = Product.all
          present_with_entities(products)
        end

        route_param :id do
          get :show do
            product = Product.find(params[:id])
            present_with_entities(product)
          end
        end
      end
    end
  end
end
