class Discount < Rectify::Command
  def initialize(promocode, cart)
    @cart      = cart
    @promocode = promocode
  end

  def call
    broadcast(:discount, promocode_discount.to_i)
  end

  private

  attr_reader :cart, :promocode

  def promocode_discount
    if promocode.present?
      if promocode.percentage
        total_price * (promocode.amount.to_f / 100.to_f)
      else
        promocode.amount
      end
    else
      0
    end
  end

  def total_price
    if promocode.category.present?
      promocode_for_category
    else
      cart.total_price
    end
  end

  def promocode_for_category
    cart.line_items.map { |ln| ln.product_type.product.category_id.eql?(promocode.category_id) ? ln.total_price : 0 }.sum
  end
end
