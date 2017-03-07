require 'grape-swagger'
require 'grape-entity'
require 'grape-swagger-entity'

Grape::Batch.configure do |config|
  config.limit = 10
  config.path = '/api/batch'
  config.formatter = Grape::Batch::Response
  config.logger = Logger.new(STDOUT)
  config.session_proc = Proc.new { }
end
