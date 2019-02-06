module DeliveryApi
  module Control
    class OrderApi < Grape::API
      helpers Api::CartHelpers
      helpers do
        params :order_params do
          requires :order, type: Hash do
            requires :first_name,     type: String, desc: 'Client name.'
            requires :second_name,    type: String, desc: 'Client surname.'
            requires :adress,         type: String, desc: 'Delivery address.'
            requires :user_number,    type: String, desc: 'Client number.'
            requires :delivery_type,  type: String, desc: 'Take out || Delivery.'
            requires :pay_type,       type: String, desc: 'Cash || Terminal.'
            optional :promo_code,     type: String, desc: 'invite_7a8ccc0e35'
            optional :description,    type: String, desc: 'Wishes.'
          end
        end
      end

      resources :orders do
        params do
          use :order_params
        end
        post :create do
          CreateOrder.call(current_user, current_cart, declared_params[:order]) do
            on(:empty_cart) { present({ message: 'Cart is empty.' }) }
            on(:promo_invalid) { present({ message: 'Promo code is invalid.' }) }
            on(:ok)   { |order| present_with_entities(order) }
            on(:fail) { |order| { errors: order.errors} }
          end
        end

        params do 
          requires :id, type: Integer
          requires :status, type: Boolean
        end
        patch do 
          order = Order.find(params[:id])
          order.update(status: params[:status])
        end
      end
    end
  end
end
