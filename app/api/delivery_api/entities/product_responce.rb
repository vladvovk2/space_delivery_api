module DeliveryApi
  module Entities
    module ProductResponce
      class List < Grape::Entity
        expose :id,    documentation: { type: 'Integer', values: ['1'] }
        expose :title, documentation: { type: 'String',  values: ['Apple'] }
        expose :price, documentation: { type: 'Integer', values: ['13'] }
        expose :category_id,
               expose_nil: false,
               documentation: { type: 'Integer', values: ['2'] }
        expose :medium_image_url

        private

        def price
          object.product_types.first.price
        end

        def medium_image_url
          object.picture&.image_name&.url(:medium)
        end
      end

      class Show < Grape::Entity
        expose :id, documentation: { type: 'Integer', values: ['1'] }
        expose :large_image_url
        expose :description,
               expose_nil: false,
               documentation: { type: 'String', values: ['So tasty.'] }
        expose :product_types, using: DeliveryApi::Entities::ProductTypeResponce

        private

        def product_types
          object.product_types
        end

        def large_image_url
          object.picture&.image_name&.url(:large)
        end
      end
    end
  end
end
