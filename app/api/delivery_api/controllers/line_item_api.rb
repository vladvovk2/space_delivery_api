module DeliveryApi
  module Controllers
    class LineItemApi < Root
      helpers DeliveryApi::Helpers::CartHelpers
      helpers do
        def line_item
          current_cart.line_items.find(params[:id])
        end
      end

      resources :line_items do
        before { authenticate! }

        route_param :id, type: Integer do
          desc 'Change product quantity.'
          params { requires :quantity, type: Integer }
          patch :quantity do
            item = line_item.change_quantity(declared_params[:quantity])
            present(message: "Quantity updated to #{params[:quantity]}") if item
          end

          desc 'Delete product from cart.'
          delete(:destroy) { present(message: 'Deleted.') if line_item.destroy }
        end
      end
    end
  end
end
