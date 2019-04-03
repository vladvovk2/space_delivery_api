class OrdersController < ApplicationController
  include CartsHelper

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params.merge(total_price: current_cart.total_price))

    if @order.save
      @order.get_product(current_cart)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :first_name, :last_name, :delivery_type, :pay_type, :address, :user_number, :decription, :promo_code
    )
  end
end
