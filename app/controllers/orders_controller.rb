class OrdersController < ApplicationController
  include ProductsHelper

  def new
    @order = Order.new
  end

  def create
    CreateOrder.call(order_params, params[:promo_code], current_user, current_cart) do
      on(:created) do
        redirect_to root_path
        ActionCable.server.broadcast :notifiations, message: 'Successfully. Wait for our call.'
      end
      on(:fail) do
        render :new
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
