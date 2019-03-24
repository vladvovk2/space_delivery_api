module DeliveryApi
  module Entities
    module ProductResponce
      class List < Grape::Entity
        expose :id,           documentation: { type: 'Integer', values: ['1'] }
        expose :category_id,  documentation: { type: 'Integer', values: ['1'] }
        expose :title
        expose :description,
               expose_nil: false,
               documentation: { type: 'String', values: ['So tasty.'] }
        expose :image_url
        expose :product_types, using: DeliveryApi::Entities::ProductTypeResponce

        private

        def product_types
          object.product_types
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

        def image_url
          object.picture&.image_name&.url
        end
      end
    end
  end
end
