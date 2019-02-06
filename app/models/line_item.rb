class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :product, optional: true
  belongs_to :order, optional: true

  def change_quantity(value)
    if value.first.nonzero?
      self.update(quantity: value)
    else
      
    end
  end

  def serializer_clazz
    DeliveryApi::Entities::LineItemResponce
  end
end
