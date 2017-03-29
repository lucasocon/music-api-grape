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
require 'redis'

# require all models
Dir['./application/models/*.rb'].each { |rb| require rb }
Dir['./application/validations/**/*.rb'].each { |rb| require rb }

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

  $redis = Redis.new(url: ENV['REDIS_URL'])

  helpers do
    def key
      "#{ENV['RACK_ENV']}-#{request.url.split(version).last}"
    end

    def from_cache
      return @from_cache if defined?(@from_cache)
      cache = $redis.get(key)
      @from_cache = cache && JSON.parse(cache)
    end

    def cached_response(entity, &block)
      return from_cache if from_cache

      data = yield
      $redis.set(key, (present data, with: entity).to_json) if data
    end

    def cache_update(entity, &block)
      object = yield
      purge_index_cache
      if request.delete?
        $redis.del(key)
      else
        add_cache(key, entity) { object }
      end
    end

    def cache_create(entity, &block)
      object = yield
      new_key = "#{key}#{object.id}"
      purge_index_cache
      add_cache(new_key, entity) { object }
    end

    def add_cache(key, entity, &block)
      object = yield
      response = present object, with: entity
      $redis.set(key, response.to_json)
      response
    end

    def purge_index_cache
      index_key = key.slice(/.\//)
      $redis.del(index_key)
    end

    def call_cache(entity, &block)
      case
      when request.delete?, request.put?
        cache_update(entity) { yield }
      when request.post?
        cache_create(entity) { yield }
      end
    end
  end

  add_swagger_documentation \
    mount_path: '/docs'

  Mail.defaults do
    delivery_method :smtp, {
      address:               SMTP_SERVER,
      port:                  465,
      user_name:             MAIL_SMTP_USER,
      password:              MAIL_SMTP_PASSWORD,
      authentication:        :login,
      ssl:                   true,
      tls:                   true,
      enable_starttls_auto:  true
    }
  end
end
