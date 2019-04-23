class OrdersController < ApplicationController
  include ProductsHelper

  def new
    @order = Order.new
  end

  def create
    PromocodeValidation.call(params[:promo_code], current_user) do
      on(:blank) { true }
      on(:expired) do
        flash[:error] = 'Promocode is expired.'
        redirect_to new_order_path
      end
      on(:owner) do
        flash[:error] = 'You can`t use your own promocode.'
        redirect_to new_order_path
      end
      on(:used) do
        flash[:error] = 'Promocode already used.'
        redirect_to new_order_path
      end
    end

    CreateOrderWeb.call(order_params, params[:promo_code], current_user, current_cart) do
      on(:empty_cart) do
        redirect_to new_order_path
        flash[:error] = 'Cart is empty!'
      end
      on(:created) do
        redirect_to @order
        flash[:success] = 'Created.'
      end
      on(:fail) do
        redirect_to new_order_path
      end
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(
      :first_name, :last_name, :delivery_type, :pay_type, :address, :user_number, :decription,
      place_attributes: %i[id address latitude longitude]
    )
  end
end
