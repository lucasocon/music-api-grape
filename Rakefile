$:.unshift(File.expand_path("./application"))
current_task = Rake.application.top_level_tasks.first

ENV['RACK_ENV'] ||= current_task['spec'] ? 'test' : 'development'

require 'bundler'
require 'bundler/setup'

# Database tasks should not need the whole app
if current_task['db:']
  require 'sequel'
  require 'config/variables'
  require 'config/sequel'
  SEQUEL_DB = Api::SEQUEL_DB
# Testing does not need the app either as it will create its own app
elsif !current_task['spec']
  require 'api'
end

if current_task['spec']
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = Dir.glob('application/spec/**/*_spec.rb')
    t.ruby_opts = "-I#{File.expand_path("./application/spec")}"
  end
else
  Dir["./application/tasks/**/*.rake"].each  { |rb| import rb }
end
