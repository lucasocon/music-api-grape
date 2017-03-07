class EditPlaylistValidation
  include Hanami::Validations::Form

  validations do
    required(:name).maybe(:str?)
  end
end
