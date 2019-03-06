class Category < ApplicationRecord
  has_one  :picture, as: :imageable
  has_many :products

  accepts_nested_attributes_for :picture

  validates :title, presence: true,
                    length: { in: 2..30 },
                    uniqueness: true
end
