require 'logger'

class PrettyLogger

  # middleware to insert a PrettyLogger into rack.logger
  class Middleware
    def initialize(app, opts={})
      @app = app
      @logger = PrettyLogger.new opts
    end
    def call(env)
      env['rack.logger'] = @logger
      status, header, body = @app.call(env)
      [status, header, body]
    end
  end

  Config = {
    format_datetime: "%d/%b/%Y %H:%M:%S",
    level: Logger::DEBUG,
    stream: STDERR
  }

  Levels = {
    :fatal =>  4,
    :error =>  3,
    :warn  =>  2,
    :info  =>  1,
    :debug =>  0,
    :devel => -1,
  }

  attr_reader :logger

  def initialize(opts = {})
    opts = Config.merge(opts)
    @stream          = opts[:stream]
    @level           = opts[:level]
    @format_datetime = opts[:format_datetime]

    @logger = Logger.new(@stream)
    @logger.level = @level
    @logger.formatter = proc do |severity, datetime, progname, msg|
      level = stylized_level(severity)
      "#{datetime.strftime(@format_datetime).brown} #{level} #{msg}\n"
    end
  end

  def debug(msg) logger.debug(msg) end
  def info(msg)  logger.info(msg)  end
  def warn(msg)  logger.warn(msg)  end
  def error(msg) logger.error(msg) end
  def fatal(msg) logger.fatal(msg) end

  def stylized_level(level)
    str = '%5.5s' % level
    str = case Levels[level.downcase.to_sym]
      when Logger::DEBUG then str.cyan
      when Logger::INFO then str.green
      when Logger::WARN then str.brown
      when Logger::ERROR then str.red
      when Logger::FATAL then str.brown.bold.bg_red
      else str.gray
    end
  end

  def self.logger
    @_logger ||= self.new
  end
  def self.logger=(logger)
    @_logger = logger
  end

end

class String
  def black;          "\033[30m#{self}\033[0m" end
  def red;            "\033[31m#{self}\033[0m" end
  def green;          "\033[32m#{self}\033[0m" end
  def brown;          "\033[33m#{self}\033[0m" end
  def blue;           "\033[34m#{self}\033[0m" end
  def magenta;        "\033[35m#{self}\033[0m" end
  def cyan;           "\033[36m#{self}\033[0m" end
  def gray;           "\033[37m#{self}\033[0m" end
  def bg_black;       "\033[40m#{self}\033[0m" end
  def bg_red;         "\033[41m#{self}\033[0m" end
  def bg_green;       "\033[42m#{self}\033[0m" end
  def bg_brown;       "\033[43m#{self}\033[0m" end
  def bg_blue;        "\033[44m#{self}\033[0m" end
  def bg_magenta;     "\033[45m#{self}\033[0m" end
  def bg_cyan;        "\033[46m#{self}\033[0m" end
  def bg_gray;        "\033[47m#{self}\033[0m" end
  def bold;           "\033[1m#{self}\033[22m" end
  def reverse_color;  "\033[7m#{self}\033[27m" end
end
