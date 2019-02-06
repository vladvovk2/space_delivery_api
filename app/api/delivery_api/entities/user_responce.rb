module DeliveryApi
  module Entities
    class UserResponce < Grape::Entity
      expose :id,         documentation: { type: 'String',  values: ['1'] }
      expose :user_name,  documentation: { type: 'String',  values: ['vladvovk2'] }
      expose :email,      documentation: { type: 'String',  values: ['vlad.vovk.844@gmail.com'] }
      expose :number,     documentation: { type: 'String',  values: ['0687285102'] }
      expose :user_balance
      expose :user_promo_code

      private

      def user_balance
        object.user_balance.balance
      end

      def user_promo_code
        object.promo_code.code  
      end
    end
  end
end