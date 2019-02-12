class Product < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :favorite, optional: true
  has_many   :line_items, dependent: :destroy

  def serializer_clazz
    DeliveryApi::Entities::ProductResponce
  end
end
