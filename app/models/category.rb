class Category < ApplicationRecord
  has_many :products

  validates :title, presence: true,
                    length: { in: 2..20 },
                    uniqueness: true
  validates :image, presence: true

  def serializer_clazz
    DeliveryApi::Entities::CategoryResponce
  end
end
