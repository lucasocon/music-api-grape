class CreateAlbumValidation
  include Hanami::Validations::Form

  validations do
    required(:name).filled(:str?)
    required(:album_art).filled(:str?)
  end
end
