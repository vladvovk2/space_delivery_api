class CreateOrder < Rectify::Command
  def initialize(user, cart, order_params)
    @user         = user
    @cart         = cart
    @order_params = order_params
    @promo_code   = order_params[:promo_code]
  end

  def call
    return broadcast(:empty_cart) if cart.line_items.empty?
    return broadcast(:promo_invalid) unless promo_code_valid?

    order
  end

  private

  attr_reader :user, :cart, :order_params, :promo_code

  def send_receipt(customer, order)
    OrderMailer.issued_order(customer, order).deliver
  end

  def order
    order = user.orders.build(order_params.merge(total_price: order_total_price))
    if order.save
      order.get_product(cart)
      send_receipt(user, order)
      broadcast(:ok, order)
    else
      broadcast(:fail, order)
    end
  end

  def order_total_price
    return cart.total_price - promo_code_amount unless promo_code.nil?

    cart.total_price
  end

  def promo_code_valid?
    if promo_code.nil?
      true
    elsif
      obj = PromoCode.where(code: promo_code)
      obj.exists? && obj.first.user_id != user.id
    else
      false
    end
  end

  def promo_code_amount
    PromoCode.find_by(code: promo_code).amount
  end
end
