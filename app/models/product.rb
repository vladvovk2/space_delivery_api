class Product < ApplicationRecord
  belongs_to :category

  def serializer_clazz
    DeliveryApi::Entities::ProductResponce
  end
end
