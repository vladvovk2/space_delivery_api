class Product < ApplicationRecord
  has_one    :picture, as: :imageable, dependent: :destroy

  has_many   :line_items,    dependent: :destroy
  has_many   :product_types, dependent: :destroy

  belongs_to :category, optional: true
  belongs_to :favorite, optional: true

  accepts_nested_attributes_for :product_types
  accepts_nested_attributes_for :picture

  validates :title,
            presence: true,
            length: { in: 2..30 },
            uniqueness: true
  validates :description,
            presence: true,
            length: { in: 10..250 }
end
