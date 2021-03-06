class LineItem < ApplicationRecord
  belongs_to :gift, optional: true
  belongs_to :cart, optional: true
  belongs_to :order, optional: true
  belongs_to :burger, optional: true
  belongs_to :product_type, optional: true

  default_scope { order(gift_id: :desc, per_bonuses: :asc, id: :desc) }

  def change_quantity(value)
    update(quantity: value) if value.positive?
    self
  end

  def per_bonuses?
    per_bonuses
  end

  def gift?
    gift_id.present?
  end

  def total_price
    product_type.price * quantity
  end
end
