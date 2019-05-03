class Blog < ApplicationRecord
  has_one  :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture

  validates :title, presence: true,
                    length: { in: 2..30 },
                    uniqueness: true
  validates :description,
            presence: true,
            length: { in: 10..1000 }
end
