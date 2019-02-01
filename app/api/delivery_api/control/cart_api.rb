module DeliveryApi
  module Control
    class CartApi < Grape::API
      helpers Api::CartHelpers

      resources :carts do
        params do
          requires :id, type: Integer, desc: 'Product ID which you wnat add to cart.'
        end
        post 'add_product' do
          product = Product.find(params[:id])
          if current_cart.add_product(product).try(:save)
            { message: 'Added to cart' }
          else
            { message: 'Quantity  increased' }
          end
        end

        get 'cart' do
          current_cart.line_items
        end
      end
    end
  end
end
