module DeliveryApi
  module Control
    class CategoryApi < Grape::API
      resources :categories do
        before do
          authorized!
        end

        get :list do
          categories = Category.all
          present_with_entities(categories)
        end

        route_param :id do
          get :products do
            products = Category.find(params[:id]).products
            present_with_entities(products)
          end
        end
      end
    end
  end
end
