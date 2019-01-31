class Category < ApplicationRecord
  has_many :products

  def serializer_clazz
    DeliveryApi::Entities::CategoryResponce
  end
end
