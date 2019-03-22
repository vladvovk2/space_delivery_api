module DeliveryApi
  module Entities
    module ProductResponce
      class List < Grape::Entity
        expose :id,    documentation: { type: 'Integer', values: ['1'] }
        expose :title, documentation: { type: 'String',  values: ['Apple'] }
        expose :price, documentation: { type: 'Integer', values: ['13'] }
        expose :weight, documentation: { type: 'Integer', values: ['13'] }
        expose :description
        expose :image_url

        private

        def price
          object.product_types.first.price
        end

        def weight
          object.product_types.first.weight
        end

        def image_url
          object.picture&.image_name&.url
        end
      end

      class Show < Grape::Entity
        expose :id, documentation: { type: 'Integer', values: ['1'] }
        expose :image_url
        expose :description,
               expose_nil: false,
               documentation: { type: 'String', values: ['So tasty.'] }
        expose :product_types, using: DeliveryApi::Entities::ProductTypeResponce

        private

        def product_types
          object.product_types
        end

        def image_url
          object.picture&.image_name&.url
        end
      end
    end
  end
end
