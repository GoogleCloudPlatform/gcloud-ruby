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


require "stackdriver/core"

module Google
  module Cloud
    module Logging
      class Middleware
        ##
        # A default value for the log_name_map argument. Directs health check
        # logs to a separate log name so they don't spam the main log.
        DEFAULT_LOG_NAME_MAP = { "/_ah/health" => "ruby_health_check_log" }

        ##
        # The Google::Cloud::Logging::Logger instance
        attr_reader :logger

        ##
        # Create a new AppEngine logging Middleware.
        #
        # @param [Rack Application] app Rack application
        # @param [Google::Cloud::Logging::Logger] logger A logger to be used by
        #   this middleware. The middleware will be interacting with the logger
        #   to track Stackdriver request trace ID. It also properly sets
        #   env["rack.logger"] to this assigned logger for accessing.
        # @param [Hash] log_name_map A map from URI path to log name override.
        #   The path may be a string or regex. If a request path matches an
        #   entry in this map, the log name is set accordingly, otherwise the
        #   logger's default log_name is used.
        #
        # @return [Google::Cloud::Logging::Middleware] A new
        #   Google::Cloud::Logging::Middleware instance
        #
        def initialize app, logger: nil, log_name_map: DEFAULT_LOG_NAME_MAP
          @app = app
          @logger = logger
          @log_name_map = log_name_map
        end

        ##
        # Rack middleware entry point. In most Rack based frameworks, a request
        # is served by one thread. So entry point, we associate the GCP request
        # trace_id with the current thread's object_id in logger. All the logs
        # written by logger beyond this point will carry this request's
        # trace_id. Untrack the trace_id with this thread upon exiting.
        #
        # @param [Hash] env Rack environment hash
        #
        # @return [Rack::Response] The response from downstream Rack app
        #
        def call env
          env["rack.logger"] = logger
          request_info = get_request_info env
          logger.add_request_info request_info
          begin
            @app.call env
          ensure
            logger.delete_request_info
          end
        end

        ##
        # Extract data about this request as a RequestInfo.
        #
        # @param [Hash] env The Rack environment.
        # @return [RequestInfo] The info.
        def get_request_info env
          trace_context = Stackdriver::Core::TraceContext.parse_rack_env env
          trace_id = trace_context.trace_id
          log_name = get_log_name env
          Google::Cloud::Logging::Logger::RequestInfo.new trace_id, log_name
        end

        ##
        # Determine the log name override for this request, if any.
        #
        # @param [Hash] env The Rack environment.
        # @return [String, nil] The log name override or nil if there is
        #     no override.
        def get_log_name env
          return nil unless @log_name_map
          path = "#{env['SCRIPT_NAME']}#{env['PATH_INFO']}"
          path = "/#{path}" unless path.start_with? "/"
          @log_name_map.each do |k, v|
            return v if k === path
          end
          nil
        end

        ##
        # Construct a monitored resource based on the given type and label if
        # both are provided. Otherwise, construct a default monitored resource
        # based on the current environment.
        #
        # @example If both type and labels are provided, it returns resource:
        #   rc = Google::Cloud::Logging::Middleware.build_monitored_resource(
        #          "aws_ec2_instance",
        #          {
        #            instance_id: "ec2-id",
        #            aws_account: "aws-id"
        #          }
        #        )
        #   rc.type   #=> "aws_ec2_instance"
        #   rc.labels #=> { instance_id: "ec2-id", aws_account: "aws-id" }
        #
        # @example If running from GAE, returns default resource:
        #   rc = Google::Cloud::Logging::Middleware.build_monitored_resource
        #   rc.type   #=> "gae_app"
        #   rc.labels # { module_id: [GAE module name],
        #             #   version_id: [GAE module version] }
        #
        # @example If running from GKE, returns default resource:
        #   rc = Google::Cloud::Logging::Middleware.build_monitored_resource
        #   rc.type   #=> "container"
        #   rc.labels # { cluster_name: [GKE cluster name],
        #             #   namespace_id: [GKE namespace_id] }
        #
        # @example If running from GCE, return default resource:
        #   rc = Google::Cloud::Logging::Middleware.build_monitored_resource
        #   rc.type   #=> "gce_instance"
        #   rc.labels # { instance_id: [GCE VM instance id],
        #             #   zone: [GCE vm group zone] }
        #
        # @example Otherwise default to generic "global" type:
        #   rc = Google::Cloud::Logging::Middleware.build_monitored_resource
        #   rc.type   #=> "global"
        #   rc.labels #=> {}
        #
        # Reference https://cloud.google.com/logging/docs/api/ref_v2beta1/rest/v2beta1/MonitoredResource
        # for a full list of monitoring resources
        #
        # @param [String] type Type of Google::Cloud::Logging::Resource
        # @param [Hash<String, String>] labels Metadata lebels of
        #   Google::Cloud::Logging::Resource
        #
        # @return [Google::Cloud::Logging::Resource] An Resource object with
        #   type and labels
        def self.build_monitored_resource type = nil, labels = nil
          if type && labels
            Google::Cloud::Logging::Resource.new.tap do |r|
              r.type = type
              r.labels = labels
            end
          else
            default_monitored_resource
          end
        end

        ##
        # @private Extract information from current environment and construct
        # the correct monitoring resource types and labels.
        #
        # @example If running from GAE, returns default resource:
        #   rc = Google::Cloud::Logging::Middleware.send \
        #          :default_monitored_resource
        #   rc.type   #=> "gae_app"
        #   rc.labels # { module_id: [GAE module name],
        #             #   version_id: [GAE module version] }
        #
        # @example If running from GKE, returns default resource:
        #   rc = Google::Cloud::Logging::Middleware.send \
        #          :default_monitored_resource
        #   rc.type   #=> "container"
        #   rc.labels # { cluster_name: [GKE cluster name],
        #             #   namespace_id: [GKE namespace_id] }
        #
        # @example If running from GCE, return default resource:
        #   rc = Google::Cloud::Logging::Middleware.send \
        #          :default_monitored_resource
        #   rc.type   #=> "gce_instance"
        #   rc.labels # { instance_id: [GCE VM instance id],
        #             #   zone: [GCE vm group zone] }
        #
        # @example Otherwise default to generic "global" type:
        #   rc = Google::Cloud::Logging::Middleware.send \
        #          :default_monitored_resource
        #   rc.type   #=> "global"
        #   rc.labels #=> {}
        #
        # Reference https://cloud.google.com/logging/docs/api/ref_v2beta1/rest/v2beta1/MonitoredResource
        # for a full list of monitoring resources
        #
        # @return [Google::Cloud::Logging::Resource] An Resource object with
        #   correct type and labels
        def self.default_monitored_resource
          type, labels =
            if Core::Environment.gae?
              ["gae_app", {
                module_id: Core::Environment.gae_module_id,
                version_id: Core::Environment.gae_module_version }]
            elsif Core::Environment.gke?
              ["container", {
                cluster_name: Core::Environment.gke_cluster_name,
                namespace_id: Core::Environment.gke_namespace_id || "default" }]
            elsif Core::Environment.gce?
              ["gce_instance", {
                instance_id: Core::Environment.instance_id,
                zone: Core::Environment.instance_zone }]
            else
              ["global", {}]
            end

          Google::Cloud::Logging::Resource.new.tap do |r|
            r.type = type
            r.labels = labels
          end
        end

        private_class_method :default_monitored_resource
      end
    end
  end
end
