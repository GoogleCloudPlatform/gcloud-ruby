# frozen_string_literal: true

# Copyright 2020 Google LLC
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
require "google/devtools/clouddebugger/v2/debugger_pb"

module Google
  module Cloud
    module Debugger
      module V2
        module Debugger
          ##
          # Client for the Debugger service.
          #
          # The Debugger service provides the API that allows users to collect run-time
          # information from a running application, without stopping or slowing it down
          # and without modifying its state.  An application may include one or
          # more replicated processes performing the same work.
          #
          # A debugged application is represented using the Debuggee concept. The
          # Debugger service provides a way to query for available debuggees, but does
          # not provide a way to create one.  A debuggee is created using the Controller
          # service, usually by running a debugger agent with the application.
          #
          # The Debugger service enables the client to set one or more Breakpoints on a
          # Debuggee and collect the results of the set Breakpoints.
          #
          class Client
            # @private
            attr_reader :debugger_stub

            ##
            # Configure the Debugger Client class.
            #
            # See {::Google::Cloud::Debugger::V2::Debugger::Client::Configuration}
            # for a description of the configuration fields.
            #
            # ## Example
            #
            # To modify the configuration for all Debugger clients:
            #
            #     ::Google::Cloud::Debugger::V2::Debugger::Client.configure do |config|
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
                namespace = ["Google", "Cloud", "Debugger", "V2"]
                parent_config = while namespace.any?
                                  parent_name = namespace.join "::"
                                  parent_const = const_get parent_name
                                  break parent_const.configure if parent_const&.respond_to? :configure
                                  namespace.pop
                                end
                default_config = Client::Configuration.new parent_config

                default_config.rpcs.set_breakpoint.timeout = 600.0

                default_config.rpcs.get_breakpoint.timeout = 600.0
                default_config.rpcs.get_breakpoint.retry_policy = {
                  initial_delay: 0.1,
                  max_delay:     60.0,
                  multiplier:    1.3,
                  retry_codes:   [14, 4]
                }

                default_config.rpcs.delete_breakpoint.timeout = 600.0
                default_config.rpcs.delete_breakpoint.retry_policy = {
                  initial_delay: 0.1,
                  max_delay:     60.0,
                  multiplier:    1.3,
                  retry_codes:   [14, 4]
                }

                default_config.rpcs.list_breakpoints.timeout = 600.0
                default_config.rpcs.list_breakpoints.retry_policy = {
                  initial_delay: 0.1,
                  max_delay:     60.0,
                  multiplier:    1.3,
                  retry_codes:   [14, 4]
                }

                default_config.rpcs.list_debuggees.timeout = 600.0
                default_config.rpcs.list_debuggees.retry_policy = {
                  initial_delay: 0.1,
                  max_delay:     60.0,
                  multiplier:    1.3,
                  retry_codes:   [14, 4]
                }

                default_config
              end
              yield @configure if block_given?
              @configure
            end

            ##
            # Configure the Debugger Client instance.
            #
            # The configuration is set to the derived mode, meaning that values can be changed,
            # but structural changes (adding new fields, etc.) are not allowed. Structural changes
            # should be made on {Client.configure}.
            #
            # See {::Google::Cloud::Debugger::V2::Debugger::Client::Configuration}
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
            # Create a new Debugger client object.
            #
            # ## Examples
            #
            # To create a new Debugger client with the default
            # configuration:
            #
            #     client = ::Google::Cloud::Debugger::V2::Debugger::Client.new
            #
            # To create a new Debugger client with a custom
            # configuration:
            #
            #     client = ::Google::Cloud::Debugger::V2::Debugger::Client.new do |config|
            #       config.timeout = 10.0
            #     end
            #
            # @yield [config] Configure the Debugger client.
            # @yieldparam config [Client::Configuration]
            #
            def initialize
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "gapic/grpc"
              require "google/devtools/clouddebugger/v2/debugger_services_pb"

              # Create the configuration object
              @config = Configuration.new Client.configure

              # Yield the configuration if needed
              yield @config if block_given?

              # Create credentials
              credentials = @config.credentials
              # Use self-signed JWT if the scope and endpoint are unchanged from default,
              # but only if the default endpoint does not have a region prefix.
              enable_self_signed_jwt = @config.scope == Client.configure.scope &&
                                       @config.endpoint == Client.configure.endpoint &&
                                       !@config.endpoint.split(".").first.include?("-")
              credentials ||= Credentials.default scope:                  @config.scope,
                                                  enable_self_signed_jwt: enable_self_signed_jwt
              if credentials.is_a?(String) || credentials.is_a?(Hash)
                credentials = Credentials.new credentials, scope: @config.scope
              end
              @quota_project_id = @config.quota_project
              @quota_project_id ||= credentials.quota_project_id if credentials.respond_to? :quota_project_id

              @debugger_stub = ::Gapic::ServiceStub.new(
                ::Google::Cloud::Debugger::V2::Debugger2::Stub,
                credentials:  credentials,
                endpoint:     @config.endpoint,
                channel_args: @config.channel_args,
                interceptors: @config.interceptors
              )
            end

            # Service calls

            ##
            # Sets the breakpoint to the debuggee.
            #
            # @overload set_breakpoint(request, options = nil)
            #   Pass arguments to `set_breakpoint` via a request object, either of type
            #   {::Google::Cloud::Debugger::V2::SetBreakpointRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Debugger::V2::SetBreakpointRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload set_breakpoint(debuggee_id: nil, breakpoint: nil, client_version: nil)
            #   Pass arguments to `set_breakpoint` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param debuggee_id [::String]
            #     Required. ID of the debuggee where the breakpoint is to be set.
            #   @param breakpoint [::Google::Cloud::Debugger::V2::Breakpoint, ::Hash]
            #     Required. Breakpoint specification to set.
            #     The field `location` of the breakpoint must be set.
            #   @param client_version [::String]
            #     Required. The client version making the call.
            #     Schema: `domain/type/version` (e.g., `google.com/intellij/v1`).
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Debugger::V2::SetBreakpointResponse]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Debugger::V2::SetBreakpointResponse]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def set_breakpoint request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Debugger::V2::SetBreakpointRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.set_breakpoint.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Debugger::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "debuggee_id" => request.debuggee_id
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.set_breakpoint.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.set_breakpoint.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @debugger_stub.call_rpc :set_breakpoint, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Gets breakpoint information.
            #
            # @overload get_breakpoint(request, options = nil)
            #   Pass arguments to `get_breakpoint` via a request object, either of type
            #   {::Google::Cloud::Debugger::V2::GetBreakpointRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Debugger::V2::GetBreakpointRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload get_breakpoint(debuggee_id: nil, breakpoint_id: nil, client_version: nil)
            #   Pass arguments to `get_breakpoint` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param debuggee_id [::String]
            #     Required. ID of the debuggee whose breakpoint to get.
            #   @param breakpoint_id [::String]
            #     Required. ID of the breakpoint to get.
            #   @param client_version [::String]
            #     Required. The client version making the call.
            #     Schema: `domain/type/version` (e.g., `google.com/intellij/v1`).
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Debugger::V2::GetBreakpointResponse]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Debugger::V2::GetBreakpointResponse]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def get_breakpoint request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Debugger::V2::GetBreakpointRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.get_breakpoint.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Debugger::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "debuggee_id"   => request.debuggee_id,
                "breakpoint_id" => request.breakpoint_id
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.get_breakpoint.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.get_breakpoint.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @debugger_stub.call_rpc :get_breakpoint, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Deletes the breakpoint from the debuggee.
            #
            # @overload delete_breakpoint(request, options = nil)
            #   Pass arguments to `delete_breakpoint` via a request object, either of type
            #   {::Google::Cloud::Debugger::V2::DeleteBreakpointRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Debugger::V2::DeleteBreakpointRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload delete_breakpoint(debuggee_id: nil, breakpoint_id: nil, client_version: nil)
            #   Pass arguments to `delete_breakpoint` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param debuggee_id [::String]
            #     Required. ID of the debuggee whose breakpoint to delete.
            #   @param breakpoint_id [::String]
            #     Required. ID of the breakpoint to delete.
            #   @param client_version [::String]
            #     Required. The client version making the call.
            #     Schema: `domain/type/version` (e.g., `google.com/intellij/v1`).
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Protobuf::Empty]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Protobuf::Empty]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def delete_breakpoint request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Debugger::V2::DeleteBreakpointRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.delete_breakpoint.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Debugger::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "debuggee_id"   => request.debuggee_id,
                "breakpoint_id" => request.breakpoint_id
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.delete_breakpoint.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.delete_breakpoint.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @debugger_stub.call_rpc :delete_breakpoint, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Lists all breakpoints for the debuggee.
            #
            # @overload list_breakpoints(request, options = nil)
            #   Pass arguments to `list_breakpoints` via a request object, either of type
            #   {::Google::Cloud::Debugger::V2::ListBreakpointsRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Debugger::V2::ListBreakpointsRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload list_breakpoints(debuggee_id: nil, include_all_users: nil, include_inactive: nil, action: nil, strip_results: nil, wait_token: nil, client_version: nil)
            #   Pass arguments to `list_breakpoints` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param debuggee_id [::String]
            #     Required. ID of the debuggee whose breakpoints to list.
            #   @param include_all_users [::Boolean]
            #     When set to `true`, the response includes the list of breakpoints set by
            #     any user. Otherwise, it includes only breakpoints set by the caller.
            #   @param include_inactive [::Boolean]
            #     When set to `true`, the response includes active and inactive
            #     breakpoints. Otherwise, it includes only active breakpoints.
            #   @param action [::Google::Cloud::Debugger::V2::ListBreakpointsRequest::BreakpointActionValue, ::Hash]
            #     When set, the response includes only breakpoints with the specified action.
            #   @param strip_results [::Boolean]
            #     This field is deprecated. The following fields are always stripped out of
            #     the result: `stack_frames`, `evaluated_expressions` and `variable_table`.
            #   @param wait_token [::String]
            #     A wait token that, if specified, blocks the call until the breakpoints
            #     list has changed, or a server selected timeout has expired.  The value
            #     should be set from the last response. The error code
            #     `google.rpc.Code.ABORTED` (RPC) is returned on wait timeout, which
            #     should be called again with the same `wait_token`.
            #   @param client_version [::String]
            #     Required. The client version making the call.
            #     Schema: `domain/type/version` (e.g., `google.com/intellij/v1`).
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Debugger::V2::ListBreakpointsResponse]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Debugger::V2::ListBreakpointsResponse]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def list_breakpoints request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Debugger::V2::ListBreakpointsRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.list_breakpoints.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Debugger::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "debuggee_id" => request.debuggee_id
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.list_breakpoints.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.list_breakpoints.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @debugger_stub.call_rpc :list_breakpoints, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Lists all the debuggees that the user has access to.
            #
            # @overload list_debuggees(request, options = nil)
            #   Pass arguments to `list_debuggees` via a request object, either of type
            #   {::Google::Cloud::Debugger::V2::ListDebuggeesRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Debugger::V2::ListDebuggeesRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload list_debuggees(project: nil, include_inactive: nil, client_version: nil)
            #   Pass arguments to `list_debuggees` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param project [::String]
            #     Required. Project number of a Google Cloud project whose debuggees to list.
            #   @param include_inactive [::Boolean]
            #     When set to `true`, the result includes all debuggees. Otherwise, the
            #     result includes only debuggees that are active.
            #   @param client_version [::String]
            #     Required. The client version making the call.
            #     Schema: `domain/type/version` (e.g., `google.com/intellij/v1`).
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Debugger::V2::ListDebuggeesResponse]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Debugger::V2::ListDebuggeesResponse]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def list_debuggees request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Debugger::V2::ListDebuggeesRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.list_debuggees.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Debugger::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.list_debuggees.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.list_debuggees.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @debugger_stub.call_rpc :list_debuggees, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Configuration class for the Debugger API.
            #
            # This class represents the configuration for Debugger,
            # providing control over timeouts, retry behavior, logging, transport
            # parameters, and other low-level controls. Certain parameters can also be
            # applied individually to specific RPCs. See
            # {::Google::Cloud::Debugger::V2::Debugger::Client::Configuration::Rpcs}
            # for a list of RPCs that can be configured independently.
            #
            # Configuration can be applied globally to all clients, or to a single client
            # on construction.
            #
            # # Examples
            #
            # To modify the global config, setting the timeout for set_breakpoint
            # to 20 seconds, and all remaining timeouts to 10 seconds:
            #
            #     ::Google::Cloud::Debugger::V2::Debugger::Client.configure do |config|
            #       config.timeout = 10.0
            #       config.rpcs.set_breakpoint.timeout = 20.0
            #     end
            #
            # To apply the above configuration only to a new client:
            #
            #     client = ::Google::Cloud::Debugger::V2::Debugger::Client.new do |config|
            #       config.timeout = 10.0
            #       config.rpcs.set_breakpoint.timeout = 20.0
            #     end
            #
            # @!attribute [rw] endpoint
            #   The hostname or hostname:port of the service endpoint.
            #   Defaults to `"clouddebugger.googleapis.com"`.
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

              config_attr :endpoint,      "clouddebugger.googleapis.com", ::String
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
              # Configuration RPC class for the Debugger API.
              #
              # Includes fields providing the configuration for each RPC in this service.
              # Each configuration object is of type `Gapic::Config::Method` and includes
              # the following configuration fields:
              #
              #  *  `timeout` (*type:* `Numeric`) - The call timeout in seconds
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
                # RPC-specific configuration for `set_breakpoint`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :set_breakpoint
                ##
                # RPC-specific configuration for `get_breakpoint`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :get_breakpoint
                ##
                # RPC-specific configuration for `delete_breakpoint`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :delete_breakpoint
                ##
                # RPC-specific configuration for `list_breakpoints`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :list_breakpoints
                ##
                # RPC-specific configuration for `list_debuggees`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :list_debuggees

                # @private
                def initialize parent_rpcs = nil
                  set_breakpoint_config = parent_rpcs&.set_breakpoint if parent_rpcs&.respond_to? :set_breakpoint
                  @set_breakpoint = ::Gapic::Config::Method.new set_breakpoint_config
                  get_breakpoint_config = parent_rpcs&.get_breakpoint if parent_rpcs&.respond_to? :get_breakpoint
                  @get_breakpoint = ::Gapic::Config::Method.new get_breakpoint_config
                  delete_breakpoint_config = parent_rpcs&.delete_breakpoint if parent_rpcs&.respond_to? :delete_breakpoint
                  @delete_breakpoint = ::Gapic::Config::Method.new delete_breakpoint_config
                  list_breakpoints_config = parent_rpcs&.list_breakpoints if parent_rpcs&.respond_to? :list_breakpoints
                  @list_breakpoints = ::Gapic::Config::Method.new list_breakpoints_config
                  list_debuggees_config = parent_rpcs&.list_debuggees if parent_rpcs&.respond_to? :list_debuggees
                  @list_debuggees = ::Gapic::Config::Method.new list_debuggees_config

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
