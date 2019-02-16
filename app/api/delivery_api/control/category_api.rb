module DeliveryApi
  module Control
    class CategoryApi < Grape::API
      resources :categories do
        before { authorized! }

        desc 'Information about all categories.'
        get(:list) { present_with_entities(Category.all) }

        desc 'List of products belonging to the category.'
        route_param :id do
          get(:products) { present_with_entities(Category.find(params[:id]).products) }
        end
      end
    end
  end
end
