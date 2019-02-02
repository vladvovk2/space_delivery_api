module DeliveryApi
  module Control
    class OrderApi < Grape::API
      helpers Api::CartHelpers
      helpers do
        params :order_params do
          requires :order, type: Hash do
            requires :name,        type: String, desc: 'Client name.', default: 'vladvovk2'
            requires :adress,      type: String, desc: 'Delivery address.'
            requires :user_number, type: String, desc: 'Client number.'
            optional :description, type: String, desc: 'Wishes.'
          end
        end
      end

      resources :orders do
        params do
          use :order_params
        end
        post :create do
          order = current_user.orders.build(declared_params[:order].merge(total_price: current_cart.total_price))
          if order.save
            order.get_product(current_cart)
            OrderMailer.issued_order(current_user).deliver_now
            present_with_entities(order)
          else
            error!(order.errors)
          end
        end
      end
    end
  end
end