class Product < ApplicationRecord


  def serializer_clazz
    DeliveryApi::Entities::ProductResponce
  end
end
