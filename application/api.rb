Encoding.default_external = 'UTF-8'

$LOAD_PATH.unshift(File.expand_path('./application'))

# Include critical gems
require 'config/variables'

if %w(development test).include?(RACK_ENV)
  require 'pry'
  require 'awesome_print'
end

require 'bundler'
Bundler.setup :default, RACK_ENV
require 'rack/indifferent'
require 'grape'
require 'grape/batch'
# Initialize the application so we can add all our components to it
class Api < Grape::API; end

# Include all config files
require 'config/sequel'
require 'config/hanami'
require 'config/grape'

# require some global libs
require 'lib/core_ext'
require 'lib/time_formats'
require 'lib/io'

# load active support helpers
require 'active_support'
require 'active_support/core_ext'
require 'mail'

# require all models
Dir['./application/models/*.rb'].each { |rb| require rb }
Dir['./application/validations/*.rb'].each { |rb| require rb }

Dir['./application/api_helpers/**/*.rb'].each { |rb| require rb }
class Api < Grape::API
  version 'v1.0', using: :path
  content_type :json, 'application/json'
  default_format :json
  prefix :api
  rescue_from Grape::Exceptions::ValidationErrors do |e|
    ret = { error_type: 'validation', errors: {} }
    e.each do |x, err|
      ret[:errors][x[0]] ||= []
      ret[:errors][x[0]] << err.message
    end
    error! ret, 400
  end

  helpers SharedParams
  helpers ApiResponse
  include Auth

  Dir['./application/api_entities/**/*.rb'].each { |rb| require rb }
  Dir['./application/api/**/*.rb'].each { |rb| require rb }

  add_swagger_documentation \
    mount_path: '/docs'

Mail.defaults do
  delivery_method :smtp, {
    address:               SMTP_SERVER,
    port:                  465,
    user_name:             MAIL_SMTP_USER ,
    password:              MAIL_SMTP_PASSWORD,
    authentication:        :login,
    ssl:                   true,
    tls:                   true,
    enable_starttls_auto:  true
  }
end
end
