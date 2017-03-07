# Replacement for reform
require 'hanami/validations'
require 'hanami/validations/form'

module FormPredicates
  include Hanami::Validations::Predicates

  self.messages_path = 'application/config/yaml/errors.yml'

  predicate(:phone?) do |current|
    current.to_s.match(/\A\d{10}\z/i)
  end

  predicate(:email?) do |current|
    current.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
  end

  predicate(:datetime_str?) do |current|
    # Format: YYYY-MM-DD HH:MM:SS TZ - ex: 2016-01-01 02:03:04 -0800
    # Timezone is optional
    current.match(/^\d{4}-\d{2}-\d{2} \d{1,2}\:\d{1,2}\:\d{1,2}( \-\d{4})?$/)
  end
end
