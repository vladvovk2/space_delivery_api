module DeliveryApi
  module Controllers
    class ProductApi < Root
      resources :products do
        before { authenticate! }

        get do
          products = Product.includes(:product_types, :picture).all
          present products, with: DeliveryApi::Entities::ProductResponce::List
        end
      end
    end
  end
end
