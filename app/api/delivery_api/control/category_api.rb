module DeliveryApi
  module Control
    class CategoryApi < Grape::API
      resources :categories do
        before  { authorized! }

        desc 'Information about all categories.'
        get(:list) { @response = Category.all }

        desc 'List of products belonging to the category.'
        route_param :id, type: Integer do
          get(:products) { @response = Category.find(params[:id]).products }
        end
      end
    end
  end
end
