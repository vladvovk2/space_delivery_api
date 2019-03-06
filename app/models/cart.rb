class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    item = line_items.find_by(product: product)
    if item
      item.quantity += 1
      item.save
    else
      line_items.build(product: product)
    end
  end

  def total_price
    line_items.map { |item| item.quantity * item.product.price }.sum
  end
end
