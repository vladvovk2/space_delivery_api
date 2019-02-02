module DeliveryApi
  module Control
    class CategoryApi < Grape::API
      helpers do
        params :category_params do
          requires :category, type: Hash do
            requires :title, type: String, desc: 'Category title.'
          end
        end

        params :category_id do
          requires :id, type: String, desc: 'Category ID.'
        end
      end

      resources :categories do
        get :list do
          categories = Category.all
          present_with_entities(categories)
        end

        params do
          use :category_params
        end
        post :create do
          category = Category.create(declared_params[:category])
          present_with_entities(category)
        end

        params do
          use :category_id
        end
        get :show do
          category = Category.find(params[:id])
          products = Product.where(category_id: category.id)
          present_with_entities(products)
        end
      end
    end
  end
end
