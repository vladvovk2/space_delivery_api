class Burger < ApplicationRecord
  has_many :components, dependent: :destroy
end
