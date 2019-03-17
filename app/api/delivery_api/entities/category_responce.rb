module DeliveryApi
  module Entities
    class CategoryResponce < Grape::Entity
      expose :id,    documentation: { type: 'Integer', values: ['1'] }
      expose :title, documentation: { type: 'String',  values: ['Pizza'] }
      expose :image_url

      private

      def image_url
        object.picture&.image_name&.url
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
