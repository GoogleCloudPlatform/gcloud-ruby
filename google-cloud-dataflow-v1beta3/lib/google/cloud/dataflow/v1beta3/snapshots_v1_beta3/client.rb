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
require "google/dataflow/v1beta3/snapshots_pb"

module Google
  module Cloud
    module Dataflow
      module V1beta3
        module SnapshotsV1Beta3
          ##
          # Client for the SnapshotsV1Beta3 service.
          #
          # Provides methods to manage snapshots of Google Cloud Dataflow jobs.
          #
          class Client
            # @private
            attr_reader :snapshots_v1_beta3_stub

            ##
            # Configure the SnapshotsV1Beta3 Client class.
            #
            # See {::Google::Cloud::Dataflow::V1beta3::SnapshotsV1Beta3::Client::Configuration}
            # for a description of the configuration fields.
            #
            # ## Example
            #
            # To modify the configuration for all SnapshotsV1Beta3 clients:
            #
            #     ::Google::Cloud::Dataflow::V1beta3::SnapshotsV1Beta3::Client.configure do |config|
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
                namespace = ["Google", "Cloud", "Dataflow", "V1beta3"]
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
            # Configure the SnapshotsV1Beta3 Client instance.
            #
            # The configuration is set to the derived mode, meaning that values can be changed,
            # but structural changes (adding new fields, etc.) are not allowed. Structural changes
            # should be made on {Client.configure}.
            #
            # See {::Google::Cloud::Dataflow::V1beta3::SnapshotsV1Beta3::Client::Configuration}
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
            # Create a new SnapshotsV1Beta3 client object.
            #
            # ## Examples
            #
            # To create a new SnapshotsV1Beta3 client with the default
            # configuration:
            #
            #     client = ::Google::Cloud::Dataflow::V1beta3::SnapshotsV1Beta3::Client.new
            #
            # To create a new SnapshotsV1Beta3 client with a custom
            # configuration:
            #
            #     client = ::Google::Cloud::Dataflow::V1beta3::SnapshotsV1Beta3::Client.new do |config|
            #       config.timeout = 10.0
            #     end
            #
            # @yield [config] Configure the SnapshotsV1Beta3 client.
            # @yieldparam config [Client::Configuration]
            #
            def initialize
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "gapic/grpc"
              require "google/dataflow/v1beta3/snapshots_services_pb"

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

              @snapshots_v1_beta3_stub = ::Gapic::ServiceStub.new(
                ::Google::Cloud::Dataflow::V1beta3::SnapshotsV1Beta3::Stub,
                credentials:  credentials,
                endpoint:     @config.endpoint,
                channel_args: @config.channel_args,
                interceptors: @config.interceptors
              )
            end

            # Service calls

            ##
            # Gets information about a snapshot.
            #
            # @overload get_snapshot(request, options = nil)
            #   Pass arguments to `get_snapshot` via a request object, either of type
            #   {::Google::Cloud::Dataflow::V1beta3::GetSnapshotRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Dataflow::V1beta3::GetSnapshotRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload get_snapshot(project_id: nil, snapshot_id: nil, location: nil)
            #   Pass arguments to `get_snapshot` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param project_id [::String]
            #     The ID of the Cloud Platform project that the snapshot belongs to.
            #   @param snapshot_id [::String]
            #     The ID of the snapshot.
            #   @param location [::String]
            #     The location that contains this snapshot.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Dataflow::V1beta3::Snapshot]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Dataflow::V1beta3::Snapshot]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def get_snapshot request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Dataflow::V1beta3::GetSnapshotRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.get_snapshot.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Dataflow::V1beta3::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.get_snapshot.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.get_snapshot.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @snapshots_v1_beta3_stub.call_rpc :get_snapshot, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Deletes a snapshot.
            #
            # @overload delete_snapshot(request, options = nil)
            #   Pass arguments to `delete_snapshot` via a request object, either of type
            #   {::Google::Cloud::Dataflow::V1beta3::DeleteSnapshotRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Dataflow::V1beta3::DeleteSnapshotRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload delete_snapshot(project_id: nil, snapshot_id: nil, location: nil)
            #   Pass arguments to `delete_snapshot` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param project_id [::String]
            #     The ID of the Cloud Platform project that the snapshot belongs to.
            #   @param snapshot_id [::String]
            #     The ID of the snapshot.
            #   @param location [::String]
            #     The location that contains this snapshot.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Dataflow::V1beta3::DeleteSnapshotResponse]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Dataflow::V1beta3::DeleteSnapshotResponse]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def delete_snapshot request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Dataflow::V1beta3::DeleteSnapshotRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.delete_snapshot.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Dataflow::V1beta3::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.delete_snapshot.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.delete_snapshot.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @snapshots_v1_beta3_stub.call_rpc :delete_snapshot, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Lists snapshots.
            #
            # @overload list_snapshots(request, options = nil)
            #   Pass arguments to `list_snapshots` via a request object, either of type
            #   {::Google::Cloud::Dataflow::V1beta3::ListSnapshotsRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Dataflow::V1beta3::ListSnapshotsRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload list_snapshots(project_id: nil, job_id: nil, location: nil)
            #   Pass arguments to `list_snapshots` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param project_id [::String]
            #     The project ID to list snapshots for.
            #   @param job_id [::String]
            #     If specified, list snapshots created from this job.
            #   @param location [::String]
            #     The location to list snapshots in.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Dataflow::V1beta3::ListSnapshotsResponse]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Dataflow::V1beta3::ListSnapshotsResponse]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def list_snapshots request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Dataflow::V1beta3::ListSnapshotsRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.list_snapshots.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Dataflow::V1beta3::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.list_snapshots.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.list_snapshots.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @snapshots_v1_beta3_stub.call_rpc :list_snapshots, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Configuration class for the SnapshotsV1Beta3 API.
            #
            # This class represents the configuration for SnapshotsV1Beta3,
            # providing control over timeouts, retry behavior, logging, transport
            # parameters, and other low-level controls. Certain parameters can also be
            # applied individually to specific RPCs. See
            # {::Google::Cloud::Dataflow::V1beta3::SnapshotsV1Beta3::Client::Configuration::Rpcs}
            # for a list of RPCs that can be configured independently.
            #
            # Configuration can be applied globally to all clients, or to a single client
            # on construction.
            #
            # # Examples
            #
            # To modify the global config, setting the timeout for get_snapshot
            # to 20 seconds, and all remaining timeouts to 10 seconds:
            #
            #     ::Google::Cloud::Dataflow::V1beta3::SnapshotsV1Beta3::Client.configure do |config|
            #       config.timeout = 10.0
            #       config.rpcs.get_snapshot.timeout = 20.0
            #     end
            #
            # To apply the above configuration only to a new client:
            #
            #     client = ::Google::Cloud::Dataflow::V1beta3::SnapshotsV1Beta3::Client.new do |config|
            #       config.timeout = 10.0
            #       config.rpcs.get_snapshot.timeout = 20.0
            #     end
            #
            # @!attribute [rw] endpoint
            #   The hostname or hostname:port of the service endpoint.
            #   Defaults to `"dataflow.googleapis.com"`.
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

              config_attr :endpoint,      "dataflow.googleapis.com", ::String
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
              # Configuration RPC class for the SnapshotsV1Beta3 API.
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
                # RPC-specific configuration for `get_snapshot`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :get_snapshot
                ##
                # RPC-specific configuration for `delete_snapshot`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :delete_snapshot
                ##
                # RPC-specific configuration for `list_snapshots`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :list_snapshots

                # @private
                def initialize parent_rpcs = nil
                  get_snapshot_config = parent_rpcs.get_snapshot if parent_rpcs.respond_to? :get_snapshot
                  @get_snapshot = ::Gapic::Config::Method.new get_snapshot_config
                  delete_snapshot_config = parent_rpcs.delete_snapshot if parent_rpcs.respond_to? :delete_snapshot
                  @delete_snapshot = ::Gapic::Config::Method.new delete_snapshot_config
                  list_snapshots_config = parent_rpcs.list_snapshots if parent_rpcs.respond_to? :list_snapshots
                  @list_snapshots = ::Gapic::Config::Method.new list_snapshots_config

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
