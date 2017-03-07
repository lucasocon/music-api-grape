class EditSongValidation
  include Hanami::Validations::Form

  validations do
    required(:name).maybe(:str?)
    required(:genre).maybe(:str?)
    required(:banner).maybe(:str?)
    required(:promotion).maybe(:str?)
    required(:duration).maybe(:int?)
    required(:featured).maybe(:bool?)
  end
end
