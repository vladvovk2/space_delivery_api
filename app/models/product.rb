class Product < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :favorite, optional: true
  has_many   :line_items, dependent: :destroy

  #has_one_attached :image, styles: { medium: "300x300" }
  #validates_uniqueness_of :image_file_name # this is a standard ActiveRecord validator

  #validates :title, presence: true,
  #                  length: { in: 2..30 },
  #                  uniqueness: true
  #validates :price, presence: true,
  #                  numericality: { only_integer: true, greater_than: 0 }
  #validates :description, presence: true,
  #                        length: { in: 10..250 }
 # validates :image, :weight, presence: true
end
