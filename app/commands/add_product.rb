class AddProduct < Rectify::Command
  def initialize(product_type, cart, user)
    @product_type = product_type
    @line_items   = cart.line_items
    @user_balance = user.try(:user_balance)
  end

  def call
    some_result
  end

  private

  attr_reader :product_type
  attr_accessor :line_items, :user_balance

  def some_result
    check_bonus

    if line_item
      line_item.update(quantity: line_item.quantity + 1)
      broadcast(:ok, "#{product_type.product.title} quantity increase to: #{line_item.quantity}.")
    else
      line_items.create(product_type: product_type, per_bonuses: product_per_bonuses?)
      broadcast(:ok, "#{product_type.product.title} added to cart.")
    end
  end

  def check_bonus
    return unless product_per_bonuses?
    return broadcast(:ok, 'Not enough bonuses.') unless enough_bonuses?

    bonuses_back
  end

  def product_per_bonuses?
    product_type.product.per_bonuses?
  end

  def line_item
    line_items.find_by(product_type: product_type, per_bonuses: product_per_bonuses?)
  end

  def bonuses_back
    user_balance.update(balance: user_balance.balance - @product_type.price)
  end

  def enough_bonuses?
    user_balance.balance >= product_type.price
  end
end
