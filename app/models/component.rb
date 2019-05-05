class Component < ApplicationRecord
  belongs_to :burger, optional: true
  belongs_to :ingredient, optional: true
end
