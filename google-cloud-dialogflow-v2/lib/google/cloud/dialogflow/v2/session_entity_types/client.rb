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

require "gapic/common"
require "gapic/config"
require "gapic/config/method"

require "google/cloud/errors"
require "google/cloud/dialogflow/v2/version"
require "google/cloud/dialogflow/v2/session_entity_type_pb"
require "google/cloud/dialogflow/v2/session_entity_types/credentials"
require "google/cloud/dialogflow/v2/session_entity_types/paths"

module Google
  module Cloud
    module Dialogflow
      module V2
        module SessionEntityTypes
          ##
          # Client for the SessionEntityTypes service.
          #
          # Entities are extracted from user input and represent parameters that are
          # meaningful to your application. For example, a date range, a proper name
          # such as a geographic location or landmark, and so on. Entities represent
          # actionable data for your application.
          #
          # Session entity types are referred to as **User** entity types and are
          # entities that are built for an individual user such as
          # favorites, preferences, playlists, and so on. You can redefine a session
          # entity type at the session level.
          #
          # Session entity methods do not work with Google Assistant integration.
          # Contact Dialogflow support if you need to use session entities
          # with Google Assistant integration.
          #
          # For more information about entity types, see the
          # [Dialogflow
          # documentation](https://cloud.google.com/dialogflow/docs/entities-overview).
          #
          class Client
            include Paths

            # @private
            attr_reader :session_entity_types_stub

            ##
            # Configure the SessionEntityTypes Client class.
            #
            # See {Google::Cloud::Dialogflow::V2::SessionEntityTypes::Client::Configuration}
            # for a description of the configuration fields.
            #
            # ## Example
            #
            # To modify the configuration for all SessionEntityTypes clients:
            #
            #     Google::Cloud::Dialogflow::V2::SessionEntityTypes::Client.configure do |config|
            #       config.timeout = 10_000
            #     end
            #
            # @yield [config] Configure the Client client.
            # @yieldparam config [Client::Configuration]
            #
            # @return [Client::Configuration]
            #
            def self.configure
              @configure ||= begin
                namespace = ["Google", "Cloud", "Dialogflow", "V2"]
                parent_config = while namespace.any?
                                  parent_name = namespace.join "::"
                                  parent_const = const_get parent_name
                                  break parent_const.configure if parent_const&.respond_to? :configure
                                  namespace.pop
                                end
                default_config = Client::Configuration.new parent_config

                default_config.rpcs.list_session_entity_types.timeout = 60.0
                default_config.rpcs.list_session_entity_types.retry_policy = {
                  initial_delay: 0.1,
                  max_delay:     60.0,
                  multiplier:    1.3,
                  retry_codes:   ["UNAVAILABLE", "DEADLINE_EXCEEDED"]
                }

                default_config.rpcs.get_session_entity_type.timeout = 60.0
                default_config.rpcs.get_session_entity_type.retry_policy = {
                  initial_delay: 0.1,
                  max_delay:     60.0,
                  multiplier:    1.3,
                  retry_codes:   ["UNAVAILABLE", "DEADLINE_EXCEEDED"]
                }

                default_config.rpcs.create_session_entity_type.timeout = 60.0

                default_config.rpcs.update_session_entity_type.timeout = 60.0

                default_config.rpcs.delete_session_entity_type.timeout = 60.0
                default_config.rpcs.delete_session_entity_type.retry_policy = {
                  initial_delay: 0.1,
                  max_delay:     60.0,
                  multiplier:    1.3,
                  retry_codes:   ["UNAVAILABLE", "DEADLINE_EXCEEDED"]
                }

                default_config
              end
              yield @configure if block_given?
              @configure
            end

            ##
            # Configure the SessionEntityTypes Client instance.
            #
            # The configuration is set to the derived mode, meaning that values can be changed,
            # but structural changes (adding new fields, etc.) are not allowed. Structural changes
            # should be made on {Client.configure}.
            #
            # See {Google::Cloud::Dialogflow::V2::SessionEntityTypes::Client::Configuration}
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
            # Create a new SessionEntityTypes client object.
            #
            # ## Examples
            #
            # To create a new SessionEntityTypes client with the default
            # configuration:
            #
            #     client = Google::Cloud::Dialogflow::V2::SessionEntityTypes::Client.new
            #
            # To create a new SessionEntityTypes client with a custom
            # configuration:
            #
            #     client = Google::Cloud::Dialogflow::V2::SessionEntityTypes::Client.new do |config|
            #       config.timeout = 10_000
            #     end
            #
            # @yield [config] Configure the SessionEntityTypes client.
            # @yieldparam config [Client::Configuration]
            #
            def initialize
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "gapic/grpc"
              require "google/cloud/dialogflow/v2/session_entity_type_services_pb"

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
              @quota_project_id = credentials.respond_to?(:quota_project_id) ? credentials.quota_project_id : nil

              @session_entity_types_stub = Gapic::ServiceStub.new(
                Google::Cloud::Dialogflow::V2::SessionEntityTypes::Stub,
                credentials:  credentials,
                endpoint:     @config.endpoint,
                channel_args: @config.channel_args,
                interceptors: @config.interceptors
              )
            end

            # Service calls

            ##
            # Returns the list of all session entity types in the specified session.
            #
            # This method doesn't work with Google Assistant integration.
            # Contact Dialogflow support if you need to use session entities
            # with Google Assistant integration.
            #
            # @overload list_session_entity_types(request, options = nil)
            #   @param request [Google::Cloud::Dialogflow::V2::ListSessionEntityTypesRequest | Hash]
            #     Returns the list of all session entity types in the specified session.
            #
            #     This method doesn't work with Google Assistant integration.
            #     Contact Dialogflow support if you need to use session entities
            #     with Google Assistant integration.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload list_session_entity_types(parent: nil, page_size: nil, page_token: nil)
            #   @param parent [String]
            #     Required. The session to list all session entity types from.
            #     Format: `projects/<Project ID>/agent/sessions/<Session ID>` or
            #     `projects/<Project ID>/agent/environments/<Environment ID>/users/<User ID>/
            #     sessions/<Session ID>`.
            #     If `Environment ID` is not specified, we assume default 'draft'
            #     environment. If `User ID` is not specified, we assume default '-' user.
            #   @param page_size [Integer]
            #     Optional. The maximum number of items to return in a single page. By
            #     default 100 and at most 1000.
            #   @param page_token [String]
            #     Optional. The next_page_token value returned from a previous list request.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Gapic::PagedEnumerable<Google::Cloud::Dialogflow::V2::SessionEntityType>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Gapic::PagedEnumerable<Google::Cloud::Dialogflow::V2::SessionEntityType>]
            #
            # @raise [Google::Cloud::Error] if the RPC is aborted.
            #
            def list_session_entity_types request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Dialogflow::V2::ListSessionEntityTypesRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.list_session_entity_types.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Dialogflow::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.list_session_entity_types.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.list_session_entity_types.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @session_entity_types_stub.call_rpc :list_session_entity_types, request, options: options do |response, operation|
                response = Gapic::PagedEnumerable.new @session_entity_types_stub, :list_session_entity_types, request, response, operation, options
                yield response, operation if block_given?
                return response
              end
            rescue GRPC::BadStatus => e
              raise Google::Cloud::Error.from_error(e)
            end

            ##
            # Retrieves the specified session entity type.
            #
            # This method doesn't work with Google Assistant integration.
            # Contact Dialogflow support if you need to use session entities
            # with Google Assistant integration.
            #
            # @overload get_session_entity_type(request, options = nil)
            #   @param request [Google::Cloud::Dialogflow::V2::GetSessionEntityTypeRequest | Hash]
            #     Retrieves the specified session entity type.
            #
            #     This method doesn't work with Google Assistant integration.
            #     Contact Dialogflow support if you need to use session entities
            #     with Google Assistant integration.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload get_session_entity_type(name: nil)
            #   @param name [String]
            #     Required. The name of the session entity type. Format:
            #     `projects/<Project ID>/agent/sessions/<Session ID>/entityTypes/<Entity Type
            #     Display Name>` or `projects/<Project ID>/agent/environments/<Environment
            #     ID>/users/<User ID>/sessions/<Session ID>/entityTypes/<Entity Type Display
            #     Name>`.
            #     If `Environment ID` is not specified, we assume default 'draft'
            #     environment. If `User ID` is not specified, we assume default '-' user.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Dialogflow::V2::SessionEntityType]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Dialogflow::V2::SessionEntityType]
            #
            # @raise [Google::Cloud::Error] if the RPC is aborted.
            #
            def get_session_entity_type request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Dialogflow::V2::GetSessionEntityTypeRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.get_session_entity_type.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Dialogflow::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.get_session_entity_type.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.get_session_entity_type.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @session_entity_types_stub.call_rpc :get_session_entity_type, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue GRPC::BadStatus => e
              raise Google::Cloud::Error.from_error(e)
            end

            ##
            # Creates a session entity type.
            #
            # If the specified session entity type already exists, overrides the session
            # entity type.
            #
            # This method doesn't work with Google Assistant integration.
            # Contact Dialogflow support if you need to use session entities
            # with Google Assistant integration.
            #
            # @overload create_session_entity_type(request, options = nil)
            #   @param request [Google::Cloud::Dialogflow::V2::CreateSessionEntityTypeRequest | Hash]
            #     Creates a session entity type.
            #
            #     If the specified session entity type already exists, overrides the session
            #     entity type.
            #
            #     This method doesn't work with Google Assistant integration.
            #     Contact Dialogflow support if you need to use session entities
            #     with Google Assistant integration.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload create_session_entity_type(parent: nil, session_entity_type: nil)
            #   @param parent [String]
            #     Required. The session to create a session entity type for.
            #     Format: `projects/<Project ID>/agent/sessions/<Session ID>` or
            #     `projects/<Project ID>/agent/environments/<Environment ID>/users/<User ID>/
            #     sessions/<Session ID>`.
            #     If `Environment ID` is not specified, we assume default 'draft'
            #     environment. If `User ID` is not specified, we assume default '-' user.
            #   @param session_entity_type [Google::Cloud::Dialogflow::V2::SessionEntityType | Hash]
            #     Required. The session entity type to create.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Dialogflow::V2::SessionEntityType]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Dialogflow::V2::SessionEntityType]
            #
            # @raise [Google::Cloud::Error] if the RPC is aborted.
            #
            def create_session_entity_type request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Dialogflow::V2::CreateSessionEntityTypeRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.create_session_entity_type.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Dialogflow::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.create_session_entity_type.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.create_session_entity_type.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @session_entity_types_stub.call_rpc :create_session_entity_type, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue GRPC::BadStatus => e
              raise Google::Cloud::Error.from_error(e)
            end

            ##
            # Updates the specified session entity type.
            #
            # This method doesn't work with Google Assistant integration.
            # Contact Dialogflow support if you need to use session entities
            # with Google Assistant integration.
            #
            # @overload update_session_entity_type(request, options = nil)
            #   @param request [Google::Cloud::Dialogflow::V2::UpdateSessionEntityTypeRequest | Hash]
            #     Updates the specified session entity type.
            #
            #     This method doesn't work with Google Assistant integration.
            #     Contact Dialogflow support if you need to use session entities
            #     with Google Assistant integration.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload update_session_entity_type(session_entity_type: nil, update_mask: nil)
            #   @param session_entity_type [Google::Cloud::Dialogflow::V2::SessionEntityType | Hash]
            #     Required. The session entity type to update.
            #   @param update_mask [Google::Protobuf::FieldMask | Hash]
            #     Optional. The mask to control which fields get updated.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Dialogflow::V2::SessionEntityType]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Dialogflow::V2::SessionEntityType]
            #
            # @raise [Google::Cloud::Error] if the RPC is aborted.
            #
            def update_session_entity_type request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Dialogflow::V2::UpdateSessionEntityTypeRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.update_session_entity_type.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Dialogflow::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "session_entity_type.name" => request.session_entity_type.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.update_session_entity_type.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.update_session_entity_type.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @session_entity_types_stub.call_rpc :update_session_entity_type, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue GRPC::BadStatus => e
              raise Google::Cloud::Error.from_error(e)
            end

            ##
            # Deletes the specified session entity type.
            #
            # This method doesn't work with Google Assistant integration.
            # Contact Dialogflow support if you need to use session entities
            # with Google Assistant integration.
            #
            # @overload delete_session_entity_type(request, options = nil)
            #   @param request [Google::Cloud::Dialogflow::V2::DeleteSessionEntityTypeRequest | Hash]
            #     Deletes the specified session entity type.
            #
            #     This method doesn't work with Google Assistant integration.
            #     Contact Dialogflow support if you need to use session entities
            #     with Google Assistant integration.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload delete_session_entity_type(name: nil)
            #   @param name [String]
            #     Required. The name of the entity type to delete. Format:
            #     `projects/<Project ID>/agent/sessions/<Session ID>/entityTypes/<Entity Type
            #     Display Name>` or `projects/<Project ID>/agent/environments/<Environment
            #     ID>/users/<User ID>/sessions/<Session ID>/entityTypes/<Entity Type Display
            #     Name>`.
            #     If `Environment ID` is not specified, we assume default 'draft'
            #     environment. If `User ID` is not specified, we assume default '-' user.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            #
            # @raise [Google::Cloud::Error] if the RPC is aborted.
            #
            def delete_session_entity_type request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Dialogflow::V2::DeleteSessionEntityTypeRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.delete_session_entity_type.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Dialogflow::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.delete_session_entity_type.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.delete_session_entity_type.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @session_entity_types_stub.call_rpc :delete_session_entity_type, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue GRPC::BadStatus => e
              raise Google::Cloud::Error.from_error(e)
            end

            ##
            # Configuration class for the SessionEntityTypes API.
            #
            # This class represents the configuration for SessionEntityTypes,
            # providing control over timeouts, retry behavior, logging, transport
            # parameters, and other low-level controls. Certain parameters can also be
            # applied individually to specific RPCs. See
            # {Google::Cloud::Dialogflow::V2::SessionEntityTypes::Client::Configuration::Rpcs}
            # for a list of RPCs that can be configured independently.
            #
            # Configuration can be applied globally to all clients, or to a single client
            # on construction.
            #
            # # Examples
            #
            # To modify the global config, setting the timeout for list_session_entity_types
            # to 20 seconds, and all remaining timeouts to 10 seconds:
            #
            #     Google::Cloud::Dialogflow::V2::SessionEntityTypes::Client.configure do |config|
            #       config.timeout = 10_000
            #       config.rpcs.list_session_entity_types.timeout = 20_000
            #     end
            #
            # To apply the above configuration only to a new client:
            #
            #     client = Google::Cloud::Dialogflow::V2::SessionEntityTypes::Client.new do |config|
            #       config.timeout = 10_000
            #       config.rpcs.list_session_entity_types.timeout = 20_000
            #     end
            #
            # @!attribute [rw] endpoint
            #   The hostname or hostname:port of the service endpoint.
            #   Defaults to `"dialogflow.googleapis.com"`.
            #   @return [String]
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
            #   @return [Object]
            # @!attribute [rw] scope
            #   The OAuth scopes
            #   @return [Array<String>]
            # @!attribute [rw] lib_name
            #   The library name as recorded in instrumentation and logging
            #   @return [String]
            # @!attribute [rw] lib_version
            #   The library version as recorded in instrumentation and logging
            #   @return [String]
            # @!attribute [rw] channel_args
            #   Extra parameters passed to the gRPC channel. Note: this is ignored if a
            #   `GRPC::Core::Channel` object is provided as the credential.
            #   @return [Hash]
            # @!attribute [rw] interceptors
            #   An array of interceptors that are run before calls are executed.
            #   @return [Array<GRPC::ClientInterceptor>]
            # @!attribute [rw] timeout
            #   The call timeout in milliseconds.
            #   @return [Numeric]
            # @!attribute [rw] metadata
            #   Additional gRPC headers to be sent with the call.
            #   @return [Hash{Symbol=>String}]
            # @!attribute [rw] retry_policy
            #   The retry policy. The value is a hash with the following keys:
            #    *  `:initial_delay` (*type:* `Numeric`) - The initial delay in seconds.
            #    *  `:max_delay` (*type:* `Numeric`) - The max delay in seconds.
            #    *  `:multiplier` (*type:* `Numeric`) - The incremental backoff multiplier.
            #    *  `:retry_codes` (*type:* `Array<String>`) - The error codes that should
            #       trigger a retry.
            #   @return [Hash]
            #
            class Configuration
              extend Gapic::Config

              config_attr :endpoint,     "dialogflow.googleapis.com", String
              config_attr :credentials,  nil do |value|
                allowed = [::String, ::Hash, ::Proc, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
                allowed += [::GRPC::Core::Channel, ::GRPC::Core::ChannelCredentials] if defined? ::GRPC
                allowed.any? { |klass| klass === value }
              end
              config_attr :scope,        nil, String, Array, nil
              config_attr :lib_name,     nil, String, nil
              config_attr :lib_version,  nil, String, nil
              config_attr(:channel_args, { "grpc.service_config_disable_resolution"=>1 }, Hash, nil)
              config_attr :interceptors, nil, Array, nil
              config_attr :timeout,      nil, Numeric, nil
              config_attr :metadata,     nil, Hash, nil
              config_attr :retry_policy, nil, Hash, Proc, nil

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
                  parent_rpcs = @parent_config.rpcs if @parent_config&.respond_to? :rpcs
                  Rpcs.new parent_rpcs
                end
              end

              ##
              # Configuration RPC class for the SessionEntityTypes API.
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
                # RPC-specific configuration for `list_session_entity_types`
                # @return [Gapic::Config::Method]
                #
                attr_reader :list_session_entity_types
                ##
                # RPC-specific configuration for `get_session_entity_type`
                # @return [Gapic::Config::Method]
                #
                attr_reader :get_session_entity_type
                ##
                # RPC-specific configuration for `create_session_entity_type`
                # @return [Gapic::Config::Method]
                #
                attr_reader :create_session_entity_type
                ##
                # RPC-specific configuration for `update_session_entity_type`
                # @return [Gapic::Config::Method]
                #
                attr_reader :update_session_entity_type
                ##
                # RPC-specific configuration for `delete_session_entity_type`
                # @return [Gapic::Config::Method]
                #
                attr_reader :delete_session_entity_type

                # @private
                def initialize parent_rpcs = nil
                  list_session_entity_types_config = parent_rpcs&.list_session_entity_types if parent_rpcs&.respond_to? :list_session_entity_types
                  @list_session_entity_types = Gapic::Config::Method.new list_session_entity_types_config
                  get_session_entity_type_config = parent_rpcs&.get_session_entity_type if parent_rpcs&.respond_to? :get_session_entity_type
                  @get_session_entity_type = Gapic::Config::Method.new get_session_entity_type_config
                  create_session_entity_type_config = parent_rpcs&.create_session_entity_type if parent_rpcs&.respond_to? :create_session_entity_type
                  @create_session_entity_type = Gapic::Config::Method.new create_session_entity_type_config
                  update_session_entity_type_config = parent_rpcs&.update_session_entity_type if parent_rpcs&.respond_to? :update_session_entity_type
                  @update_session_entity_type = Gapic::Config::Method.new update_session_entity_type_config
                  delete_session_entity_type_config = parent_rpcs&.delete_session_entity_type if parent_rpcs&.respond_to? :delete_session_entity_type
                  @delete_session_entity_type = Gapic::Config::Method.new delete_session_entity_type_config

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

# rubocop:disable Lint/HandleExceptions

# Once client is loaded, load helpers.rb if it exists.
begin
  require "google/cloud/dialogflow/v2/session_entity_types/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
