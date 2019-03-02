module DeliveryApi
  module Controllers
    class ProductApi < Grape::API
      resources :products do
        before { authorized! }

        get do
          products = Product.all
          present products, with: DeliveryApi::Entities::ProductResponce
        end
      end
    end
  end
end
