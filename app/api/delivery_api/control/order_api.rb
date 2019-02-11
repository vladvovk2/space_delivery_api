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
            requires :delivery_type,  type: String, desc: 'TakeOut | Delivery.'
            requires :pay_type,       type: String, desc: 'Cash || Terminal.'
            optional :promo_code,     type: String, desc: '7a8ccc0e35'
            optional :description,    type: String, desc: 'Wishes.'
          end
        end
      end

      resources :orders do
        desc 'Make order', entity: DeliveryApi::Entities::OrderResponce
        params do
          use :order_params
        end
        post :create do
          PromoCodeValidate.call(current_user, declared_params[:order][:promo_code]) do
            on(:nil) { present(message: 'Ok.') }
            on(:not_exist) { return present(message: 'Promo code is invalid.') }
            on(:owner) { return present(message: 'You cant use your own referal promo.') }
          end

          CreateOrder.call(current_user, current_cart, declared_params[:order]) do
            on(:empty_cart) { present(message: 'Cart is empty.') }
            on(:ok)   { |order| present_with_entities(order) }
            on(:fail) { |order| error!(order.errors.full_messages) }
          end
        end

        params do
          requires :status, type: Boolean
          requires :id, type: Integer
        end
        patch :test do
          order = Order.find(params[:id])
          order.update(status: params[:status])
        end
      end
    end
  end
end