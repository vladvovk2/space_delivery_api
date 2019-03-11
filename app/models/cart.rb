class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    item = line_items.find_by(product_type: product)
    if item
      item.quantity += 1
      item.save
    else
      line_items.build(product_type: product)
    end
  end

  def total_price
    line_items.map { |item| item.quantity * item.product_type.price }.sum
  end
end
