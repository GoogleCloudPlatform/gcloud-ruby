# Copyright 2016 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


require "google-cloud-logging"
require "google/cloud/logging/project"
require "google/cloud/config"
require "google/cloud/env"
require "stackdriver/core"

module Google
  module Cloud
    ##
    # # Stackdriver Logging
    #
    # The Stackdriver Logging service collects and stores logs from applications
    # and services on the Google Cloud Platform, giving you fine-grained,
    # programmatic control over your projects' logs. You can use the Stackdriver
    # Logging API to:
    #
    # * Read and filter log entries
    # * Export your log entries to Cloud Storage, BigQuery, or Cloud Pub/Sub
    # * Create logs-based metrics for use in Cloud Monitoring
    # * Write log entries
    #
    # For general information about Stackdriver Logging, read [Stackdriver
    # Logging Documentation](https://cloud.google.com/logging/docs/).
    #
    # See {file:OVERVIEW.md Stackdriver Logging Overview}.
    #
    module Logging
      ##
      # Creates a new object for connecting to the Stackdriver Logging service.
      # Each call creates a new connection.
      #
      # For more information on connecting to Google Cloud see the
      # {file:AUTHENTICATION.md Authentication Guide}.
      #
      # @param [String] project_id Project identifier for the Stackdriver
      #   Logging service you are connecting to. If not present, the default
      #   project for the credentials is used.
      # @param [String, Hash, Google::Auth::Credentials] credentials The path to
      #   the keyfile as a String, the contents of the keyfile as a Hash, or a
      #   Google::Auth::Credentials object. (See {Logging::Credentials})
      # @param [String, Array<String>] scope The OAuth 2.0 scopes controlling
      #   the set of resources and operations that the connection can access.
      #   See [Using OAuth 2.0 to Access Google
      #   APIs](https://developers.google.com/identity/protocols/OAuth2).
      #
      #   The default scope is:
      #
      #   * `https://www.googleapis.com/auth/logging.admin`
      #
      # @param [Integer] timeout Default timeout to use in requests. Optional.
      # @param [Hash] client_config A hash of values to override the default
      #   behavior of the API client. Optional.
      # @param [String] project Alias for the `project_id` argument. Deprecated.
      # @param [String] keyfile Alias for the `credentials` argument.
      #   Deprecated.
      #
      # @return [Google::Cloud::Logging::Project]
      #
      # @example
      #   require "google/cloud/logging"
      #
      #   logging = Google::Cloud::Logging.new
      #
      #   entries = logging.entries
      #   entries.each do |e|
      #     puts "[#{e.timestamp}] #{e.log_name} #{e.payload.inspect}"
      #   end
      #
      def self.new project_id: nil, credentials: nil, scope: nil, timeout: nil,
                   client_config: nil, project: nil, keyfile: nil
        project_id ||= (project || default_project_id)
        project_id = project_id.to_s # Always cast to a string
        raise ArgumentError, "project_id is missing" if project_id.empty?

        scope ||= configure.scope
        timeout ||= configure.timeout
        client_config ||= configure.client_config

        credentials ||= (keyfile || default_credentials(scope: scope))
        unless credentials.is_a? Google::Auth::Credentials
          credentials = Logging::Credentials.new credentials, scope: scope
        end

        Logging::Project.new(
          Logging::Service.new(
            project_id, credentials, timeout: timeout,
                                     client_config: client_config
          )
        )
      end

      ##
      # Configure the Google::Cloud::Logging::Middleware when used in a
      # Rack-based application.
      #
      # The following Stackdriver Logging configuration parameters are
      # supported:
      #
      # * `project_id` - (String) Project identifier for the Stackdriver
      #   Logging service you are connecting to. (The parameter `project` is
      #   considered deprecated, but may also be used.)
      # * `credentials` - (String, Hash, Google::Auth::Credentials) The path to
      #   the keyfile as a String, the contents of the keyfile as a Hash, or a
      #   Google::Auth::Credentials object. (See {Logging::Credentials}) (The
      #   parameter `keyfile` is considered deprecated, but may also be used.)
      # * `scope` - (String, Array<String>) The OAuth 2.0 scopes controlling
      #   the set of resources and operations that the connection can access.
      # * `timeout` - (Integer) Default timeout to use in requests.
      # * `client_config` - (Hash) A hash of values to override the default
      #   behavior of the API client.
      # * `log_name` - (String) Name of the application log file. Default:
      #   `"ruby_app_log"`
      # * `log_name_map` - (Hash) Map specific request routes to other log.
      #   Default: `{ "/_ah/health" => "ruby_health_check_log" }`
      # * `monitored_resource.type` (String) Resource type name. See [full
      #   list](https://cloud.google.com/logging/docs/api/v2/resource-list).
      #   Self discovered on GCP.
      # * `monitored_resource.labels` -(Hash) Resource labels. See [full
      #   list](https://cloud.google.com/logging/docs/api/v2/resource-list).
      #   Self discovered on GCP.
      # * `labels` - (Hash) User defined labels. A `Hash` of label names to
      #   string label values or callables/`Proc` which are functions of the
      #   Rack environment.
      #
      # See the [Configuration
      # Guide](https://googleapis.github.io/google-cloud-ruby/docs/stackdriver/latest/file.INSTRUMENTATION_CONFIGURATION)
      # for full configuration parameters.
      #
      # @return [Google::Cloud::Config] The configuration object
      #   the Google::Cloud::Logging module uses.
      #
      def self.configure
        yield Google::Cloud.configure.logging if block_given?

        Google::Cloud.configure.logging
      end

      ##
      # @private Default project.
      def self.default_project_id
        Google::Cloud.configure.logging.project_id ||
          Google::Cloud.configure.project_id ||
          Google::Cloud.env.project_id
      end

      ##
      # @private Default credentials.
      def self.default_credentials scope: nil
        Google::Cloud.configure.logging.credentials ||
          Google::Cloud.configure.credentials ||
          Logging::Credentials.default(scope: scope)
      end
    end
  end
end
