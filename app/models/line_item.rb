class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :product, optional: true
  belongs_to :order, optional: true

  def change_quantity(value)
    update(quantity: value) if value.positive?
    self
  end
end
