class Product < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :favorite, optional: true
  has_many   :line_items, dependent: :destroy

  validates :title, presence: true,
                    length: { in: 2..30 },
                    uniqueness: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true,
                          length: { in: 10..250 }
 # validates :image, :weight, presence: true

  def serializer_clazz
    DeliveryApi::Entities::ProductResponce
  end
end
