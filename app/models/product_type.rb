class ProductType < ApplicationRecord
  PRODUCT_TYPE = %i[default small medium large].freeze
  has_many :carts, through: :line_items
  has_many :line_items, dependent: :destroy

  belongs_to :product, optional: true

  def product_record
    @product_record ||= product
  end

  validates :weight, presence: true
  validates :price,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
end
