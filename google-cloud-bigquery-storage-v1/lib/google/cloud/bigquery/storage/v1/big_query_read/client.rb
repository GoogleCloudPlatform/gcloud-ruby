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
require "google/cloud/bigquery/storage/v1/storage_pb"

module Google
  module Cloud
    module Bigquery
      module Storage
        module V1
          module BigQueryRead
            ##
            # Client for the BigQueryRead service.
            #
            # BigQuery Read API.
            #
            # The Read API can be used to read data from BigQuery.
            #
            class Client
              include Paths

              # @private
              attr_reader :big_query_read_stub

              ##
              # Configure the BigQueryRead Client class.
              #
              # See {Google::Cloud::Bigquery::Storage::V1::BigQueryRead::Client::Configuration}
              # for a description of the configuration fields.
              #
              # ## Example
              #
              # To modify the configuration for all BigQueryRead clients:
              #
              #     Google::Cloud::Bigquery::Storage::V1::BigQueryRead::Client.configure do |config|
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
                  namespace = ["Google", "Cloud", "Bigquery", "Storage", "V1"]
                  parent_config = while namespace.any?
                                    parent_name = namespace.join "::"
                                    parent_const = const_get parent_name
                                    break parent_const.configure if parent_const&.respond_to? :configure
                                    namespace.pop
                                  end
                  default_config = Client::Configuration.new parent_config

                  default_config.rpcs.create_read_session.timeout = 600.0
                  default_config.rpcs.create_read_session.retry_policy = {
                    initial_delay: 0.1,
                    max_delay:     60.0,
                    multiplier:    1.3,
                    retry_codes:   ["DEADLINE_EXCEEDED", "UNAVAILABLE"]
                  }

                  default_config.rpcs.read_rows.timeout = 86_400.0
                  default_config.rpcs.read_rows.retry_policy = {
                    initial_delay: 0.1,
                    max_delay:     60.0,
                    multiplier:    1.3,
                    retry_codes:   ["UNAVAILABLE"]
                  }

                  default_config.rpcs.split_read_stream.timeout = 600.0
                  default_config.rpcs.split_read_stream.retry_policy = {
                    initial_delay: 0.1,
                    max_delay:     60.0,
                    multiplier:    1.3,
                    retry_codes:   ["DEADLINE_EXCEEDED", "UNAVAILABLE"]
                  }

                  default_config
                end
                yield @configure if block_given?
                @configure
              end

              ##
              # Configure the BigQueryRead Client instance.
              #
              # The configuration is set to the derived mode, meaning that values can be changed,
              # but structural changes (adding new fields, etc.) are not allowed. Structural changes
              # should be made on {Client.configure}.
              #
              # See {Google::Cloud::Bigquery::Storage::V1::BigQueryRead::Client::Configuration}
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
              # Create a new BigQueryRead client object.
              #
              # ## Examples
              #
              # To create a new BigQueryRead client with the default
              # configuration:
              #
              #     client = Google::Cloud::Bigquery::Storage::V1::BigQueryRead::Client.new
              #
              # To create a new BigQueryRead client with a custom
              # configuration:
              #
              #     client = Google::Cloud::Bigquery::Storage::V1::BigQueryRead::Client.new do |config|
              #       config.timeout = 10_000
              #     end
              #
              # @yield [config] Configure the BigQueryRead client.
              # @yieldparam config [Client::Configuration]
              #
              def initialize
                # These require statements are intentionally placed here to initialize
                # the gRPC module only when it's required.
                # See https://github.com/googleapis/toolkit/issues/446
                require "gapic/grpc"
                require "google/cloud/bigquery/storage/v1/storage_services_pb"

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

                @big_query_read_stub = Gapic::ServiceStub.new(
                  Google::Cloud::Bigquery::Storage::V1::BigQueryRead::Stub,
                  credentials:  credentials,
                  endpoint:     @config.endpoint,
                  channel_args: @config.channel_args,
                  interceptors: @config.interceptors
                )
              end

              # Service calls

              ##
              # Creates a new read session. A read session divides the contents of a
              # BigQuery table into one or more streams, which can then be used to read
              # data from the table. The read session also specifies properties of the
              # data to be read, such as a list of columns or a push-down filter describing
              # the rows to be returned.
              #
              # A particular row can be read by at most one stream. When the caller has
              # reached the end of each stream in the session, then all the data in the
              # table has been read.
              #
              # Data is assigned to each stream such that roughly the same number of
              # rows can be read from each stream. Because the server-side unit for
              # assigning data is collections of rows, the API does not guarantee that
              # each stream will return the same number or rows. Additionally, the
              # limits are enforced based on the number of pre-filtered rows, so some
              # filters can lead to lopsided assignments.
              #
              # Read sessions automatically expire 24 hours after they are created and do
              # not require manual clean-up by the caller.
              #
              # @overload create_read_session(request, options = nil)
              #   Pass arguments to `create_read_session` via a request object, either of type
              #   {Google::Cloud::Bigquery::Storage::V1::CreateReadSessionRequest} or an equivalent Hash.
              #
              #   @param request [Google::Cloud::Bigquery::Storage::V1::CreateReadSessionRequest, Hash]
              #     A request object representing the call parameters. Required. To specify no
              #     parameters, or to keep all the default parameter values, pass an empty Hash.
              #   @param options [Gapic::CallOptions, Hash]
              #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
              #
              # @overload create_read_session(parent: nil, read_session: nil, max_stream_count: nil)
              #   Pass arguments to `create_read_session` via keyword arguments. Note that at
              #   least one keyword argument is required. To specify no parameters, or to keep all
              #   the default parameter values, pass an empty Hash as a request object (see above).
              #
              #   @param parent [String]
              #     Required. The request project that owns the session, in the form of
              #     `projects/{project_id}`.
              #   @param read_session [Google::Cloud::Bigquery::Storage::V1::ReadSession, Hash]
              #     Required. Session to be created.
              #   @param max_stream_count [Integer]
              #     Max initial number of streams. If unset or zero, the server will
              #     provide a value of streams so as to produce reasonable throughput. Must be
              #     non-negative. The number of streams may be lower than the requested number,
              #     depending on the amount parallelism that is reasonable for the table. Error
              #     will be returned if the max count is greater than the current system
              #     max limit of 1,000.
              #
              #     Streams must be read starting from offset 0.
              #
              # @yield [response, operation] Access the result along with the RPC operation
              # @yieldparam response [Google::Cloud::Bigquery::Storage::V1::ReadSession]
              # @yieldparam operation [GRPC::ActiveCall::Operation]
              #
              # @return [Google::Cloud::Bigquery::Storage::V1::ReadSession]
              #
              # @raise [Google::Cloud::Error] if the RPC is aborted.
              #
              def create_read_session request, options = nil
                raise ArgumentError, "request must be provided" if request.nil?

                request = Gapic::Protobuf.coerce request, to: Google::Cloud::Bigquery::Storage::V1::CreateReadSessionRequest

                # Converts hash and nil to an options object
                options = Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

                # Customize the options with defaults
                metadata = @config.rpcs.create_read_session.metadata.to_h

                # Set x-goog-api-client and x-goog-user-project headers
                metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                  lib_name: @config.lib_name, lib_version: @config.lib_version,
                  gapic_version: ::Google::Cloud::Bigquery::Storage::V1::VERSION
                metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

                header_params = {
                  "read_session.table" => request.read_session.table
                }
                request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
                metadata[:"x-goog-request-params"] ||= request_params_header

                options.apply_defaults timeout:      @config.rpcs.create_read_session.timeout,
                                       metadata:     metadata,
                                       retry_policy: @config.rpcs.create_read_session.retry_policy
                options.apply_defaults metadata:     @config.metadata,
                                       retry_policy: @config.retry_policy

                @big_query_read_stub.call_rpc :create_read_session, request, options: options do |response, operation|
                  yield response, operation if block_given?
                  return response
                end
              rescue GRPC::BadStatus => e
                raise Google::Cloud::Error.from_error(e)
              end

              ##
              # Reads rows from the stream in the format prescribed by the ReadSession.
              # Each response contains one or more table rows, up to a maximum of 100 MiB
              # per response; read requests which attempt to read individual rows larger
              # than 100 MiB will fail.
              #
              # Each request also returns a set of stream statistics reflecting the current
              # state of the stream.
              #
              # @overload read_rows(request, options = nil)
              #   Pass arguments to `read_rows` via a request object, either of type
              #   {Google::Cloud::Bigquery::Storage::V1::ReadRowsRequest} or an equivalent Hash.
              #
              #   @param request [Google::Cloud::Bigquery::Storage::V1::ReadRowsRequest, Hash]
              #     A request object representing the call parameters. Required. To specify no
              #     parameters, or to keep all the default parameter values, pass an empty Hash.
              #   @param options [Gapic::CallOptions, Hash]
              #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
              #
              # @overload read_rows(read_stream: nil, offset: nil)
              #   Pass arguments to `read_rows` via keyword arguments. Note that at
              #   least one keyword argument is required. To specify no parameters, or to keep all
              #   the default parameter values, pass an empty Hash as a request object (see above).
              #
              #   @param read_stream [String]
              #     Required. Stream to read rows from.
              #   @param offset [Integer]
              #     The offset requested must be less than the last row read from Read.
              #     Requesting a larger offset is undefined. If not specified, start reading
              #     from offset zero.
              #
              # @yield [response, operation] Access the result along with the RPC operation
              # @yieldparam response [Enumerable<Google::Cloud::Bigquery::Storage::V1::ReadRowsResponse>]
              # @yieldparam operation [GRPC::ActiveCall::Operation]
              #
              # @return [Enumerable<Google::Cloud::Bigquery::Storage::V1::ReadRowsResponse>]
              #
              # @raise [Google::Cloud::Error] if the RPC is aborted.
              #
              def read_rows request, options = nil
                raise ArgumentError, "request must be provided" if request.nil?

                request = Gapic::Protobuf.coerce request, to: Google::Cloud::Bigquery::Storage::V1::ReadRowsRequest

                # Converts hash and nil to an options object
                options = Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

                # Customize the options with defaults
                metadata = @config.rpcs.read_rows.metadata.to_h

                # Set x-goog-api-client and x-goog-user-project headers
                metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                  lib_name: @config.lib_name, lib_version: @config.lib_version,
                  gapic_version: ::Google::Cloud::Bigquery::Storage::V1::VERSION
                metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

                header_params = {
                  "read_stream" => request.read_stream
                }
                request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
                metadata[:"x-goog-request-params"] ||= request_params_header

                options.apply_defaults timeout:      @config.rpcs.read_rows.timeout,
                                       metadata:     metadata,
                                       retry_policy: @config.rpcs.read_rows.retry_policy
                options.apply_defaults metadata:     @config.metadata,
                                       retry_policy: @config.retry_policy

                @big_query_read_stub.call_rpc :read_rows, request, options: options do |response, operation|
                  yield response, operation if block_given?
                  return response
                end
              rescue GRPC::BadStatus => e
                raise Google::Cloud::Error.from_error(e)
              end

              ##
              # Splits a given `ReadStream` into two `ReadStream` objects. These
              # `ReadStream` objects are referred to as the primary and the residual
              # streams of the split. The original `ReadStream` can still be read from in
              # the same manner as before. Both of the returned `ReadStream` objects can
              # also be read from, and the rows returned by both child streams will be
              # the same as the rows read from the original stream.
              #
              # Moreover, the two child streams will be allocated back-to-back in the
              # original `ReadStream`. Concretely, it is guaranteed that for streams
              # original, primary, and residual, that original[0-j] = primary[0-j] and
              # original[j-n] = residual[0-m] once the streams have been read to
              # completion.
              #
              # @overload split_read_stream(request, options = nil)
              #   Pass arguments to `split_read_stream` via a request object, either of type
              #   {Google::Cloud::Bigquery::Storage::V1::SplitReadStreamRequest} or an equivalent Hash.
              #
              #   @param request [Google::Cloud::Bigquery::Storage::V1::SplitReadStreamRequest, Hash]
              #     A request object representing the call parameters. Required. To specify no
              #     parameters, or to keep all the default parameter values, pass an empty Hash.
              #   @param options [Gapic::CallOptions, Hash]
              #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
              #
              # @overload split_read_stream(name: nil, fraction: nil)
              #   Pass arguments to `split_read_stream` via keyword arguments. Note that at
              #   least one keyword argument is required. To specify no parameters, or to keep all
              #   the default parameter values, pass an empty Hash as a request object (see above).
              #
              #   @param name [String]
              #     Required. Name of the stream to split.
              #   @param fraction [Float]
              #     A value in the range (0.0, 1.0) that specifies the fractional point at
              #     which the original stream should be split. The actual split point is
              #     evaluated on pre-filtered rows, so if a filter is provided, then there is
              #     no guarantee that the division of the rows between the new child streams
              #     will be proportional to this fractional value. Additionally, because the
              #     server-side unit for assigning data is collections of rows, this fraction
              #     will always map to a data storage boundary on the server side.
              #
              # @yield [response, operation] Access the result along with the RPC operation
              # @yieldparam response [Google::Cloud::Bigquery::Storage::V1::SplitReadStreamResponse]
              # @yieldparam operation [GRPC::ActiveCall::Operation]
              #
              # @return [Google::Cloud::Bigquery::Storage::V1::SplitReadStreamResponse]
              #
              # @raise [Google::Cloud::Error] if the RPC is aborted.
              #
              def split_read_stream request, options = nil
                raise ArgumentError, "request must be provided" if request.nil?

                request = Gapic::Protobuf.coerce request, to: Google::Cloud::Bigquery::Storage::V1::SplitReadStreamRequest

                # Converts hash and nil to an options object
                options = Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

                # Customize the options with defaults
                metadata = @config.rpcs.split_read_stream.metadata.to_h

                # Set x-goog-api-client and x-goog-user-project headers
                metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                  lib_name: @config.lib_name, lib_version: @config.lib_version,
                  gapic_version: ::Google::Cloud::Bigquery::Storage::V1::VERSION
                metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

                header_params = {
                  "name" => request.name
                }
                request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
                metadata[:"x-goog-request-params"] ||= request_params_header

                options.apply_defaults timeout:      @config.rpcs.split_read_stream.timeout,
                                       metadata:     metadata,
                                       retry_policy: @config.rpcs.split_read_stream.retry_policy
                options.apply_defaults metadata:     @config.metadata,
                                       retry_policy: @config.retry_policy

                @big_query_read_stub.call_rpc :split_read_stream, request, options: options do |response, operation|
                  yield response, operation if block_given?
                  return response
                end
              rescue GRPC::BadStatus => e
                raise Google::Cloud::Error.from_error(e)
              end

              ##
              # Configuration class for the BigQueryRead API.
              #
              # This class represents the configuration for BigQueryRead,
              # providing control over timeouts, retry behavior, logging, transport
              # parameters, and other low-level controls. Certain parameters can also be
              # applied individually to specific RPCs. See
              # {Google::Cloud::Bigquery::Storage::V1::BigQueryRead::Client::Configuration::Rpcs}
              # for a list of RPCs that can be configured independently.
              #
              # Configuration can be applied globally to all clients, or to a single client
              # on construction.
              #
              # # Examples
              #
              # To modify the global config, setting the timeout for create_read_session
              # to 20 seconds, and all remaining timeouts to 10 seconds:
              #
              #     Google::Cloud::Bigquery::Storage::V1::BigQueryRead::Client.configure do |config|
              #       config.timeout = 10_000
              #       config.rpcs.create_read_session.timeout = 20_000
              #     end
              #
              # To apply the above configuration only to a new client:
              #
              #     client = Google::Cloud::Bigquery::Storage::V1::BigQueryRead::Client.new do |config|
              #       config.timeout = 10_000
              #       config.rpcs.create_read_session.timeout = 20_000
              #     end
              #
              # @!attribute [rw] endpoint
              #   The hostname or hostname:port of the service endpoint.
              #   Defaults to `"bigquerystorage.googleapis.com"`.
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

                config_attr :endpoint,     "bigquerystorage.googleapis.com", String
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
                # Configuration RPC class for the BigQueryRead API.
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
                  # RPC-specific configuration for `create_read_session`
                  # @return [Gapic::Config::Method]
                  #
                  attr_reader :create_read_session
                  ##
                  # RPC-specific configuration for `read_rows`
                  # @return [Gapic::Config::Method]
                  #
                  attr_reader :read_rows
                  ##
                  # RPC-specific configuration for `split_read_stream`
                  # @return [Gapic::Config::Method]
                  #
                  attr_reader :split_read_stream

                  # @private
                  def initialize parent_rpcs = nil
                    create_read_session_config = parent_rpcs&.create_read_session if parent_rpcs&.respond_to? :create_read_session
                    @create_read_session = Gapic::Config::Method.new create_read_session_config
                    read_rows_config = parent_rpcs&.read_rows if parent_rpcs&.respond_to? :read_rows
                    @read_rows = Gapic::Config::Method.new read_rows_config
                    split_read_stream_config = parent_rpcs&.split_read_stream if parent_rpcs&.respond_to? :split_read_stream
                    @split_read_stream = Gapic::Config::Method.new split_read_stream_config

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
end
