class CreateOrder < Rectify::Command
  def initialize(user, cart, order_params)
    @user         = user
    @cart         = cart
    @order_params = order_params
    @promo = order_params[:promo_code]
  end

  def call
    return broadcast(:empty_cart) if cart.line_items.empty?
    return broadcast(:promo_invalid) unless promo_valid?

    order = user.orders.build(order_params.merge(total_price: order_total_price))
    if order.save
      order.get_product(cart)
      send_receipt(order)
      broadcast(:ok, order)
    else
      broadcast(:fail, order)
    end
  end

  private

  attr_reader :user, :cart, :order_params, :promo

  def send_receipt(order)
    OrderMailer.issued_order(user, order).deliver
  end

  def order_total_price
    cart.total_price.to_i - promo_amount
  end

  def promo_valid?
    !promo.nil? && PromoCode.where(code: promo).exists? && user.promo_code.code != promo && (user.orders.where(status: true).count <= 1)
  end

  def promo_amount
    PromoCode.find_by(code: promo).amount
  end
end
