module DeliveryApi
  module Helpers
    module BaseHelpers
      def declared_params
        @declared ||= declared(params, include_missing: false)
      end
    end
  end
end