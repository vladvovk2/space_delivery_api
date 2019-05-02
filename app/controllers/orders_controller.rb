class OrdersController < ApplicationController
  include ProductsHelper

  def new
    @order = Order.new
  end

  def show
    @order = Order.includes(:place).find(params[:id])
  end

  def create
    PromocodeValidation.call(params[:promo_code], current_user, current_cart) do
      on(:blank) { true }
      on(:error) do |message|
        flash[:error] = message
        return redirect_to new_order_path
      end
    end

    CreateOrderWeb.call(order_params, params[:promo_code], current_user, current_cart) do
      on(:empty_cart) do
        flash[:error] = 'Cart is empty!'
        redirect_to new_order_path
      end
      on(:created) do
        flash[:success] = 'Created.'
        redirect_to @order
      end
      on(:fail) do
        redirect_to new_order_path
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :first_name, :last_name, :delivery_type, :pay_type, :address, :user_number, :decription,
      place_attributes: %i[id address latitude longitude]
    )
  end
end
