class Ingredient < ApplicationRecord
  INGREDIENT_TYPES = %i[sauce cutlet vegetables cheese supplements buns].freeze

  has_one  :picture, as: :imageable, dependent: :destroy
  has_many :components, dependent: :destroy

  accepts_nested_attributes_for :picture
end
