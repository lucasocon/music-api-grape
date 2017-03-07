require 'ability_list'

class Api
  class Abilities < AbilityList
    def initialize(user)
      # call the appointment permissions
      user_permissions(user)
    end

    def user_permissions(user)
      # Only current user can edit themselves
      can :edit, Models::User do |check_user|
        next true if user.id == check_user.id
      end
    end
  end
end
