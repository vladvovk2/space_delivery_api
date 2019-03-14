module DeliveryApi
  module Entities
    class CategoryResponce < Grape::Entity
      expose :id,    documentation: { type: 'Integer', values: ['1'] }
      expose :title, documentation: { type: 'String',  values: ['Pizza'] }
      expose :medium_image_url

      private

      def medium_image_url
        object.picture&.image_name&.url(:medium)
      end
      class CategoryList < CategoryResponce
        expose :products, using: DeliveryApi::Entities::ProductResponce::List

        private

        def products
          object.products
        end
      end
    end
  end
end
