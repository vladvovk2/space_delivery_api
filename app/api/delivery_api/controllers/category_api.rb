module DeliveryApi
  module Controllers
    class CategoryApi < Grape::API
      resources :categories do
        before  { authorized! }

        desc 'Information about all categories.'
        get :list do
          categories = Category.all
          present categories, with: DeliveryApi::Entities::CategoryResponce
        end

        desc 'List of products belonging to the category.'
        route_param :category_id, type: Integer do
          get :products do
            product_list = Category.includes(:products).find(params[:category_id]).products
            present product_list, with: DeliveryApi::Entities::ProductResponce
          end

          namespace :products do
            route_param :product_id, type: Integer do
              get :products do
                product = Category.find(params[:category_id]).products.find(params[:product_id])
                present product, with: DeliveryApi::Entities::ProductResponce
              end
            end
          end
        end
      end
    end
  end
end
