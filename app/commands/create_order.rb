class CreateOrder < Rectify::Command

  def initialize(user, cart, order_params)
    @user         = user
    @cart         = cart
    @order_params = order_params
  end

  def call
    return broadcast(:empty_cart) if cart.line_items.empty?

    order = user.orders.build(order_params.merge(total_price: cart.total_price))
    if order.save
      order.get_product(cart)
      send_receipt(order)
      broadcast(:ok, order)
    else
      broadcast(:fail, order)
    end
  end

  private

  attr_accessor :user, :cart, :order_params

  def send_receipt(order)
    OrderMailer.issued_order(user, order).deliver
  end
end
