class ResetPasswordUserValidation
  include Hanami::Validations::Form

  validations do
    required(:new_password).filled.confirmation
  end
end
