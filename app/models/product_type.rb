class ProductType < ApplicationRecord
  PRODUCT_TYPE = %i[default small medium large].freeze

  belongs_to :product, optional: true
end
