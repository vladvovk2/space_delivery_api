module DeliveryApi
  module Entities
    class CategoryResponce < Grape::Entity
      expose :id,    documentation: { type: 'Integer', values: ['1'] }
      expose :title, documentation: { type: 'String',  values: ['Pizza'] }
      expose :large_image_url
      expose :medium_image_url
      expose :small_image_url

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
