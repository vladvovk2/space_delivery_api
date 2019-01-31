module DeliveryApi
  module Entities
    class ProductResponce < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.strftime("%B %d, %Y") }

      expose :id,           documentation: { type: 'integer', values: ['1'] }
      expose :category_id,  documentation: { type: 'integer', values: ['2'] }
      expose :title,        documentation: { type: 'string',  values: ['Apple'] }
      expose :price,        documentation: { type: 'integer', values: ['22'] }
      expose :description,  documentation: { type: 'string',  values: ['About something...'] }

      with_options(format_with: :iso_timestamp) do
        expose :created_at, documentation: { type: 'string', values: ['January 10, 2019'] }
        expose :updated_at, documentation: { type: 'string', values: ['January 10, 2019'] }
      end
    end
  end
end