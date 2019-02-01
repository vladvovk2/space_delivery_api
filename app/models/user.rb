class User < ApplicationRecord
  has_many :orders

  def serializer_clazz
    DeliveryApi::Entities::UserResponce
  end
  
  has_secure_password
end
