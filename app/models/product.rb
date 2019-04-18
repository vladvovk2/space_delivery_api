class Product < ApplicationRecord
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  has_one  :picture, as: :imageable, dependent: :destroy

  has_many :product_types, dependent: :destroy
  has_many :active_product_sales, class_name: 'ProductSale',
                                  foreign_key: 'active_id',
                                  dependent: :destroy
  has_many :passive_product_sales, class_name: 'ProductSale',
                                   foreign_key: 'passive_id',
                                   dependent: :destroy

  has_many :active_sales, through: :passive_product_sales, source: :active
  has_many :passive_sales, through: :active_product_sales, source: :passive

  belongs_to :category, optional: true
  belongs_to :favorite, optional: true

  accepts_nested_attributes_for :product_types, allow_destroy: true
  accepts_nested_attributes_for :picture

  validates :product_types, :picture, presence: true
  validates :title,
            presence: true,
            length: { in: 2..30 },
            uniqueness: true
  validates :description,
            presence: true,
            length: { in: 10..250 }
end
