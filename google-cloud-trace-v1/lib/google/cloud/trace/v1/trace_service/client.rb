# frozen_string_literal: true

# Copyright 2021 Google LLC
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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

require "google/cloud/errors"
require "google/devtools/cloudtrace/v1/trace_pb"

module Google
  module Cloud
    module Trace
      module V1
        module TraceService
          ##
          # Client for the TraceService service.
          #
          # This file describes an API for collecting and viewing traces and spans
          # within a trace.  A Trace is a collection of spans corresponding to a single
          # operation or set of operations for an application. A span is an individual
          # timed event which forms a node of the trace tree. Spans for a single trace
          # may span multiple services.
          #
          class Client
            # @private
            attr_reader :trace_service_stub

            ##
            # Configure the TraceService Client class.
            #
            # See {::Google::Cloud::Trace::V1::TraceService::Client::Configuration}
            # for a description of the configuration fields.
            #
            # ## Example
            #
            # To modify the configuration for all TraceService clients:
            #
            #     ::Google::Cloud::Trace::V1::TraceService::Client.configure do |config|
            #       config.timeout = 10.0
            #     end
            #
            # @yield [config] Configure the Client client.
            # @yieldparam config [Client::Configuration]
            #
            # @return [Client::Configuration]
            #
            def self.configure
              @configure ||= begin
                namespace = ["Google", "Cloud", "Trace", "V1"]
                parent_config = while namespace.any?
                                  parent_name = namespace.join "::"
                                  parent_const = const_get parent_name
                                  break parent_const.configure if parent_const&.respond_to? :configure
                                  namespace.pop
                                end
                default_config = Client::Configuration.new parent_config

                default_config.rpcs.list_traces.timeout = 45.0
                default_config.rpcs.list_traces.retry_policy = {
                  initial_delay: 0.1,
                  max_delay:     1.0,
                  multiplier:    1.2,
                  retry_codes:   [14, 4]
                }

                default_config.rpcs.get_trace.timeout = 45.0
                default_config.rpcs.get_trace.retry_policy = {
                  initial_delay: 0.1,
                  max_delay:     1.0,
                  multiplier:    1.2,
                  retry_codes:   [14, 4]
                }

                default_config.rpcs.patch_traces.timeout = 45.0
                default_config.rpcs.patch_traces.retry_policy = {
                  initial_delay: 0.1,
                  max_delay:     1.0,
                  multiplier:    1.2,
                  retry_codes:   [14, 4]
                }

                default_config
              end
              yield @configure if block_given?
              @configure
            end

            ##
            # Configure the TraceService Client instance.
            #
            # The configuration is set to the derived mode, meaning that values can be changed,
            # but structural changes (adding new fields, etc.) are not allowed. Structural changes
            # should be made on {Client.configure}.
            #
            # See {::Google::Cloud::Trace::V1::TraceService::Client::Configuration}
            # for a description of the configuration fields.
            #
            # @yield [config] Configure the Client client.
            # @yieldparam config [Client::Configuration]
            #
            # @return [Client::Configuration]
            #
            def configure
              yield @config if block_given?
              @config
            end

            ##
            # Create a new TraceService client object.
            #
            # ## Examples
            #
            # To create a new TraceService client with the default
            # configuration:
            #
            #     client = ::Google::Cloud::Trace::V1::TraceService::Client.new
            #
            # To create a new TraceService client with a custom
            # configuration:
            #
            #     client = ::Google::Cloud::Trace::V1::TraceService::Client.new do |config|
            #       config.timeout = 10.0
            #     end
            #
            # @yield [config] Configure the TraceService client.
            # @yieldparam config [Client::Configuration]
            #
            def initialize
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "gapic/grpc"
              require "google/devtools/cloudtrace/v1/trace_services_pb"

              # Create the configuration object
              @config = Configuration.new Client.configure

              # Yield the configuration if needed
              yield @config if block_given?

              # Create credentials
              credentials = @config.credentials
              credentials ||= Credentials.default scope: @config.scope
              if credentials.is_a?(String) || credentials.is_a?(Hash)
                credentials = Credentials.new credentials, scope: @config.scope
              end
              @quota_project_id = @config.quota_project
              @quota_project_id ||= credentials.quota_project_id if credentials.respond_to? :quota_project_id

              @trace_service_stub = ::Gapic::ServiceStub.new(
                ::Google::Cloud::Trace::V1::TraceService::Stub,
                credentials:  credentials,
                endpoint:     @config.endpoint,
                channel_args: @config.channel_args,
                interceptors: @config.interceptors
              )
            end

            # Service calls

            ##
            # Returns of a list of traces that match the specified filter conditions.
            #
            # @overload list_traces(request, options = nil)
            #   Pass arguments to `list_traces` via a request object, either of type
            #   {::Google::Cloud::Trace::V1::ListTracesRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Trace::V1::ListTracesRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload list_traces(project_id: nil, view: nil, page_size: nil, page_token: nil, start_time: nil, end_time: nil, filter: nil, order_by: nil)
            #   Pass arguments to `list_traces` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param project_id [::String]
            #     Required. ID of the Cloud project where the trace data is stored.
            #   @param view [::Google::Cloud::Trace::V1::ListTracesRequest::ViewType]
            #     Optional. Type of data returned for traces in the list. Default is
            #     `MINIMAL`.
            #   @param page_size [::Integer]
            #     Optional. Maximum number of traces to return. If not specified or <= 0, the
            #     implementation selects a reasonable value.  The implementation may
            #     return fewer traces than the requested page size.
            #   @param page_token [::String]
            #     Token identifying the page of results to return. If provided, use the
            #     value of the `next_page_token` field from a previous request.
            #   @param start_time [::Google::Protobuf::Timestamp, ::Hash]
            #     Start of the time interval (inclusive) during which the trace data was
            #     collected from the application.
            #   @param end_time [::Google::Protobuf::Timestamp, ::Hash]
            #     End of the time interval (inclusive) during which the trace data was
            #     collected from the application.
            #   @param filter [::String]
            #     Optional. A filter against labels for the request.
            #
            #     By default, searches use prefix matching. To specify exact match, prepend
            #     a plus symbol (`+`) to the search term.
            #     Multiple terms are ANDed. Syntax:
            #
            #     *   `root:NAME_PREFIX` or `NAME_PREFIX`: Return traces where any root
            #         span starts with `NAME_PREFIX`.
            #     *   `+root:NAME` or `+NAME`: Return traces where any root span's name is
            #         exactly `NAME`.
            #     *   `span:NAME_PREFIX`: Return traces where any span starts with
            #         `NAME_PREFIX`.
            #     *   `+span:NAME`: Return traces where any span's name is exactly
            #         `NAME`.
            #     *   `latency:DURATION`: Return traces whose overall latency is
            #         greater or equal to than `DURATION`. Accepted units are nanoseconds
            #         (`ns`), milliseconds (`ms`), and seconds (`s`). Default is `ms`. For
            #         example, `latency:24ms` returns traces whose overall latency
            #         is greater than or equal to 24 milliseconds.
            #     *   `label:LABEL_KEY`: Return all traces containing the specified
            #         label key (exact match, case-sensitive) regardless of the key:value
            #         pair's value (including empty values).
            #     *   `LABEL_KEY:VALUE_PREFIX`: Return all traces containing the specified
            #         label key (exact match, case-sensitive) whose value starts with
            #         `VALUE_PREFIX`. Both a key and a value must be specified.
            #     *   `+LABEL_KEY:VALUE`: Return all traces containing a key:value pair
            #         exactly matching the specified text. Both a key and a value must be
            #         specified.
            #     *   `method:VALUE`: Equivalent to `/http/method:VALUE`.
            #     *   `url:VALUE`: Equivalent to `/http/url:VALUE`.
            #   @param order_by [::String]
            #     Optional. Field used to sort the returned traces.
            #     Can be one of the following:
            #
            #     *   `trace_id`
            #     *   `name` (`name` field of root span in the trace)
            #     *   `duration` (difference between `end_time` and `start_time` fields of
            #          the root span)
            #     *   `start` (`start_time` field of the root span)
            #
            #     Descending order can be specified by appending `desc` to the sort field
            #     (for example, `name desc`).
            #
            #     Only one sort field is permitted.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Gapic::PagedEnumerable<::Google::Cloud::Trace::V1::Trace>]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Gapic::PagedEnumerable<::Google::Cloud::Trace::V1::Trace>]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def list_traces request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Trace::V1::ListTracesRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.list_traces.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Trace::V1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "project_id" => request.project_id
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.list_traces.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.list_traces.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @trace_service_stub.call_rpc :list_traces, request, options: options do |response, operation|
                response = ::Gapic::PagedEnumerable.new @trace_service_stub, :list_traces, request, response, operation, options
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Gets a single trace by its ID.
            #
            # @overload get_trace(request, options = nil)
            #   Pass arguments to `get_trace` via a request object, either of type
            #   {::Google::Cloud::Trace::V1::GetTraceRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Trace::V1::GetTraceRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload get_trace(project_id: nil, trace_id: nil)
            #   Pass arguments to `get_trace` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param project_id [::String]
            #     Required. ID of the Cloud project where the trace data is stored.
            #   @param trace_id [::String]
            #     Required. ID of the trace to return.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Trace::V1::Trace]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Trace::V1::Trace]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def get_trace request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Trace::V1::GetTraceRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.get_trace.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Trace::V1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "project_id" => request.project_id,
                "trace_id"   => request.trace_id
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.get_trace.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.get_trace.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @trace_service_stub.call_rpc :get_trace, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Sends new traces to Stackdriver Trace or updates existing traces. If the ID
            # of a trace that you send matches that of an existing trace, any fields
            # in the existing trace and its spans are overwritten by the provided values,
            # and any new fields provided are merged with the existing trace data. If the
            # ID does not match, a new trace is created.
            #
            # @overload patch_traces(request, options = nil)
            #   Pass arguments to `patch_traces` via a request object, either of type
            #   {::Google::Cloud::Trace::V1::PatchTracesRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Trace::V1::PatchTracesRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload patch_traces(project_id: nil, traces: nil)
            #   Pass arguments to `patch_traces` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param project_id [::String]
            #     Required. ID of the Cloud project where the trace data is stored.
            #   @param traces [::Google::Cloud::Trace::V1::Traces, ::Hash]
            #     Required. The body of the message.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Protobuf::Empty]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Protobuf::Empty]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def patch_traces request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Trace::V1::PatchTracesRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.patch_traces.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Trace::V1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "project_id" => request.project_id
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.patch_traces.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.patch_traces.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @trace_service_stub.call_rpc :patch_traces, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Configuration class for the TraceService API.
            #
            # This class represents the configuration for TraceService,
            # providing control over timeouts, retry behavior, logging, transport
            # parameters, and other low-level controls. Certain parameters can also be
            # applied individually to specific RPCs. See
            # {::Google::Cloud::Trace::V1::TraceService::Client::Configuration::Rpcs}
            # for a list of RPCs that can be configured independently.
            #
            # Configuration can be applied globally to all clients, or to a single client
            # on construction.
            #
            # # Examples
            #
            # To modify the global config, setting the timeout for list_traces
            # to 20 seconds, and all remaining timeouts to 10 seconds:
            #
            #     ::Google::Cloud::Trace::V1::TraceService::Client.configure do |config|
            #       config.timeout = 10.0
            #       config.rpcs.list_traces.timeout = 20.0
            #     end
            #
            # To apply the above configuration only to a new client:
            #
            #     client = ::Google::Cloud::Trace::V1::TraceService::Client.new do |config|
            #       config.timeout = 10.0
            #       config.rpcs.list_traces.timeout = 20.0
            #     end
            #
            # @!attribute [rw] endpoint
            #   The hostname or hostname:port of the service endpoint.
            #   Defaults to `"cloudtrace.googleapis.com"`.
            #   @return [::String]
            # @!attribute [rw] credentials
            #   Credentials to send with calls. You may provide any of the following types:
            #    *  (`String`) The path to a service account key file in JSON format
            #    *  (`Hash`) A service account key as a Hash
            #    *  (`Google::Auth::Credentials`) A googleauth credentials object
            #       (see the [googleauth docs](https://googleapis.dev/ruby/googleauth/latest/index.html))
            #    *  (`Signet::OAuth2::Client`) A signet oauth2 client object
            #       (see the [signet docs](https://googleapis.dev/ruby/signet/latest/Signet/OAuth2/Client.html))
            #    *  (`GRPC::Core::Channel`) a gRPC channel with included credentials
            #    *  (`GRPC::Core::ChannelCredentials`) a gRPC credentails object
            #    *  (`nil`) indicating no credentials
            #   @return [::Object]
            # @!attribute [rw] scope
            #   The OAuth scopes
            #   @return [::Array<::String>]
            # @!attribute [rw] lib_name
            #   The library name as recorded in instrumentation and logging
            #   @return [::String]
            # @!attribute [rw] lib_version
            #   The library version as recorded in instrumentation and logging
            #   @return [::String]
            # @!attribute [rw] channel_args
            #   Extra parameters passed to the gRPC channel. Note: this is ignored if a
            #   `GRPC::Core::Channel` object is provided as the credential.
            #   @return [::Hash]
            # @!attribute [rw] interceptors
            #   An array of interceptors that are run before calls are executed.
            #   @return [::Array<::GRPC::ClientInterceptor>]
            # @!attribute [rw] timeout
            #   The call timeout in seconds.
            #   @return [::Numeric]
            # @!attribute [rw] metadata
            #   Additional gRPC headers to be sent with the call.
            #   @return [::Hash{::Symbol=>::String}]
            # @!attribute [rw] retry_policy
            #   The retry policy. The value is a hash with the following keys:
            #    *  `:initial_delay` (*type:* `Numeric`) - The initial delay in seconds.
            #    *  `:max_delay` (*type:* `Numeric`) - The max delay in seconds.
            #    *  `:multiplier` (*type:* `Numeric`) - The incremental backoff multiplier.
            #    *  `:retry_codes` (*type:* `Array<String>`) - The error codes that should
            #       trigger a retry.
            #   @return [::Hash]
            # @!attribute [rw] quota_project
            #   A separate project against which to charge quota.
            #   @return [::String]
            #
            class Configuration
              extend ::Gapic::Config

              config_attr :endpoint,      "cloudtrace.googleapis.com", ::String
              config_attr :credentials,   nil do |value|
                allowed = [::String, ::Hash, ::Proc, ::Symbol, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
                allowed += [::GRPC::Core::Channel, ::GRPC::Core::ChannelCredentials] if defined? ::GRPC
                allowed.any? { |klass| klass === value }
              end
              config_attr :scope,         nil, ::String, ::Array, nil
              config_attr :lib_name,      nil, ::String, nil
              config_attr :lib_version,   nil, ::String, nil
              config_attr(:channel_args,  { "grpc.service_config_disable_resolution"=>1 }, ::Hash, nil)
              config_attr :interceptors,  nil, ::Array, nil
              config_attr :timeout,       nil, ::Numeric, nil
              config_attr :metadata,      nil, ::Hash, nil
              config_attr :retry_policy,  nil, ::Hash, ::Proc, nil
              config_attr :quota_project, nil, ::String, nil

              # @private
              def initialize parent_config = nil
                @parent_config = parent_config unless parent_config.nil?

                yield self if block_given?
              end

              ##
              # Configurations for individual RPCs
              # @return [Rpcs]
              #
              def rpcs
                @rpcs ||= begin
                  parent_rpcs = nil
                  parent_rpcs = @parent_config.rpcs if defined?(@parent_config) && @parent_config&.respond_to?(:rpcs)
                  Rpcs.new parent_rpcs
                end
              end

              ##
              # Configuration RPC class for the TraceService API.
              #
              # Includes fields providing the configuration for each RPC in this service.
              # Each configuration object is of type `Gapic::Config::Method` and includes
              # the following configuration fields:
              #
              #  *  `timeout` (*type:* `Numeric`) - The call timeout in milliseconds
              #  *  `metadata` (*type:* `Hash{Symbol=>String}`) - Additional gRPC headers
              #  *  `retry_policy (*type:* `Hash`) - The retry policy. The policy fields
              #     include the following keys:
              #      *  `:initial_delay` (*type:* `Numeric`) - The initial delay in seconds.
              #      *  `:max_delay` (*type:* `Numeric`) - The max delay in seconds.
              #      *  `:multiplier` (*type:* `Numeric`) - The incremental backoff multiplier.
              #      *  `:retry_codes` (*type:* `Array<String>`) - The error codes that should
              #         trigger a retry.
              #
              class Rpcs
                ##
                # RPC-specific configuration for `list_traces`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :list_traces
                ##
                # RPC-specific configuration for `get_trace`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :get_trace
                ##
                # RPC-specific configuration for `patch_traces`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :patch_traces

                # @private
                def initialize parent_rpcs = nil
                  list_traces_config = parent_rpcs&.list_traces if parent_rpcs&.respond_to? :list_traces
                  @list_traces = ::Gapic::Config::Method.new list_traces_config
                  get_trace_config = parent_rpcs&.get_trace if parent_rpcs&.respond_to? :get_trace
                  @get_trace = ::Gapic::Config::Method.new get_trace_config
                  patch_traces_config = parent_rpcs&.patch_traces if parent_rpcs&.respond_to? :patch_traces
                  @patch_traces = ::Gapic::Config::Method.new patch_traces_config

                  yield self if block_given?
                end
              end
            end
          end
        end
      end
    end
  end
end
