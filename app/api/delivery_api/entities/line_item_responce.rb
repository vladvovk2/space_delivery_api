module DeliveryApi
  module Entities
    class LineItemResponce < Grape::Entity
      expose :id, documentation: { type: 'Integer', values: ['2'] }
      expose :product_type_id,
             documentation: { type: 'String', values: ['Potato'] },
             as: :title
      expose :proportion
      expose :quantity,     documentation: { type: 'Integer', values: ['10'] }
      expose :price,        documentation: { type: 'Integer', values: ['10'] }
      expose :total_price,  documentation: { type: 'Integer', values: ['100'] }
      expose :image_url

      private

      def price
        product_type.price
      end

      def product_type_id
        product_type.product_record.title
      end

      def total_price
        price * object.quantity
      end

      def product_type
        object.product_type
      end

      def proportion
        product_type.proportion
      end

      def image_url
        product_type.product.picture&.image_name&.url
      end
    end
  end
end
