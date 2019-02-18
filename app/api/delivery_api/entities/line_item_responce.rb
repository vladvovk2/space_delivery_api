module DeliveryApi
  module Entities
    class LineItemResponce < Grape::Entity
      expose :id,           documentation: { type: 'Integer', values: ['2'] }
      expose :product_id,   documentation: { type: 'String',  values: ['Potato'] }, as: :title
      expose :quantity,     documentation: { type: 'Integer', values: ['10'] }
      expose :price,        documentation: { type: 'Integer', values: ['10'] }
      expose :total_price,  documentation: { type: 'Integer', values: ['100'] }

      private

      def price
        product.price
      end

      def product_id
        product.title
      end

      def total_price
        price * object.quantity
      end

      def product
        Product.find(object.product_id)
      end
    end
  end
end
