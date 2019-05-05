class Ingredient < ApplicationRecord
  has_many :components, dependent: :destroy
end
