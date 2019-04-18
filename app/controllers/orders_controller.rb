class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params.merge(total_price: current_cart.total_price, user_id: current_user&.id))

    if @order.save
      @order.get_product(current_cart)
      send_receipt(current_user, @order) if current_user&.get_receipt
      GetSalesStatisticsJob.perform_later(@order)

      redirect_to root_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :first_name, :last_name, :delivery_type, :pay_type, :address, :user_number, :decription, :promo_code,
      place_attributes: %i[id address latitude longitude]
    )
  end
end
