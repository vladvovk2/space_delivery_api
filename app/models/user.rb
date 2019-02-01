class User < ApplicationRecord
  has_many :orders

  def serializer_clazz
    DeliveryApi::Entities::UserResponce
  end
end
