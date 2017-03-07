require 'sequel'

Sequel.database_timezone = :local

# basic plugins
Sequel::Model.plugin :schema
Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :nested_attributes
Sequel::Model.plugin :boolean_readers
Sequel::Model.plugin :table_select
Sequel::Model.plugin :dirty
Sequel::Model.plugin :string_stripper
# This breaks nested_attributes plugin if you're doing a create:
# Sequel::Model.plugin :auto_validations

# Force all strings to be UTF8 encoded in a all model subclasses
Sequel::Model.plugin :force_encoding, 'UTF-8'

Sequel::Model.plugin :input_transformer
Sequel::Model.add_input_transformer(:to_nil){|v| v.is_a?(String) && v == '' ? nil : v}

# Auto-manage created_at/updated_at fields
Sequel::Model.plugin :timestamps, update_on_create: true

Sequel.extension :connection_validator
Sequel.extension :migration
Sequel.extension :core_extensions
Sequel.extension :pagination

# custom validation methods
class Sequel::Model
  def before_create
    if columns.include?(:updater_id) && columns.include?(:creator_id)
      self.updater_id = creator_id
    end
    super
  end

  def validates_unchangeable(atts)
    atts = atts.kind_of?(Array) ? atts : [atts]
    atts.each do |col|
      col_sym = col.to_sym
      errors.add(col_sym, 'cannot be changed') if column_changed?(col_sym) && column_changes[col_sym][0].present?
    end
  end
end

module Sequel
  class Dataset
    %i`all first`.each do |meth|
      alias_method :"original_#{meth}", meth.to_sym
      define_method meth do |*args, &block|
        type = args.any?? args.pop : nil
        args << type if type && type != :nested

        if meth == :first && args.any?
          data = send("original_#{meth}", *args, &block)
        else
          data = send("original_#{meth}", &block)
        end

        if type == :nested
          data.is_a?(Array) ?
            data.map{ |x| _format_nested(x) } :
            _format_nested(data)
        else
          data
        end
      end
    end

    private

    def _format_nested data
      ret = {}
      data.each do |k, v|
        kparts = k.to_s.split '__'
        ref = ret
        last_key = kparts.pop
        kparts.each { |x| ref = (ref[x.to_sym] ||= {}) }
        ref[last_key.to_sym] = v
      end
      ret
    end

  end
end

class Api
  SEQUEL_DB = Sequel.connect(DATABASE_URL, connect_timeout: 5, read_timeout: 8, write_timeout: 5) unless defined? SEQUEL_DB

  if RACK_ENV == 'development' || ENV['DEBUG_SQL']
    require 'lib/pretty_logger'
    SEQUEL_DB.loggers << PrettyLogger.logger
  end
end
