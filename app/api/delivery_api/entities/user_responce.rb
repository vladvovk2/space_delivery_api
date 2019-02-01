module DeliveryApi
  module Entities
    class UserResponce < Grape::Entity
      expose :id,         documentation: { type: 'String',  values: ['1'] }
      expose :user_name,  documentation: { type: 'String',  values: ['vladvovk2'] }
      expose :email,      documentation: { type: 'String',  values: ['vlad.vovk.844@gmail.com'] }
    end
  end
end