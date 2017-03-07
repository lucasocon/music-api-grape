class CreateUserValidation
  include Hanami::Validations::Form
  predicates FormPredicates

  validations do
    required(:first_name).filled(:str?)
    required(:last_name).filled(:str?)
    required(:email).filled(:str?, :email?)
    required(:password).filled.confirmation
    optional(:born_on).filled(:datetime_str?)
  end
end
