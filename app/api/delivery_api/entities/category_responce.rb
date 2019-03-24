module DeliveryApi
  module Entities
    module CategoryResponce
      class List < Grape::Entity
        expose :id,    documentation: { type: 'Integer', values: ['1'] }
        expose :title, documentation: { type: 'String',  values: ['Pizza'] }
        expose :image_url
        expose :products, using: DeliveryApi::Entities::ProductResponce::List

        private

        def products
          object.products
        end

        def image_url
          object.picture&.image_name&.url
        end
      end
    end
  end
end
