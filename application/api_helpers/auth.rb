class Api
  module Auth
    extend ActiveSupport::Concern

    included do |base|
      helpers HelperMethods
    end

    module HelperMethods
      def authenticate!
        error!('Unauthorized. Invalid or expired token.', 401) unless set_current_user
      end

      private
      def set_current_user
        token = Api::Models::UserToken.first(access_token: headers["Token"])
        if token && !token.expired?
          Api.class_variable_set(:@@current_user, Api::Models::User[token.user_id])
        else
          false
        end
      end
    end
  end
end
