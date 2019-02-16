module DeliveryApi
  module Control
    class LineItemApi < Grape::API
      helpers Api::CartHelpers

      helpers do
        def line_item
          current_cart.line_items.find(params[:id])
        end
      end

      resources :line_items do
        before { authorized! }

        route_param :id do
          desc 'Change product quantity.'
          params { requires :quantity, type: Integer }
          patch :quantity do
            line_item.change_quantity(declared_params[:quantity])
            present_with_entities(line_item)
          end

          desc 'Delete product from cart.'
          delete(:destroy) { { message: 'Deleted.' } if line_item.destroy }
        end
      end
    end
  end
end
