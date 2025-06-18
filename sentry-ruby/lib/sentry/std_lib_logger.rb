# frozen_string_literal: true

module Sentry
	module StdLibLogger
		SEVERITY_MAP = {
		  0 => :debug,
		  1 => :info,
		  2 => :warn,
		  3 => :error,
		  4 => :fatal
		}.freeze

		def add(severity, message = nil, progname = nil, &block)

			return unless Sentry.initialized? && Sentry.get_current_hub
			config = Sentry.configuration
			# puts "send_stdlib_logs config: #{config.send_stdlib_logs}"
			# puts "enable_logs config: #{config.enable_logs}"


			return unless config.enable_logs && config.send_stdlib_logs

	      if message.nil? && progname != Sentry::Logger::PROGNAME
	        if block_given?
	          message = yield
	        else
	          message = progname
	        end
	      end

	      message = message.to_s.strip
	      
	      puts "before msg: #{message}"

	      if !message.nil? && message != Sentry::Logger::PROGNAME
	        # puts "severity: #{severity}"
	        # puts "message: #{message}"
	        # puts "progname: #{progname}"

	        if method = SEVERITY_MAP[severity]
			  Sentry.logger.send(method, message)
			end
	      end
	    end
	end
end

::Logger.send(:prepend, Sentry::StdLibLogger)