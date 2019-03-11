class ProductType < ApplicationRecord
  PRODUCT_TYPE = %i[default small medium large].freeze

  has_many :line_items, dependent: :destroy

  belongs_to :product, optional: true

  def product_record
    @product_record ||= product
  end
end
