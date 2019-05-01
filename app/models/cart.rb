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
    ln = line_items.map do |l|
      l.product_type.product.published && !l.gift? && !l.per_bonuses? ? (l.quantity * l.product_type.price) : 0
    end

    ln.sum
  end
end
