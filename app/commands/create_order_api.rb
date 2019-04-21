class CreateOrderApi < Rectify::Command
  def initialize(user, cart, order_params)
    @user         = user
    @cart         = cart
    @order_params = order_params
  end

  def call
    return broadcast(:empty_cart) if cart.line_items.empty?

    order
  end

  private

  attr_reader :user, :cart, :order_params

  def send_receipt(customer, order)
    OrderMailer.issued_order(customer, order).deliver_later
  end

  def order
    order = user.orders.build(order_params.merge(total_price: order_total_price))
    if order.save
      order.get_product(cart)
      send_receipt(user, order) if user&.get_receipt
      broadcast(:ok, order)
    else
      broadcast(:fail, order)
    end
  end

  def order_total_price
    cart.total_price - promo_code_amount
  end

  def promo_code_amount
    promo_code = PromoCode.find_by(code: order_params[:promo_code])
    promo_code.present? ? promo_code.amount : 0
  end
end
