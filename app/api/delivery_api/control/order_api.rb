module DeliveryApi
  module Control
    class OrderApi < Grape::API
      helpers Api::CartHelpers
      helpers do
        params :order_params do
          requires :order, type: Hash do
            requires :name,        type: String, desc: 'Client name.'
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
          CreateOrder.call(current_user, current_cart, declared_params[:order]) do
            on(:ok)   { |order| present_with_entities(order) }
            on(:fail) { |order| { errors: order.errors} }
          end
        end
      end
    end
  end
end