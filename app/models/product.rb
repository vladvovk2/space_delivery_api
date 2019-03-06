class Product < ApplicationRecord
  has_one    :image, as: :imageable
  has_many   :line_items, dependent: :destroy
  belongs_to :category, optional: true
  belongs_to :favorite, optional: true

  # validates :title, presence: true,
  #                   length: { in: 2..30 },
  #                   uniqueness: true
  # validates :price, presence: true,
  #                   numericality: { only_integer: true, greater_than: 0 }
  # validates :description, presence: true,
  #                        length: { in: 10..250 }
  # validates :weight, presence: true
end
