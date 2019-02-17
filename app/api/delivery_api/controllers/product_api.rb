module DeliveryApi
  module Controllers
    class ProductApi < Grape::API
      resources :products do
        before { authorized! }

        desc 'Information about all products.'
        get(:list) { @response = Product.all }

        route_param :id, type: Integer do
          desc 'Information about selected product.'
          get(:show) { @response = Product.find(params[:id]) }
        end
      end
    end
  end
end
