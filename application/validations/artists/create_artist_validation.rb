class CreateArtistValidation
  include Hanami::Validations::Form

  validations do
    required(:name).filled(:str?)
    required(:bio).filled(:str?)
  end
end
