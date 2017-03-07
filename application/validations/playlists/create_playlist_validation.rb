class CreatePlaylistValidation
  include Hanami::Validations::Form

  validations do
    required(:name).filled(:str?)
  end
end
