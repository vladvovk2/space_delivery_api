module DeliveryApi
  module Controllers
    class CartApi < Root
      helpers DeliveryApi::Helpers::CartHelpers

      resources :cart do
        before { authenticate! }

        desc 'List of products added to cart.'
        get do
          if !current_cart.line_items.empty?
            products = current_cart.line_items.order(:product_type_id)
            present total_price: current_cart.total_price
            present :proucts, products, with: DeliveryApi::Entities::LineItemResponce
          else
            present(message: 'Cart is empty.')
          end
        end

        route_param :product_type_id, type: Integer do
          desc 'Form for add product to cart.'
          post do
            product = ProductType.find(params[:product_type_id])

            if current_cart.add_product(product).try(:save)
              present(message: 'Added to cart.')
            else
              present(message: 'Quantity  increased.')
            end
          end
        end
      end
    end
  end
end
