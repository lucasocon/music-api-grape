class Numeric
  # Utility function for numbers to easily format in US Monetary
  # Usage: my_var.monetize
  def monetize
    ('%.2f' % (self)).gsub(/(\d)(?=(\d{3})+(\.\d*)?$)/, '\1,')
  end
  def add_commas
    self.to_s.gsub(/(\d)(?=(\d{3})+(\.\d*)?$)/, '\1,')
  end
end

class String
  def format_phone(ext = false)
    self.gsub(/(\d{3})(\d{3})(\d{4})/, '(\1) \2-\3') + (ext.blank? ? '' : ' x' + ext)
  end

  def valid_email?
    (self =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end
end

class Date
  def standard_date
    self.strftime('%m/%d/%Y')
  end
end

class Time
  # Utility function to standardize date display for Time objects
  # Usage: vehicle.created_at.standard_date
  def standard_date
    self.strftime('%m/%d/%Y')
  end

  # Utility function to standardize date+time display for Time objects
  # Usage: vehicle.created_at.standard_datetime
  def standard_datetime style='default'
    case style
    # ISO 8601 date format for ECMA standard. Some browsers have difficulty
    # parsing various date format strings, so including a date parser method
    # in common.js which handles this format in particular (most modern browsers
    # can interpret this format)
    when 'ecma'
      self.strftime('%Y-%m-%dT%H:%M:%S%:z')
    when 'short'
      self.strftime('%m/%d/%Y %I:%M:%S %p %Z')
    # No seconds, eg: 27/04/2015 10:54am ART
    when 'compact'
      self.strftime('%m/%d/%Y %I:%M%P %Z')
    # Default is human readable format
    else
      self.strftime('%A, %B %d, %Y %I:%M %p %Z')
    end
  end
end
