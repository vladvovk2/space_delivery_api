class ProductSale < ApplicationRecord
  belongs_to :active, class_name: 'Product'
  belongs_to :passive, class_name: 'Product'

  validates :active_id, :passive_id, presence: true
end
