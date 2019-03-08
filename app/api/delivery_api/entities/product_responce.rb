module DeliveryApi
  module Entities
    class ProductResponce < Grape::Entity
      expose :id,           documentation: { type: 'Integer', values: ['1'] }
      expose :title,        documentation: { type: 'String',  values: ['Apple'] }
      expose :price,        documentation: { type: 'Integer', values: ['22'] }
      expose :weight,       documentation: { type: 'Integer', values: ['22'] }
      expose :large_image_url
      expose :medium_image_url
      expose :small_image_url

      with_options(expose_nil: false) do
        expose :description, documentation: { type: 'String',  values: ['So tasty.'] }
        expose :category_id, documentation: { type: 'Integer', values: ['2'] }
      end

      private

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
