module DeliveryApi
  module Entities
    class UserResponce < Grape::Entity
      expose :id,              documentation: { type: 'Integer',  values: ['1'] }
      expose :first_name,      documentation: { type: 'String',   values: ['Vlad'] }
      expose :last_name,       documentation: { type: 'String',   values: ['Vovk'] }
      expose :email,           documentation: { type: 'String',   values: ['vlad.vovk.844@gmail.com'] }
      expose :email_confirm,   documentation: { type: 'Boolean',  values: ['true'] }
      expose :phone_number,    documentation: { type: 'String',   values: ['+380687285102'] }
      expose :user_balance,    documentation: { type: 'Integer',  values: ['121'] }
      expose :user_promo_code, documentation: { type: 'String',   values: ['3F1ds3k1jc'] }

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
