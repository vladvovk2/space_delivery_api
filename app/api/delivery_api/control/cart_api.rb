module DeliveryApi
  module Control
    class CartApi < Grape::API
      helpers Api::CartHelpers

      resources :carts do
        before { authorized! }

        desc 'Form for add product to cart.'
        post 'add_product/:product_id' do
          product = Product.find(params[:product_id])
          if current_cart.add_product(product).try(:save)
            { message: 'Added to cart.' }
          else
            { message: 'Quantity  increased.' }
          end
        end


        desc 'List of products added to cart.'
        get :current_cart do
          if !current_cart.line_items.empty?
            @response = current_cart.line_items.order(:product_id)
          else
            { message: 'Cart is empty.' }
          end
        end
      end
    end
  end
end
