module DeliveryApi
  module Controllers
    class CategoryApi < Root
      resources :categories do
        before { authenticate! }

        desc 'Categories list' do
          detail <<-NOTE
            Make a query for categories.
            Returns an array of all categories and belonging products.
          NOTE
        end
        get do
          categories = Category.includes(:picture, products: %i[picture product_types]).all
          present :categories, categories, with: DeliveryApi::Entities::CategoryResponce::List
        end

        route_param :category_id, type: Integer do
          namespace :products do
            desc 'Category list' do
              detail <<-NOTE
                Make a query for categories.
                Returns an array of products belonging to the category..
              NOTE
            end
            get do
              products = Category.includes(products: %i[picture product_types]).find(params[:category_id])
              present :category, products, with: DeliveryApi::Entities::CategoryResponce::List
            end

            route_param :product_id, type: Integer do
              desc 'Product' do
                detail <<-NOTE
                  Make a query for products.
                  Returns an hash of product attributes.
                NOTE
              end
              get do
                product = Category.find(params[:category_id]).products.find(params[:product_id])
                present :product, product, with: DeliveryApi::Entities::ProductResponce::Show
              end
            end
          end
        end
      end
    end
  end
end
