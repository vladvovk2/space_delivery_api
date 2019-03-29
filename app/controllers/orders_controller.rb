class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :first_name, :last_name, :delivery_type, :pay_type, :address, :user_number, :decription, :promo_code)
  end
end
