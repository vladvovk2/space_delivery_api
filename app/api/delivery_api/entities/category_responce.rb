module DeliveryApi
  module Entities
    class CategoryResponce < Grape::Entity
      expose :id,    documentation: { type: 'Integer', values: ['1'] }
      expose :title, documentation: { type: 'String',  values: ['Pizza'] }
    end
  end
end
