module DeliveryApi
  module Controllers
    class ProductApi < Grape::API
      resources :products do
        before { authorized! }

        get :all do
          products = Product.all
          present products, with: DeliveryApi::Entities::ProductResponce
        end
      end
    end
  end
end
