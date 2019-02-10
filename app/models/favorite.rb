class Favorite < ApplicationRecord
  belongs_to :user
  has_many :products

  def serializer_clazz
    DeliveryApi::Entities::FavoriteResponce
  end
end
