class CreateOrderWeb < Rectify::Command
  def initialize(order_params, promocode, user, cart)
    @order_params = order_params
    @promocode = PromoCode.find_by(code: promocode)
    @user = user
    @cart = cart
  end

  def call
    return broadcast(:empty_cart) if cart.line_items.empty?

    order
  end

  private

  attr_reader :order_params, :promocode, :user, :cart

  def order
    @order = Order.new(order_params.merge(total_price: total_price, user_id: user&.id, discount: discount))

    if @order.save
      @order.get_product(cart)
      cart.destroy
      promocode.update(used: true, order_id: @order.id) if promocode.present? && promocode.invite.nil?

      OrderMailer.issued_order(user, @order).deliver_later if user&.get_receipt
      ChargeBonusesJob.perform_later(user&.id, promocode&.id, @order.total_price)
      GetSalesStatisticsJob.perform_later(product_ids(@order).uniq)

      broadcast(:created, @order)
    else
      broadcast(:fail, @order)
    end
  end

  def total_price
    cart.total_price - discount
  end

  def discount
    Discount.call(promocode, cart) do
      on(:discount) { |disc| return disc }
    end
  end
end
