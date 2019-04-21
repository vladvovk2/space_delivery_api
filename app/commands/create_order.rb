class CreateOrder < Rectify::Command
  def initialize(order_params, promocode, user, cart)
    @order_params = order_params
    @promocode = PromoCode.find_by(code: promocode)
    @user = user
    @cart = cart
  end

  def call
    order
  end

  private

  attr_reader :order_params, :promocode, :user, :cart

  def order
    @order = Order.new(order_params.merge(total_price: total_price, user_id: user&.id))

    if @order.save
      @order.get_product(cart)
      OrderMailer.issued_order(user, @order).deliver_later if user&.get_receipt
      GetSalesStatisticsJob.perform_later(product_ids(@order).uniq)
      broadcast(:created, @order)
    else
      broadcast(:fail, @order)
    end
  end

  def total_price
    if promocode.present?
      if promocode.percentage
        cart.total_price * (1 - promocode.amount.to_f / 100.to_f)
      else
        cart.total_price - promocode.amount
      end
    else
      cart.total_price
    end
  end
end
