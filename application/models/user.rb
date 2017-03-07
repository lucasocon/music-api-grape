require 'lib/abilities'

class Api
  module Models
    class User < Sequel::Model(:users)
      include AbilityList::Helpers

      one_to_many :user_tokens

      def after_create
        update_token!
      end

      def abilities
        @abilities ||= Abilities.new(self)
      end

      def full_name
        "#{self.first_name} #{self.last_name}"
      end

      def token
        user_tokens.last.access_token
      end

      def update_token!
        user_tokens << UserToken.create(user_id: self.id)
      end

      def password_confirmation=(pass)
        nil
      end
    end
  end
end
