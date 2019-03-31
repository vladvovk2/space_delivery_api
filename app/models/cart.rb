class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :product_types, through: :line_items
  belongs_to :user, optional: true

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
    line_items.map { |line_item| line_item.quantity * line_item.product_type.price }.sum
  end
end
