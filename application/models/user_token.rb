class Api
  module Models
    class UserToken < Sequel::Model(:user_tokens)
      many_to_one :user

      def before_create
        generate_access_token
        set_expiration
      end

      def expired?
        DateTime.now >= self.expires_at
      end

      private
      def generate_access_token
        self.access_token = SecureRandom.hex
      end

      def set_expiration
        self.expires_at = DateTime.now + 1.day
      end
    end
  end
end
