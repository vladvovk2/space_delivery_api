module DeliveryApi
  module Entities
    class CategoryResponce < Grape::Entity
      expose :id,    documentation: { type: 'integer', values: ['1'] }
      expose :title, documentation: { type: 'string',  values: ['Pizza'] }
    end
  end
end
