module DeliveryApi
  module Entities
    class LineItemResponce < Grape::Entity
      expose :id,           documentation: { type: 'integer', values: ['2'] }
      expose :product_id,   documentation: { type: 'string',  values: ['Potato'] }
      expose :quantity,     documentation: { type: 'integer', values: ['10'] }
      expose :price,        documentation: { type: 'integer', values: ['10'] }
      expose :total_price,  documentation: { type: 'integer', values: ['100'] }

      private

      def price
        product.price
      end

      def total_price
        price * object.quantity
      end

      def product_id
        product.title
      end

      def product
        Product.find(object.product_id)
      end
    end
  end
end
