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
require "google/devtools/cloudprofiler/v2/profiler_pb"

module Google
  module Cloud
    module Profiler
      module V2
        module ProfilerService
          ##
          # Client for the ProfilerService service.
          #
          # Manage the collection of continuous profiling data provided by profiling
          # agents running in the cloud or by an offline provider of profiling data.
          #
          # General guidelines:
          # * Profiles for a single deployment must be created in ascending time order.
          # * Profiles can be created in either online or offline mode, see below.
          #
          class Client
            # @private
            attr_reader :profiler_service_stub

            ##
            # Configure the ProfilerService Client class.
            #
            # See {::Google::Cloud::Profiler::V2::ProfilerService::Client::Configuration}
            # for a description of the configuration fields.
            #
            # ## Example
            #
            # To modify the configuration for all ProfilerService clients:
            #
            #     ::Google::Cloud::Profiler::V2::ProfilerService::Client.configure do |config|
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
                namespace = ["Google", "Cloud", "Profiler", "V2"]
                parent_config = while namespace.any?
                                  parent_name = namespace.join "::"
                                  parent_const = const_get parent_name
                                  break parent_const.configure if parent_const&.respond_to? :configure
                                  namespace.pop
                                end
                default_config = Client::Configuration.new parent_config

                default_config.timeout = 30.0
                default_config.retry_policy = {
                  initial_delay: 1.0,
                  max_delay:     10.0,
                  multiplier:    1.3,
                  retry_codes:   [14]
                }

                default_config.rpcs.create_profile.timeout = 3600.0

                default_config.rpcs.create_offline_profile.timeout = 30.0

                default_config.rpcs.update_profile.timeout = 30.0

                default_config
              end
              yield @configure if block_given?
              @configure
            end

            ##
            # Configure the ProfilerService Client instance.
            #
            # The configuration is set to the derived mode, meaning that values can be changed,
            # but structural changes (adding new fields, etc.) are not allowed. Structural changes
            # should be made on {Client.configure}.
            #
            # See {::Google::Cloud::Profiler::V2::ProfilerService::Client::Configuration}
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
            # Create a new ProfilerService client object.
            #
            # ## Examples
            #
            # To create a new ProfilerService client with the default
            # configuration:
            #
            #     client = ::Google::Cloud::Profiler::V2::ProfilerService::Client.new
            #
            # To create a new ProfilerService client with a custom
            # configuration:
            #
            #     client = ::Google::Cloud::Profiler::V2::ProfilerService::Client.new do |config|
            #       config.timeout = 10.0
            #     end
            #
            # @yield [config] Configure the ProfilerService client.
            # @yieldparam config [Client::Configuration]
            #
            def initialize
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "gapic/grpc"
              require "google/devtools/cloudprofiler/v2/profiler_services_pb"

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

              @profiler_service_stub = ::Gapic::ServiceStub.new(
                ::Google::Cloud::Profiler::V2::ProfilerService::Stub,
                credentials:  credentials,
                endpoint:     @config.endpoint,
                channel_args: @config.channel_args,
                interceptors: @config.interceptors
              )
            end

            # Service calls

            ##
            # CreateProfile creates a new profile resource in the online mode.
            #
            # The server ensures that the new profiles are created at a constant rate per
            # deployment, so the creation request may hang for some time until the next
            # profile session is available.
            #
            # The request may fail with ABORTED error if the creation is not available
            # within ~1m, the response will indicate the duration of the backoff the
            # client should take before attempting creating a profile again. The backoff
            # duration is returned in google.rpc.RetryInfo extension on the response
            # status. To a gRPC client, the extension will be return as a
            # binary-serialized proto in the trailing metadata item named
            # "google.rpc.retryinfo-bin".
            #
            # @overload create_profile(request, options = nil)
            #   Pass arguments to `create_profile` via a request object, either of type
            #   {::Google::Cloud::Profiler::V2::CreateProfileRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Profiler::V2::CreateProfileRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload create_profile(parent: nil, deployment: nil, profile_type: nil)
            #   Pass arguments to `create_profile` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param parent [::String]
            #     Parent project to create the profile in.
            #   @param deployment [::Google::Cloud::Profiler::V2::Deployment, ::Hash]
            #     Deployment details.
            #   @param profile_type [::Array<::Google::Cloud::Profiler::V2::ProfileType>]
            #     One or more profile types that the agent is capable of providing.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Profiler::V2::Profile]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Profiler::V2::Profile]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def create_profile request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Profiler::V2::CreateProfileRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.create_profile.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Profiler::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.create_profile.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.create_profile.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @profiler_service_stub.call_rpc :create_profile, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # CreateOfflineProfile creates a new profile resource in the offline mode.
            # The client provides the profile to create along with the profile bytes, the
            # server records it.
            #
            # @overload create_offline_profile(request, options = nil)
            #   Pass arguments to `create_offline_profile` via a request object, either of type
            #   {::Google::Cloud::Profiler::V2::CreateOfflineProfileRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Profiler::V2::CreateOfflineProfileRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload create_offline_profile(parent: nil, profile: nil)
            #   Pass arguments to `create_offline_profile` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param parent [::String]
            #     Parent project to create the profile in.
            #   @param profile [::Google::Cloud::Profiler::V2::Profile, ::Hash]
            #     Contents of the profile to create.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Profiler::V2::Profile]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Profiler::V2::Profile]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def create_offline_profile request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Profiler::V2::CreateOfflineProfileRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.create_offline_profile.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Profiler::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.create_offline_profile.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.create_offline_profile.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @profiler_service_stub.call_rpc :create_offline_profile, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # UpdateProfile updates the profile bytes and labels on the profile resource
            # created in the online mode. Updating the bytes for profiles created in the
            # offline mode is currently not supported: the profile content must be
            # provided at the time of the profile creation.
            #
            # @overload update_profile(request, options = nil)
            #   Pass arguments to `update_profile` via a request object, either of type
            #   {::Google::Cloud::Profiler::V2::UpdateProfileRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Profiler::V2::UpdateProfileRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload update_profile(profile: nil, update_mask: nil)
            #   Pass arguments to `update_profile` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param profile [::Google::Cloud::Profiler::V2::Profile, ::Hash]
            #     Profile to update
            #   @param update_mask [::Google::Protobuf::FieldMask, ::Hash]
            #     Field mask used to specify the fields to be overwritten. Currently only
            #     profile_bytes and labels fields are supported by UpdateProfile, so only
            #     those fields can be specified in the mask. When no mask is provided, all
            #     fields are overwritten.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Profiler::V2::Profile]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Profiler::V2::Profile]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def update_profile request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Profiler::V2::UpdateProfileRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.update_profile.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Profiler::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "profile.name" => request.profile.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.update_profile.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.update_profile.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @profiler_service_stub.call_rpc :update_profile, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Configuration class for the ProfilerService API.
            #
            # This class represents the configuration for ProfilerService,
            # providing control over timeouts, retry behavior, logging, transport
            # parameters, and other low-level controls. Certain parameters can also be
            # applied individually to specific RPCs. See
            # {::Google::Cloud::Profiler::V2::ProfilerService::Client::Configuration::Rpcs}
            # for a list of RPCs that can be configured independently.
            #
            # Configuration can be applied globally to all clients, or to a single client
            # on construction.
            #
            # # Examples
            #
            # To modify the global config, setting the timeout for create_profile
            # to 20 seconds, and all remaining timeouts to 10 seconds:
            #
            #     ::Google::Cloud::Profiler::V2::ProfilerService::Client.configure do |config|
            #       config.timeout = 10.0
            #       config.rpcs.create_profile.timeout = 20.0
            #     end
            #
            # To apply the above configuration only to a new client:
            #
            #     client = ::Google::Cloud::Profiler::V2::ProfilerService::Client.new do |config|
            #       config.timeout = 10.0
            #       config.rpcs.create_profile.timeout = 20.0
            #     end
            #
            # @!attribute [rw] endpoint
            #   The hostname or hostname:port of the service endpoint.
            #   Defaults to `"cloudprofiler.googleapis.com"`.
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

              config_attr :endpoint,      "cloudprofiler.googleapis.com", ::String
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
              # Configuration RPC class for the ProfilerService API.
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
                # RPC-specific configuration for `create_profile`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :create_profile
                ##
                # RPC-specific configuration for `create_offline_profile`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :create_offline_profile
                ##
                # RPC-specific configuration for `update_profile`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :update_profile

                # @private
                def initialize parent_rpcs = nil
                  create_profile_config = parent_rpcs&.create_profile if parent_rpcs&.respond_to? :create_profile
                  @create_profile = ::Gapic::Config::Method.new create_profile_config
                  create_offline_profile_config = parent_rpcs&.create_offline_profile if parent_rpcs&.respond_to? :create_offline_profile
                  @create_offline_profile = ::Gapic::Config::Method.new create_offline_profile_config
                  update_profile_config = parent_rpcs&.update_profile if parent_rpcs&.respond_to? :update_profile
                  @update_profile = ::Gapic::Config::Method.new update_profile_config

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
