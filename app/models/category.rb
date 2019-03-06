class Category < ApplicationRecord
  has_one :image, as: :imageable
  has_many :products

  validates :title, presence: true,
                    length: { in: 2..30 },
                    uniqueness: true
end
