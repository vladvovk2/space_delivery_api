class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :product, optional: true
  belongs_to :order, optional: true

  def increase_quantity
    self.quantity += 1
    self.save
  end

  def reduce_quantity
    if self.quantity.positive? && self.quantity.nonzero?
      self.quantity -= 1
      self.save
    end
  end

  def serializer_clazz
    DeliveryApi::Entities::LineItemResponce
  end
end
