class CreateOrder
  prepend SimpleCommand

  def initialize(user, cart, order_params)
    @user         = user
    @cart         = cart
    @order_params = order_params
  end

  def call
    order if order
  end

  private

  attr_accessor :user, :cart, :order_params

  def order
    order = user.orders.build(order_params.merge(total_price: cart.total_price))
    if order.save
      order.get_product(cart)
    else
      errors.add 'Canʼt create order.'
    end
  end
end
