module DeliveryApi
  module Control
    class CartApi < Grape::API
      helpers Api::CartHelpers

      resources :carts do
        params do
          requires :id, type: Integer, desc: 'Product ID which you wnat add to cart.'
        end
        post 'add_product/:product_id' do
          product = Product.find(params[:product_id])
          if current_cart.add_product(product).try(:save)
            { message: 'Added to cart.' }
          else
            { message: 'Quantity  increased.' }
          end
        end

        get :cart do
          unless current_cart.line_items.empty?
            line_items = LineItem.where(cart_id: current_cart.id).order(:product_id)
            present_with_entities(line_items)
          else
            { message: 'Cart is empty.'}
          end
        end

        post :test do
          session[:cart_id] = nil
        end
      end
    end
  end
end
