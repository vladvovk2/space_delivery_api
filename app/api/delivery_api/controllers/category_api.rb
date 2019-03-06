module DeliveryApi
  module Controllers
    class CategoryApi < Root
      resources :categories do
        before { authenticate! }

        desc 'Information about all categories.'
        get do
          categories = Category.all
          present categories, with: DeliveryApi::Entities::CategoryResponce
        end

        route_param :category_id, type: Integer do
          desc 'List of products belonging to the category.'
          namespace :products do
            get do
              product_list = Category.includes(:products).find(params[:category_id]).products
              present product_list, with: DeliveryApi::Entities::ProductResponce
            end

            route_param :product_id, type: Integer do
              get do
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
