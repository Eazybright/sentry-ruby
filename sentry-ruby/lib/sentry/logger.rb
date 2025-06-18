# frozen_string_literal: true

require "logger"
require "net/http"
require "json"

module Sentry
  class Logger < ::Logger
    LOG_PREFIX = "** [Sentry] "
    PROGNAME   = "sentry"

    def initialize(*)
      super
      @level = ::Logger::INFO 
      original_formatter = ::Logger::Formatter.new
      @default_formatter = proc do |severity, datetime, _progname, msg|
        msg = "#{LOG_PREFIX}#{msg}"
        original_formatter.call(severity, datetime, PROGNAME, msg)
      end
    end
  end

  # module STDLIBLog
  #   def add(severity, message = nil, progname = nil, &block)
  #     # if message.nil?
  #     #   if block_given?
  #     #     message = yield
  #     #     # category = progname
  #     #   else
  #     #     message = progname
  #     #   end
  #     # end
  #     message ||= progname
      
  #     puts "before msg: #{message}"

  #     if !message.nil? && message != Sentry::Logger::PROGNAME
  #       puts "severity: #{severity}"
  #       puts "message: #{message}"
  #       puts "progname: #{progname}"
  #       # puts "logging logs: #{message}:"

  #       case severity
  #       when 0
  #         Sentry.logger.debug(message)
  #       when 1
  #         Sentry.logger.info(message)
  #       when 2
  #         Sentry.logger.warn(message)
  #       when 3
  #         Sentry.logger.error(message)
  #       when 4
  #         Sentry.logger.fatal(message)
  #       end
  #     end
  #     # capture_stdlib_log(*args, &block) 
  #     # super
      
  #   end
  # end
end

# Logger.send(:prepend, Sentry::STDLIBLog)

# Ruby Logger support 
# intercepts any logger instance and send the log to Sentry too.
# severity: 
#   DEBUG - 0
#   INFO -  1
#   WARN - 2
#   ERROR -  3
#   FATAL - 4
# ::Logger.prepend(Module.new do
#   def add(severity, message = nil, progname = nil)
#     super

#     message ||= progname

#     puts "before msg: #{message}"
#     # if message.nil?
#     #   if block_given?
#     #     message = yield
#     #     # category = progname
#     #   else
#     #     message = progname
#     #   end
#     # end
#         # msg = message
#     # msg = block.call if msg.nil? && block

#     # puts "block: #{block.inspect}"

#     # # If still nil, use progname as fallback
#     # msg ||= progname

#     if !message.nil? && message != Sentry::Logger::PROGNAME
#       puts "severity: #{severity}"
#       puts "message: #{message}"
#       puts "progname: #{progname}"
#       # puts "logging logs: #{message}:"

#       case severity
#       when 0
#         Sentry.logger.debug(message)
#       when 1
#         Sentry.logger.info(message)
#       when 2
#         Sentry.logger.warn(message)
#       when 3
#         Sentry.logger.error(message)
#       when 4
#         Sentry.logger.fatal(message)
#       end
#     end
    
#     true
#   end
# end)
