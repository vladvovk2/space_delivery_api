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
    line_item = if product_type.product.per_bonuses?
                  line_items.find_by(product_type: product_type, per_bonuses: true)
                else
                  line_items.find_by(product_type: product_type)
                end

    if line_item
      if line_item.per_bonuses?
        return broadcast(:ok, 'Not enough bonuses.') unless enough_bonuses?

        line_item.update(quantity: line_item.quantity + 1) if bonuses_back
      else
        line_item.update(quantity: line_item.quantity + 1)
      end

      broadcast(:ok, "#{product_type.product.title} quantity increase to: #{line_item.quantity}.")
    else
      if product_type.product.per_bonuses?
        return broadcast(:ok, 'Not enough bonuses.') unless enough_bonuses?

        line_items.create(product_type: product_type, per_bonuses: true) if bonuses_back
      else
        line_items.create(product_type: product_type)
      end

      broadcast(:ok, "#{product_type.product.title} added to cart.")
    end
  end

  def bonuses_back
    user_balance.update(balance: user_balance.balance - @product_type.price)
  end

  def enough_bonuses?
    user_balance.balance >= product_type.price
  end
end
