class EditAlbumValidation
  include Hanami::Validations::Form

  validations do
    required(:name).maybe(:str?)
    required(:album_art).maybe(:str?)
  end
end
