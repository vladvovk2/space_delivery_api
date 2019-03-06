module DeliveryApi
  module Entities
    class OrderResponce < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.strftime('%B %d, %Y') }

      expose :first_name,     documentation: { type: 'String',  values: ['Vlad'] }
      expose :last_name,      documentation: { type: 'String',  values: ['Vovk'] }
      expose :delivery_type,  documentation: { type: 'String',  values: ['Take out'] }
      expose :pay_type,       documentation: { type: 'String',  values: ['Cash'] }
      expose :address,        documentation: { type: 'String',  values: ['Gogolya, 24'] }
      expose :user_number,    documentation: { type: 'String',  values: ['0687285102'] }
      expose :total_price,    documentation: { type: 'Integer', values: ['312'] }

      with_options(expose_nil: false) do
        expose :description, documentation: { type: 'String',  values: ['Сall me back when you drive up.'] }
        expose :promo_code,  documentation: { type: 'String',  values: ['82bc666c00'] }
      end

      with_options(format_with: :iso_timestamp) do
        expose :created_at, documentation: { type: 'String', values: ['January 10, 2019'] }
      end
    end
  end
end
