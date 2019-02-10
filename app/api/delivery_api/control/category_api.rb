module DeliveryApi
  module Control
    class CategoryApi < Grape::API
      resources :categories do
        get :list do
          categories = Category.all
          present_with_entities(categories)
        end

        get ':id/show' do
          products = Product.where(category_id: params[:id])
          present_with_entities(products)
        end
      end
    end
  end
end
