module DeliveryApi
  module Controllers
    class CartApi < Root
      helpers DeliveryApi::Helpers::CartHelpers

      resources :carts do
        before { authorized! }

        desc 'Form for add product to cart.'
        post 'add_product/:product_id' do
          product = Product.find(params[:product_id])

          if current_cart.add_product(product).try(:save)
            present(message: 'Added to cart.')
          else
            present(message: 'Quantity  increased.')
          end
        end

        desc 'List of products added to cart.'
        get :current_cart do
          if !current_cart.line_items.empty?
            line_items = current_cart.line_items.order(:product_id)
            present line_items, with: DeliveryApi::Entities::LineItemResponce
          else
            present(message: 'Cart is empty.')
          end
        end
      end
    end
  end
end
