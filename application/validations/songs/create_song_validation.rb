class CreateSongValidation
  include Hanami::Validations::Form

  validations do
    required(:name).filled(:str?)
    required(:genre).filled(:str?)
    required(:banner).filled(:str?)
    required(:promotion).filled(:str?)
    required(:duration).filled(:int?)
    required(:featured).filled(:bool?)
  end
end
