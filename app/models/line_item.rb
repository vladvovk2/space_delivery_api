class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :order, optional: true
  belongs_to :product_type, optional: true

  default_scope { order(:created_at) }

  def change_quantity(value)
    update(quantity: value) if value.positive?
    self
  end

  def total_price
    product_type.price * quantity
  end
end
