class Burger < ApplicationRecord
  has_many :components, dependent: :destroy

  def total_price
    components.map { |c| c.ingredient.price }.sum
  end
end
