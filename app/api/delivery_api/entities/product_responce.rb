module DeliveryApi
  module Entities
    class ProductResponce < Grape::Entity
      expose :id,           documentation: { type: 'Integer', values: ['1'] }
      expose :title,        documentation: { type: 'String',  values: ['Apple'] }
      expose :price,        documentation: { type: 'Integer', values: ['22'] }
      expose :weight,       documentation: { type: 'Integer', values: ['22'] }

      with_options(expose_nil: false) do
        expose :description, documentation: { type: 'String',  values: ['So tasty.'] }
        expose :category_id, documentation: { type: 'Integer', values: ['2'] }
      end
    end
  end
end
