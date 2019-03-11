class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :order, optional: true
  belongs_to :product_type, optional: true

  def change_quantity(value)
    update(quantity: value) if value.positive?
    self
  end

  def product_record
    @product_record ||= product
  end
end
