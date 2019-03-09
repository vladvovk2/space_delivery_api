module DeliveryApi
  module Entities
    class ProductResponce < Grape::Entity
      expose :id,           documentation: { type: 'Integer', values: ['1'] }
      expose :title,        documentation: { type: 'String',  values: ['Apple'] }

      with_options(expose_nil: false) do
        expose :description, documentation: { type: 'String',  values: ['So tasty.'] }
        expose :category_id, documentation: { type: 'Integer', values: ['2'] }
      end

      expose :product_type, using: DeliveryApi::Entities::ProductTypeResponce

      expose :large_image_url
      expose :medium_image_url
      expose :small_image_url

      private

      def product_type
        object.product_types
      end

      def large_image_url
        object.picture&.image_name&.url(:large)
      end

      def medium_image_url
        object.picture&.image_name&.url(:medium)
      end

      def small_image_url
        object.picture&.image_name&.url(:small)
      end
    end
  end
end
