class ApiHelpers
  module UserRoles
    ROLES = [
      :rep,
      :office_manager,
      :office_staff,
      :doctor,
      :system,
      :admin
    ].freeze

    GROUPS = [
      :office_user,
      :premium_rep,
      :limited_rep,
      :trial_rep
    ].freeze

    def role
      ROLES.each do |role|
        return role if _check_role(role)
      end
      raise 'Role not found'
    end

    def groups
      ar = []
      GROUPS.each do |group|
        ar << group if _check_group(group)
      end
      ar
    end

    def in_role?(*roles)
      roles.map!(&:to_sym).include? role
    end

    def in_group?(group)
      groups.include? group.to_sym
    end

    private

    def _check_role(role)
      case role.to_sym
      when :rep
        self.Type == 'REP'
      when :office_manager
        self.Type == 'OFFICE MANAGER'
      when :office_staff
        self.Type == 'NON-MANAGER'
      when :doctor
        self.Type == 'DOCTOR'
      when :system
        self.Type == 'SYSTEM'
      when :admin
        self.Type == 'ADMIN'
      else
        false
      end
    end

    def _check_group(group)
      case group.to_sym
      when :office_user
        in_role? :office_manager, :office_staff, :doctor
      when :premium_rep
        role == :rep && self.Membership_Type == 'Premium'
      when :trial_rep
        role == :rep && self.Membership_Type == 'Trial'
      when :limited_rep
        role == :rep && self.Membership_Type == 'Limited'
      else
        false
      end
    end
  end
end
