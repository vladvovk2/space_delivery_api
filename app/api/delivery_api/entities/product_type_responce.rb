module DeliveryApi
  module Entities
    class ProductTypeResponce < Grape::Entity
      expose :id,         documentation: { type: 'Integer', values: ['22'] }
      expose :price,      documentation: { type: 'Integer', values: ['22'] }
      expose :weight,     documentation: { type: 'Integer', values: ['22'] }
      expose :proportion, documentation: { type: 'String',  values: ['small'] }
    end
  end
end
