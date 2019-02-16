module DeliveryApi
  module Control
    class ProductApi < Grape::API
      resources :products do
        before { authorized! }

        desc 'Information about all products.'
        get(:list) { present_with_entities(Product.all) }

        route_param :id do
          desc 'Information about selected product.'
          get(:show) { present_with_entities(Product.find(params[:id])) }
        end
      end
    end
  end
end
