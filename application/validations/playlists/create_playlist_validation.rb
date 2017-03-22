class CreatePlaylistValidation
  include Hanami::Validations::Form

  validations do
    required(:name).filled(:str?)
    required(:user_id).filled(:int?)
  end
end
