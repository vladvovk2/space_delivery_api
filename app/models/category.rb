class Category < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :products

  validates :title, presence: true,
                    length: { in: 2..30 },
                    uniqueness: true
  # validates :image, presence: true
end
