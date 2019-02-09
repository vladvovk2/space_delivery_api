module DeliveryApi
  module Control
    class CategoryApi < Grape::API
      helpers do
        params :category_params do
          requires :category, type: Hash do
            requires :title, type: String, desc: 'Category title.'
          end
        end
      end

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
