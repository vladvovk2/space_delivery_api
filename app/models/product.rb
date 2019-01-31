class Product < ApplicationRecord
  belongs_to :category
  has_many :line_items, dependent: :destroy

  def serializer_clazz
    DeliveryApi::Entities::ProductResponce
  end
end
