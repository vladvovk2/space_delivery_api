class Order < ApplicationRecord
  has_many :line_items
end
