class ProductSale < ApplicationRecord
  belongs_to :active_sales, class_name: 'Product'
  belongs_to :passive_sales, class_name: 'Product'

  validates :active_id, :passive_id, presence: true
end
