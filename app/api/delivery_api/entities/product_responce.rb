module DeliveryApi
  module Entities
    class ProductResponce < Grape::Entity
      expose :id,           documentation: { type: 'integer', values: ['1'] }
      expose :title,        documentation: { type: 'string',  values: ['Apple'] }
      expose :price,        documentation: { type: 'integer', values: ['22'] }

      with_options(expose_nil: false) do
        expose :description, documentation: { type: 'string',  values: ['So tasty.'] }
        expose :category_id, as: :category, documentation: { type: 'integer', values: ['2'] }
      end

      private

      def category_id
        Category.find(object.category_id).title
      end
    end
  end
end