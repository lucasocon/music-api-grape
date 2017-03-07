class EditUserValidation
  include Hanami::Validations::Form
  predicates FormPredicates

  validations do
    required(:first_name).maybe(:str?)
    required(:last_name).maybe(:str?)
    required(:email).maybe(:str?, :email?)
    optional(:born_on).maybe(:datetime_str?)
  end
end
