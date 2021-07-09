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
require "google/appengine/v1/appengine_pb"

module Google
  module Cloud
    module AppEngine
      module V1
        module DomainMappings
          ##
          # Client for the DomainMappings service.
          #
          # Manages domains serving an application.
          #
          class Client
            # @private
            attr_reader :domain_mappings_stub

            ##
            # Configure the DomainMappings Client class.
            #
            # See {::Google::Cloud::AppEngine::V1::DomainMappings::Client::Configuration}
            # for a description of the configuration fields.
            #
            # ## Example
            #
            # To modify the configuration for all DomainMappings clients:
            #
            #     ::Google::Cloud::AppEngine::V1::DomainMappings::Client.configure do |config|
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
                namespace = ["Google", "Cloud", "AppEngine", "V1"]
                parent_config = while namespace.any?
                                  parent_name = namespace.join "::"
                                  parent_const = const_get parent_name
                                  break parent_const.configure if parent_const.respond_to? :configure
                                  namespace.pop
                                end
                default_config = Client::Configuration.new parent_config

                default_config.timeout = 60.0

                default_config
              end
              yield @configure if block_given?
              @configure
            end

            ##
            # Configure the DomainMappings Client instance.
            #
            # The configuration is set to the derived mode, meaning that values can be changed,
            # but structural changes (adding new fields, etc.) are not allowed. Structural changes
            # should be made on {Client.configure}.
            #
            # See {::Google::Cloud::AppEngine::V1::DomainMappings::Client::Configuration}
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
            # Create a new DomainMappings client object.
            #
            # ## Examples
            #
            # To create a new DomainMappings client with the default
            # configuration:
            #
            #     client = ::Google::Cloud::AppEngine::V1::DomainMappings::Client.new
            #
            # To create a new DomainMappings client with a custom
            # configuration:
            #
            #     client = ::Google::Cloud::AppEngine::V1::DomainMappings::Client.new do |config|
            #       config.timeout = 10.0
            #     end
            #
            # @yield [config] Configure the DomainMappings client.
            # @yieldparam config [Client::Configuration]
            #
            def initialize
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "gapic/grpc"
              require "google/appengine/v1/appengine_services_pb"

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
              credentials ||= Credentials.default scope: @config.scope,
                                                  enable_self_signed_jwt: enable_self_signed_jwt
              if credentials.is_a?(String) || credentials.is_a?(Hash)
                credentials = Credentials.new credentials, scope: @config.scope
              end
              @quota_project_id = @config.quota_project
              @quota_project_id ||= credentials.quota_project_id if credentials.respond_to? :quota_project_id

              @operations_client = Operations.new do |config|
                config.credentials = credentials
                config.endpoint = @config.endpoint
              end

              @domain_mappings_stub = ::Gapic::ServiceStub.new(
                ::Google::Cloud::AppEngine::V1::DomainMappings::Stub,
                credentials:  credentials,
                endpoint:     @config.endpoint,
                channel_args: @config.channel_args,
                interceptors: @config.interceptors
              )
            end

            ##
            # Get the associated client for long-running operations.
            #
            # @return [::Google::Cloud::AppEngine::V1::DomainMappings::Operations]
            #
            attr_reader :operations_client

            # Service calls

            ##
            # Lists the domain mappings on an application.
            #
            # @overload list_domain_mappings(request, options = nil)
            #   Pass arguments to `list_domain_mappings` via a request object, either of type
            #   {::Google::Cloud::AppEngine::V1::ListDomainMappingsRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::AppEngine::V1::ListDomainMappingsRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload list_domain_mappings(parent: nil, page_size: nil, page_token: nil)
            #   Pass arguments to `list_domain_mappings` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param parent [::String]
            #     Name of the parent Application resource. Example: `apps/myapp`.
            #   @param page_size [::Integer]
            #     Maximum results to return per page.
            #   @param page_token [::String]
            #     Continuation token for fetching the next page of results.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Gapic::PagedEnumerable<::Google::Cloud::AppEngine::V1::DomainMapping>]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Gapic::PagedEnumerable<::Google::Cloud::AppEngine::V1::DomainMapping>]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def list_domain_mappings request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::AppEngine::V1::ListDomainMappingsRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.list_domain_mappings.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Appengine::V1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.list_domain_mappings.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.list_domain_mappings.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @domain_mappings_stub.call_rpc :list_domain_mappings, request, options: options do |response, operation|
                response = ::Gapic::PagedEnumerable.new @domain_mappings_stub, :list_domain_mappings, request, response, operation, options
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Gets the specified domain mapping.
            #
            # @overload get_domain_mapping(request, options = nil)
            #   Pass arguments to `get_domain_mapping` via a request object, either of type
            #   {::Google::Cloud::AppEngine::V1::GetDomainMappingRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::AppEngine::V1::GetDomainMappingRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload get_domain_mapping(name: nil)
            #   Pass arguments to `get_domain_mapping` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param name [::String]
            #     Name of the resource requested. Example:
            #     `apps/myapp/domainMappings/example.com`.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::AppEngine::V1::DomainMapping]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::AppEngine::V1::DomainMapping]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def get_domain_mapping request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::AppEngine::V1::GetDomainMappingRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.get_domain_mapping.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Appengine::V1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.get_domain_mapping.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.get_domain_mapping.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @domain_mappings_stub.call_rpc :get_domain_mapping, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Maps a domain to an application. A user must be authorized to administer a
            # domain in order to map it to an application. For a list of available
            # authorized domains, see [`AuthorizedDomains.ListAuthorizedDomains`]().
            #
            # @overload create_domain_mapping(request, options = nil)
            #   Pass arguments to `create_domain_mapping` via a request object, either of type
            #   {::Google::Cloud::AppEngine::V1::CreateDomainMappingRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::AppEngine::V1::CreateDomainMappingRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload create_domain_mapping(parent: nil, domain_mapping: nil, override_strategy: nil)
            #   Pass arguments to `create_domain_mapping` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param parent [::String]
            #     Name of the parent Application resource. Example: `apps/myapp`.
            #   @param domain_mapping [::Google::Cloud::AppEngine::V1::DomainMapping, ::Hash]
            #     Domain mapping configuration.
            #   @param override_strategy [::Google::Cloud::AppEngine::V1::DomainOverrideStrategy]
            #     Whether the domain creation should override any existing mappings for this
            #     domain. By default, overrides are rejected.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Gapic::Operation]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Gapic::Operation]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def create_domain_mapping request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::AppEngine::V1::CreateDomainMappingRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.create_domain_mapping.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Appengine::V1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.create_domain_mapping.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.create_domain_mapping.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @domain_mappings_stub.call_rpc :create_domain_mapping, request, options: options do |response, operation|
                response = ::Gapic::Operation.new response, @operations_client, options: options
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Updates the specified domain mapping. To map an SSL certificate to a
            # domain mapping, update `certificate_id` to point to an `AuthorizedCertificate`
            # resource. A user must be authorized to administer the associated domain
            # in order to update a `DomainMapping` resource.
            #
            # @overload update_domain_mapping(request, options = nil)
            #   Pass arguments to `update_domain_mapping` via a request object, either of type
            #   {::Google::Cloud::AppEngine::V1::UpdateDomainMappingRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::AppEngine::V1::UpdateDomainMappingRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload update_domain_mapping(name: nil, domain_mapping: nil, update_mask: nil)
            #   Pass arguments to `update_domain_mapping` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param name [::String]
            #     Name of the resource to update. Example:
            #     `apps/myapp/domainMappings/example.com`.
            #   @param domain_mapping [::Google::Cloud::AppEngine::V1::DomainMapping, ::Hash]
            #     A domain mapping containing the updated resource. Only fields set
            #     in the field mask will be updated.
            #   @param update_mask [::Google::Protobuf::FieldMask, ::Hash]
            #     Standard field mask for the set of fields to be updated.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Gapic::Operation]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Gapic::Operation]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def update_domain_mapping request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::AppEngine::V1::UpdateDomainMappingRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.update_domain_mapping.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Appengine::V1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.update_domain_mapping.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.update_domain_mapping.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @domain_mappings_stub.call_rpc :update_domain_mapping, request, options: options do |response, operation|
                response = ::Gapic::Operation.new response, @operations_client, options: options
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Deletes the specified domain mapping. A user must be authorized to
            # administer the associated domain in order to delete a `DomainMapping`
            # resource.
            #
            # @overload delete_domain_mapping(request, options = nil)
            #   Pass arguments to `delete_domain_mapping` via a request object, either of type
            #   {::Google::Cloud::AppEngine::V1::DeleteDomainMappingRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::AppEngine::V1::DeleteDomainMappingRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload delete_domain_mapping(name: nil)
            #   Pass arguments to `delete_domain_mapping` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param name [::String]
            #     Name of the resource to delete. Example:
            #     `apps/myapp/domainMappings/example.com`.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Gapic::Operation]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Gapic::Operation]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def delete_domain_mapping request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::AppEngine::V1::DeleteDomainMappingRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.delete_domain_mapping.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Appengine::V1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.delete_domain_mapping.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.delete_domain_mapping.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @domain_mappings_stub.call_rpc :delete_domain_mapping, request, options: options do |response, operation|
                response = ::Gapic::Operation.new response, @operations_client, options: options
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Configuration class for the DomainMappings API.
            #
            # This class represents the configuration for DomainMappings,
            # providing control over timeouts, retry behavior, logging, transport
            # parameters, and other low-level controls. Certain parameters can also be
            # applied individually to specific RPCs. See
            # {::Google::Cloud::AppEngine::V1::DomainMappings::Client::Configuration::Rpcs}
            # for a list of RPCs that can be configured independently.
            #
            # Configuration can be applied globally to all clients, or to a single client
            # on construction.
            #
            # # Examples
            #
            # To modify the global config, setting the timeout for list_domain_mappings
            # to 20 seconds, and all remaining timeouts to 10 seconds:
            #
            #     ::Google::Cloud::AppEngine::V1::DomainMappings::Client.configure do |config|
            #       config.timeout = 10.0
            #       config.rpcs.list_domain_mappings.timeout = 20.0
            #     end
            #
            # To apply the above configuration only to a new client:
            #
            #     client = ::Google::Cloud::AppEngine::V1::DomainMappings::Client.new do |config|
            #       config.timeout = 10.0
            #       config.rpcs.list_domain_mappings.timeout = 20.0
            #     end
            #
            # @!attribute [rw] endpoint
            #   The hostname or hostname:port of the service endpoint.
            #   Defaults to `"appengine.googleapis.com"`.
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

              config_attr :endpoint,      "appengine.googleapis.com", ::String
              config_attr :credentials,   nil do |value|
                allowed = [::String, ::Hash, ::Proc, ::Symbol, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
                allowed += [::GRPC::Core::Channel, ::GRPC::Core::ChannelCredentials] if defined? ::GRPC
                allowed.any? { |klass| klass === value }
              end
              config_attr :scope,         nil, ::String, ::Array, nil
              config_attr :lib_name,      nil, ::String, nil
              config_attr :lib_version,   nil, ::String, nil
              config_attr(:channel_args,  { "grpc.service_config_disable_resolution" => 1 }, ::Hash, nil)
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
                  parent_rpcs = @parent_config.rpcs if defined?(@parent_config) && @parent_config.respond_to?(:rpcs)
                  Rpcs.new parent_rpcs
                end
              end

              ##
              # Configuration RPC class for the DomainMappings API.
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
                # RPC-specific configuration for `list_domain_mappings`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :list_domain_mappings
                ##
                # RPC-specific configuration for `get_domain_mapping`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :get_domain_mapping
                ##
                # RPC-specific configuration for `create_domain_mapping`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :create_domain_mapping
                ##
                # RPC-specific configuration for `update_domain_mapping`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :update_domain_mapping
                ##
                # RPC-specific configuration for `delete_domain_mapping`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :delete_domain_mapping

                # @private
                def initialize parent_rpcs = nil
                  list_domain_mappings_config = parent_rpcs.list_domain_mappings if parent_rpcs.respond_to? :list_domain_mappings
                  @list_domain_mappings = ::Gapic::Config::Method.new list_domain_mappings_config
                  get_domain_mapping_config = parent_rpcs.get_domain_mapping if parent_rpcs.respond_to? :get_domain_mapping
                  @get_domain_mapping = ::Gapic::Config::Method.new get_domain_mapping_config
                  create_domain_mapping_config = parent_rpcs.create_domain_mapping if parent_rpcs.respond_to? :create_domain_mapping
                  @create_domain_mapping = ::Gapic::Config::Method.new create_domain_mapping_config
                  update_domain_mapping_config = parent_rpcs.update_domain_mapping if parent_rpcs.respond_to? :update_domain_mapping
                  @update_domain_mapping = ::Gapic::Config::Method.new update_domain_mapping_config
                  delete_domain_mapping_config = parent_rpcs.delete_domain_mapping if parent_rpcs.respond_to? :delete_domain_mapping
                  @delete_domain_mapping = ::Gapic::Config::Method.new delete_domain_mapping_config

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
