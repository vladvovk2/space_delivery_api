module DeliveryApi
  module Control
    class CartApi < Grape::API
      helpers Api::CartHelpers

      resources :carts do
        before do
          authorized!
        end

        post 'add_product/:product_id' do
          product = Product.find(params[:product_id])
          if current_cart.add_product(product).try(:save)
            { message: 'Added to cart.' }
          else
            { message: 'Quantity  increased.' }
          end
        end

        get :current_cart do
          if !current_cart.line_items.empty?
            line_items = current_cart.line_items.order(:product_id)
            present_with_entities(line_items)
          else
            { message: 'Cart is empty.' }
          end
        end
      end
    end
  end
end
