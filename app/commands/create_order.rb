class CreateOrder < Rectify::Command
  def initialize(user, cart, order_params)
    @user         = user
    @cart         = cart
    @order_params = order_params
  end

  def call
    order = user.orders.build(order_params.merge(total_price: cart.total_price))
    if order.save
      order.get_product(cart)
      OrderMailer.issued_order(user).deliver_now
      broadcast(:ok, order)
    else
      broadcast(:fail, order)
    end
  end

  private

  attr_accessor :user, :cart, :order_params
end
