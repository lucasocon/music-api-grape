class EditArtistValidation
  include Hanami::Validations::Form

  validations do
    required(:name).maybe(:str?)
    required(:bio).maybe(:str?)
  end
end
