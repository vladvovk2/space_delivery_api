module DeliveryApi
  module Controllers
    class ProductApi < Root
      resources :products do
        before { authenticate! }

        get do
          products = Product.all
          present products, with: DeliveryApi::Entities::ProductResponce
        end
      end
    end
  end
end
