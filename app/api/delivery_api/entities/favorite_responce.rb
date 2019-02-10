module DeliveryApi
  module Entities
    class FavoriteResponce < Grape::Entity
      expose :id,         documentation: { type: 'Integer', values: ['1'] }
      expose :user_id,    documentation: { type: 'Integer', values: ['1'] }
      expose :product_id, documentation: { type: 'Integer', values: ['1'] }
    end
  end
end
