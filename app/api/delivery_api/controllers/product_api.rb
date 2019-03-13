module DeliveryApi
  module Controllers
    class ProductApi < Root
      resources :products do
        before { authenticate! }

        desc 'Products list' do
          detail <<-NOTE
            Make a query for products.
            Returns an array of all products.
          NOTE
        end
        get do
          products = Product.includes(:product_types, :picture).all
          present products, with: DeliveryApi::Entities::ProductResponce::List
        end
      end
    end
  end
end
