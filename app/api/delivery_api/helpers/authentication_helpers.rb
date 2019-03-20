module DeliveryApi
  module Helpers
    module AuthenticationHelpers
      attr_reader :current_user

      def unauthorized!
        formatted_error!('NOT_AUTHORIZED', 401, 'Invalid email or password')
      end

      def authenticate!
        @current_user = User.find(decoded_token!.try(:dig, :user_id))
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        unauthorized!
      end

      def decoded_token!
        JWT.decode(
          headers['Authorization'],
          Rails.application.secrets.secret_key_base,
          true,
          algorithm: 'HS256'
        )&.first&.with_indifferent_access
      end
    end
  end
end
