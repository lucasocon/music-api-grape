# Default variables
APP_ROOT                = File.expand_path '../../', __FILE__ unless defined?(APP_ROOT)
RACK_ENV                = ENV.fetch('RACK_ENV') { 'development' }.freeze
LATEST_API_VERSION      = 1.0.freeze

# Load environment variables
%W{.env .env.#{RACK_ENV}}.each do |file|
  File.foreach file do |line|
    key, value = line.split '=', 2; ENV[key] = value.gsub('\n', '').strip
  end if File.file? file
end

ENV['SYSTEM_USER_ID']       ||= '1'
ENV['SUPPORT_PHONE_NUMBER'] ||= '(888) 999-9999'
ENV['SUPPORT_EMAIL']        ||= 'support@test.com'
ENV['INTERNAL_EMAIL']       ||= 'internal@test.com'

SYSTEM_USER_ID        = ENV.fetch('SYSTEM_USER_ID').to_i.freeze
SUPPORT_PHONE_NUMBER  = ENV.fetch('SUPPORT_PHONE_NUMBER').freeze
SUPPORT_EMAIL         = ENV.fetch('SUPPORT_EMAIL').freeze
INTERNAL_EMAIL        = ENV.fetch('INTERNAL_EMAIL').freeze
DATABASE_URL          = ENV.fetch('DATABASE_URL').freeze
SMTP_SERVER           = ENV.fetch('SMTP_SERVER').freeze
MAIL_SMTP_USER        = ENV.fetch('MAIL_SMTP_USER').freeze
MAIL_SMTP_PASSWORD    = ENV.fetch('MAIL_SMTP_PASSWORD').freeze
SYSTEM_EMAIL          = ENV.fetch('SYSTEM_EMAIL').freeze
SITE_URL              = ENV.fetch('SITE_URL').freeze
