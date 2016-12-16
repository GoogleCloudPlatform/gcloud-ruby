# Copyright 2016 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


require "orderedhash"

module Google
  module Cloud
    module Logging
      ##
      # # Logger
      #
      # An API-compatible replacement for ruby's Logger that logs to the
      # Stackdriver Logging Service.
      #
      # @example
      #   require "google/cloud/logging"
      #
      #   logging = Google::Cloud::Logging.new
      #
      #   resource = logging.resource "gae_app",
      #                               module_id: "1",
      #                               version_id: "20150925t173233"
      #
      #   logger = logging.logger "my_app_log", resource, env: :production
      #   logger.info "Job started."
      #
      class Logger
        ##
        # A RequestInfo represents data about the request being handled by the
        # current thread. It is used to configure logs coming from that thread.
        #
        # The trace_id is a String that controls the trace ID sent with the log
        # entry. If it is nil, no trace ID is sent.
        #
        # The log_name is a String that controls the name of the Stackdriver
        # log to write to. If it is nil, the default log_name for this Logger
        # is used.
        RequestInfo = ::Struct.new :trace_id, :log_name

        ##
        # The Google Cloud writer object that calls to {#write_entries} are made
        # on. Either an AsyncWriter or Project object.
        attr_reader :writer

        ##
        # The Google Cloud log_name to write the log entry with.
        attr_reader :log_name
        alias_method :progname, :log_name

        ##
        # The Google Cloud resource to write the log entry with.
        attr_reader :resource

        ##
        # The Google Cloud labels to write the log entry with.
        attr_reader :labels

        ##
        # The logging severity threshold (e.g. `Logger::INFO`)
        attr_reader :level
        alias_method :sev_threshold, :level

        ##
        # This logger does not use a formatter, but it provides a default
        # Logger::Formatter for API compatibility with the standard Logger.
        attr_accessor :formatter

        ##
        # This logger does not use a formatter, but it implements this
        # attribute for API compatibility with the standard Logger.
        attr_accessor :datetime_format

        ##
        # This logger treats progname as an alias for log_name.
        def progname= name
          @log_name = name
        end

        ##
        # A OrderedHash of Thread IDs to Stackdriver request trace ID. The
        # Stackdriver trace ID is a shared request identifier across all
        # Stackdriver services.
        #
        # @deprecated Use request_info
        #
        def trace_ids
          @request_info.inject({}) { |r, (k, v)| r[k] = v.trace_id }
        end

        ##
        # Create a new Logger instance.
        #
        # @param [#write_entries] writer The object that will transmit log
        #   entries. Generally, to create a logger that blocks on transmitting
        #   log entries, pass the Project; otherwise, to create a logger that
        #   transmits log entries in the background, pass an AsyncWriter. You
        #   may also pass any other object that responds to #write_entries.
        # @param [String] log_name A log resource name to be associated with the
        #   written log entries.
        # @param [Google::Cloud::Logging::Resource] resource The monitored
        #   resource to be associated with written log entries.
        # @param [Hash] labels A set of user-defined data to be associated with
        #   written log entries.
        #
        # @return [Google::Cloud::Logging::Logger] a Logger object that can be
        #   used in place of a ruby standard library logger object.
        #
        # @example
        #   require "google/cloud/logging"
        #
        #   logging = Google::Cloud::Logging.new
        #
        #   writer = logging.async_writer max_queue_size: 1000
        #
        #   resource = logging.resource "gae_app", labels: {
        #                                 "module_id" => "1",
        #                                 "version_id" => "20150925t173233"
        #                               }
        #
        #   logger = Google::Cloud::Logging::Logger.new writer,
        #                                               "my_app_log",
        #                                               resource,
        #                                               env: :production
        #   logger.info "Job started."
        #
        def initialize writer, log_name, resource, labels = nil
          @writer = writer
          @log_name = log_name
          @resource = resource
          @labels = labels
          @level = 0 # DEBUG is the default behavior
          @request_info = OrderedHash.new
          @closed = false
          # Unused, but present for API compatibility
          @formatter = ::Logger::Formatter.new
          @datetime_format = ""
        end

        ##
        # Log a `DEBUG` entry.
        #
        # @param [String, Hash] message The log entry payload, represented as
        #   either a string, a hash (JSON), or a hash (protocol buffer).
        # @yield Evaluates to the message to log. This is not evaluated unless
        #   the logger's level is sufficient to log the message. This allows you
        #   to create potentially expensive logging messages that are only
        #   called when the logger is configured to show them.
        #
        def debug message = nil, &block
          if block_given?
            add 0, nil, message, &block
          else
            add 0, message, nil, &block
          end
        end

        ##
        # Log an `INFO` entry.
        #
        # @param [String, Hash] message The log entry payload, represented as
        #   either a string, a hash (JSON), or a hash (protocol buffer).
        # @yield Evaluates to the message to log. This is not evaluated unless
        #   the logger's level is sufficient to log the message. This allows you
        #   to create potentially expensive logging messages that are only
        #   called when the logger is configured to show them.
        #
        def info message = nil, &block
          if block_given?
            add 1, nil, message, &block
          else
            add 1, message, nil, &block
          end
        end

        ##
        # Log a `WARN` entry.
        #
        # @param [String, Hash] message The log entry payload, represented as
        #   either a string, a hash (JSON), or a hash (protocol buffer).
        # @yield Evaluates to the message to log. This is not evaluated unless
        #   the logger's level is sufficient to log the message. This allows you
        #   to create potentially expensive logging messages that are only
        #   called when the logger is configured to show them.
        #
        def warn message = nil, &block
          if block_given?
            add 2, nil, message, &block
          else
            add 2, message, nil, &block
          end
        end

        ##
        # Log an `ERROR` entry.
        #
        # @param [String, Hash] message The log entry payload, represented as
        #   either a string, a hash (JSON), or a hash (protocol buffer).
        # @yield Evaluates to the message to log. This is not evaluated unless
        #   the logger's level is sufficient to log the message. This allows you
        #   to create potentially expensive logging messages that are only
        #   called when the logger is configured to show them.
        #
        def error message = nil, &block
          if block_given?
            add 3, nil, message, &block
          else
            add 3, message, nil, &block
          end
        end

        ##
        # Log a `FATAL` entry.
        #
        # @param [String, Hash] message The log entry payload, represented as
        #   either a string, a hash (JSON), or a hash (protocol buffer).
        # @yield Evaluates to the message to log. This is not evaluated unless
        #   the logger's level is sufficient to log the message. This allows you
        #   to create potentially expensive logging messages that are only
        #   called when the logger is configured to show them.
        #
        def fatal message = nil, &block
          if block_given?
            add 4, nil, message, &block
          else
            add 4, message, nil, &block
          end
        end

        ##
        # Log an `UNKNOWN` entry. This will be printed no matter what the
        # logger's current severity level is.
        #
        # @param [String, Hash] message The log entry payload, represented as
        #   either a string, a hash (JSON), or a hash (protocol buffer).
        # @yield Evaluates to the message to log. This is not evaluated unless
        #   the logger's level is sufficient to log the message. This allows you
        #   to create potentially expensive logging messages that are only
        #   called when the logger is configured to show them.
        #
        def unknown message = nil, &block
          if block_given?
            add 5, nil, message, &block
          else
            add 5, message, nil, &block
          end
        end

        ##
        # Log a message if the given severity is high enough. This is the
        # generic logging method. Users will be more inclined to use {#debug},
        # {#info}, {#warn}, {#error}, and {#fatal}.
        #
        # @param [Integer, String, Symbol] severity the integer code for or the
        #   name of the severity level
        # @param [String, Hash] message The log entry payload, represented as
        #   either a string, a hash (JSON), or a hash (protocol buffer).
        # @yield Evaluates to the message to log. This is not evaluated unless
        #   the logger's level is sufficient to log the message. This allows you
        #   to create potentially expensive logging messages that are only
        #   called when the logger is configured to show them.
        #
        def add severity, message = nil, progname = nil
          severity = derive_severity(severity) || 5 # 5 is UNKNOWN/DEFAULT
          return true if severity < @level

          if message.nil?
            if block_given?
              message = yield
            else
              message = progname
              # progname = nil # TODO: Figure out what to do with the progname
            end
          end

          write_entry severity, message unless @closed
          true
        end
        alias_method :log, :add

        ##
        # Logs the given message at UNKNOWN severity.
        #
        # @param [String] msg The log entry payload as a string.
        #
        def << msg
          unknown msg
          self
        end

        ##
        # Returns `true` if the current severity level allows for sending
        # `DEBUG` messages.
        def debug?
          @level <= 0
        end

        ##
        # Returns `true` if the current severity level allows for sending `INFO`
        # messages.
        def info?
          @level <= 1
        end

        ##
        # Returns `true` if the current severity level allows for sending `WARN`
        # messages.
        def warn?
          @level <= 2
        end

        ##
        # Returns `true` if the current severity level allows for sending
        # `ERROR` messages.
        def error?
          @level <= 3
        end

        ##
        # Returns `true` if the current severity level allows for sending
        # `FATAL` messages.
        def fatal?
          @level <= 4
        end

        ##
        # Sets the logging severity level.
        #
        # @param [Integer, String, Symbol] severity the integer code for or the
        #   name of the severity level
        #
        # @example
        #   require "google/cloud/logging"
        #
        #   logging = Google::Cloud::Logging.new
        #
        #   resource = logging.resource "gae_app",
        #                               module_id: "1",
        #                               version_id: "20150925t173233"
        #
        #   logger = logging.logger "my_app_log", resource, env: :production
        #
        #   logger.level = "INFO"
        #   logger.debug "Job started." # No log entry written
        #
        def level= severity
          new_level = derive_severity severity
          fail ArgumentError, "invalid log level: #{severity}" if new_level.nil?
          @level = new_level
        end
        alias_method :sev_threshold=, :level=

        ##
        # Close the logging "device". This effectively disables logging from
        # this logger; any further log messages will be silently ignored. The
        # logger may be re-enabled by calling #reopen.
        #
        def close
          @closed = true
          self
        end

        ##
        # Re-enable logging if the logger has been closed.
        #
        # Note that this method accepts a "logdev" argument for compatibility
        # with the standard Ruby Logger class; however, this argument is
        # ignored because this logger does not use a log device.
        #
        def reopen _logdev = nil
          @closed = false
          self
        end

        ##
        # Track a given trace_id by associating it with the current
        # Thread
        #
        # @deprecated Use add_request_info
        #
        def add_trace_id trace_id
          add_request_id trace_id: trace_id
        end

        ##
        # Associate request data with the current Thread. You may provide
        # either the individual pieces of data (trace ID, log name) or a
        # populated RequestInfo object.
        #
        # @param [RequestInfo] info Info about the current request. Optional.
        #     If not present, a new RequestInfo is created using the remaining
        #     parameters.
        # @param [String, nil] trace_id The trace ID, or `nil` if no trace ID
        #     should be logged.
        # @param [String, nil] log_name The log name to use, or nil to use
        #     this logger's default.
        #
        def add_request_info info: nil,
                             trace_id: nil,
                             log_name: nil
          info ||= RequestInfo.new trace_id, log_name
          @request_info[current_thread_id] = info

          # Start removing old entries if hash gets too large.
          # This should never happen, because middleware should automatically
          # remove entries when a request is finished
          @request_info.shift while @request_info.size > 10_000

          info
        end

        ##
        # Get the request data for the current Thread
        #
        # @return [RequestInfo, nil] The request data for the current thread,
        #     or `nil` if there is no data set.
        #
        def request_info
          @request_info[current_thread_id]
        end

        ##
        # Untrack the RequestInfo that's associated with current Thread
        #
        # @return [RequestInfo] The info that's being deleted
        #
        def delete_request_info
          @request_info.delete current_thread_id
        end

        ##
        # @deprecated Use delete_request_info
        alias_method :delete_trace_id, :delete_request_info

        protected

        ##
        # @private Write a log entry to the Stackdriver Logging service.
        def write_entry severity, message
          entry = Entry.new.tap do |e|
            e.timestamp = Time.now
            e.severity = gcloud_severity(severity)
            e.payload = message
          end

          # merge input labels and request info
          merged_labels = {}
          actual_log_name = log_name
          info = request_info
          if info
            actual_log_name = info.log_name || actual_log_name
            merged_labels["traceId"] = info.trace_id unless info.trace_id.nil?
          end
          merged_labels = labels.merge(merged_labels) unless labels.nil?

          writer.write_entries entry, log_name: actual_log_name,
                                      resource: resource,
                                      labels: merged_labels
        end

        ##
        # @private Get the logger level number from severity value object.
        def derive_severity severity
          return severity if severity.is_a? Integer

          downcase_severity = severity.to_s.downcase
          case downcase_severity
          when "debug".freeze then 0
          when "info".freeze then 1
          when "warn".freeze then 2
          when "error".freeze then 3
          when "fatal".freeze then 4
          when "unknown".freeze then 5
          else nil
          end
        end

        ##
        # @private Get Google Cloud deverity from logger level number.
        def gcloud_severity severity_int
          %i(DEBUG INFO WARNING ERROR CRITICAL DEFAULT)[severity_int]
        rescue
          :DEFAULT
        end

        ##
        # @private Get current thread id
        def current_thread_id
          Thread.current.object_id
        end
      end
    end
  end
end
