class Order < ApplicationRecord
  has_many :line_items
  belongs_to :user

  def get_product(cart)
    cart.line_items.each do |product|
      product.cart_id = nil
      line_items.push(product)
    end
  end

  def serializer_clazz
    DeliveryApi::Entities::OrderResponce
  end
end
