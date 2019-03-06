module DeliveryApi
  module Helpers
    module BaseHelpers
      def declared_params
        @declared_params ||= declared(params, include_missing: false)
      end

      def formatted_error!(code, status, message)
        message = { code: code, message: message }
        error!(message, status)
      end
    end
  end
end
