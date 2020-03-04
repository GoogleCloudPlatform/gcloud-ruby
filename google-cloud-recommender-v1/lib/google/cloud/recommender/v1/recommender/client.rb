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
require "google/cloud/recommender/v1/version"
require "google/cloud/recommender/v1/recommender_service_pb"
require "google/cloud/recommender/v1/recommender/credentials"
require "google/cloud/recommender/v1/recommender/paths"


module Google
  module Cloud
    module Recommender
      module V1
        module Recommender
          # Service that implements Recommender API.
          class Client
            include Paths

            # @private
            attr_reader :recommender_stub

            ##
            # Configure the Recommender Client class.
            #
            # See {Google::Cloud::Recommender::V1::Recommender::Client::Configuration}
            # for a description of the configuration fields.
            #
            # ## Example
            #
            # To modify the configuration for all Recommender clients:
            #
            #     Google::Cloud::Recommender::V1::Recommender::Client.configure do |config|
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
                namespace = ["Google", "Cloud", "Recommender", "V1"]
                parent_config = while namespace.any?
                                  parent_name = namespace.join "::"
                                  parent_const = const_get parent_name
                                  break parent_const.configure if parent_const&.respond_to? :configure
                                  namespace.pop
                                end
                Client::Configuration.new parent_config
              end
              yield @configure if block_given?
              @configure
            end

            ##
            # Configure the Recommender Client instance.
            #
            # The configuration is set to the derived mode, meaning that values can be changed,
            # but structural changes (adding new fields, etc.) are not allowed. Structural changes
            # should be made on {Client.configure}.
            #
            # See {Google::Cloud::Recommender::V1::Recommender::Client::Configuration}
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
            # Create a new Recommender client object.
            #
            # ## Examples
            #
            # To create a new Recommender client with the default
            # configuration:
            #
            #     client = Google::Cloud::Recommender::V1::Recommender::Client.new
            #
            # To create a new Recommender client with a custom
            # configuration:
            #
            #     client = Google::Cloud::Recommender::V1::Recommender::Client.new do |config|
            #       config.timeout = 10_000
            #     end
            #
            # @yield [config] Configure the Recommender client.
            # @yieldparam config [Client::Configuration]
            #
            def initialize
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "gapic/grpc"
              require "google/cloud/recommender/v1/recommender_service_services_pb"

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


              @recommender_stub = Gapic::ServiceStub.new(
                Google::Cloud::Recommender::V1::Recommender::Stub,
                credentials:  credentials,
                endpoint:     @config.endpoint,
                channel_args: @config.channel_args,
                interceptors: @config.interceptors
              )
            end

            # Service calls

            ##
            # Lists recommendations for a Cloud project. Requires the recommender.*.list
            # IAM permission for the specified recommender.
            #
            # @overload list_recommendations(request, options = nil)
            #   @param request [Google::Cloud::Recommender::V1::ListRecommendationsRequest | Hash]
            #     Lists recommendations for a Cloud project. Requires the recommender.*.list
            #     IAM permission for the specified recommender.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload list_recommendations(parent: nil, page_size: nil, page_token: nil, filter: nil)
            #   @param parent [String]
            #     Required. The container resource on which to execute the request.
            #     Acceptable formats:
            #
            #     1.
            #     "projects/[PROJECT_NUMBER]/locations/[LOCATION]/recommenders/[RECOMMENDER_ID]",
            #
            #     LOCATION here refers to GCP Locations:
            #     https://cloud.google.com/about/locations/
            #   @param page_size [Integer]
            #     Optional. The maximum number of results to return from this request.  Non-positive
            #     values are ignored. If not specified, the server will determine the number
            #     of results to return.
            #   @param page_token [String]
            #     Optional. If present, retrieves the next batch of results from the preceding call to
            #     this method. `page_token` must be the value of `next_page_token` from the
            #     previous response. The values of other method parameters must be identical
            #     to those in the previous call.
            #   @param filter [String]
            #     Filter expression to restrict the recommendations returned. Supported
            #     filter fields: state_info.state
            #     Eg: `state_info.state:"DISMISSED" or state_info.state:"FAILED"
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Gapic::PagedEnumerable<Google::Cloud::Recommender::V1::Recommendation>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Gapic::PagedEnumerable<Google::Cloud::Recommender::V1::Recommendation>]
            #
            # @raise [Google::Cloud::Error] if the RPC is aborted.
            #
            def list_recommendations request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Recommender::V1::ListRecommendationsRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.list_recommendations.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Recommender::V1::VERSION

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.list_recommendations.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.list_recommendations.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @recommender_stub.call_rpc :list_recommendations, request, options: options do |response, operation|
                response = Gapic::PagedEnumerable.new @recommender_stub, :list_recommendations, request, response, operation, options
                yield response, operation if block_given?
                return response
              end
            rescue GRPC::BadStatus => e
              raise Google::Cloud::Error.from_error(e)
            end

            ##
            # Gets the requested recommendation. Requires the recommender.*.get
            # IAM permission for the specified recommender.
            #
            # @overload get_recommendation(request, options = nil)
            #   @param request [Google::Cloud::Recommender::V1::GetRecommendationRequest | Hash]
            #     Gets the requested recommendation. Requires the recommender.*.get
            #     IAM permission for the specified recommender.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload get_recommendation(name: nil)
            #   @param name [String]
            #     Required. Name of the recommendation.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Recommender::V1::Recommendation]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Recommender::V1::Recommendation]
            #
            # @raise [Google::Cloud::Error] if the RPC is aborted.
            #
            def get_recommendation request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Recommender::V1::GetRecommendationRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.get_recommendation.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Recommender::V1::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.get_recommendation.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.get_recommendation.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @recommender_stub.call_rpc :get_recommendation, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue GRPC::BadStatus => e
              raise Google::Cloud::Error.from_error(e)
            end

            ##
            # Mark the Recommendation State as Claimed. Users can use this method to
            # indicate to the Recommender API that they are starting to apply the
            # recommendation themselves. This stops the recommendation content from being
            # updated.
            #
            # MarkRecommendationClaimed can be applied to recommendations in CLAIMED,
            # SUCCEEDED, FAILED, or ACTIVE state.
            #
            # Requires the recommender.*.update IAM permission for the specified
            # recommender.
            #
            # @overload mark_recommendation_claimed(request, options = nil)
            #   @param request [Google::Cloud::Recommender::V1::MarkRecommendationClaimedRequest | Hash]
            #     Mark the Recommendation State as Claimed. Users can use this method to
            #     indicate to the Recommender API that they are starting to apply the
            #     recommendation themselves. This stops the recommendation content from being
            #     updated.
            #
            #     MarkRecommendationClaimed can be applied to recommendations in CLAIMED,
            #     SUCCEEDED, FAILED, or ACTIVE state.
            #
            #     Requires the recommender.*.update IAM permission for the specified
            #     recommender.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload mark_recommendation_claimed(name: nil, state_metadata: nil, etag: nil)
            #   @param name [String]
            #     Required. Name of the recommendation.
            #   @param state_metadata [Hash{String => String}]
            #     State properties to include with this state. Overwrites any existing
            #     `state_metadata`.
            #     Keys must match the regex /^[a-z0-9][a-z0-9_.-]\\\{0,62\}$/.
            #     Values must match the regex /^[a-zA-Z0-9_./-]\\\{0,255\}$/.
            #   @param etag [String]
            #     Required. Fingerprint of the Recommendation. Provides optimistic locking.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Recommender::V1::Recommendation]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Recommender::V1::Recommendation]
            #
            # @raise [Google::Cloud::Error] if the RPC is aborted.
            #
            def mark_recommendation_claimed request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Recommender::V1::MarkRecommendationClaimedRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.mark_recommendation_claimed.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Recommender::V1::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.mark_recommendation_claimed.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.mark_recommendation_claimed.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @recommender_stub.call_rpc :mark_recommendation_claimed, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue GRPC::BadStatus => e
              raise Google::Cloud::Error.from_error(e)
            end

            ##
            # Mark the Recommendation State as Succeeded. Users can use this method to
            # indicate to the Recommender API that they have applied the recommendation
            # themselves, and the operation was successful. This stops the recommendation
            # content from being updated.
            #
            # MarkRecommendationSucceeded can be applied to recommendations in ACTIVE,
            # CLAIMED, SUCCEEDED, or FAILED state.
            #
            # Requires the recommender.*.update IAM permission for the specified
            # recommender.
            #
            # @overload mark_recommendation_succeeded(request, options = nil)
            #   @param request [Google::Cloud::Recommender::V1::MarkRecommendationSucceededRequest | Hash]
            #     Mark the Recommendation State as Succeeded. Users can use this method to
            #     indicate to the Recommender API that they have applied the recommendation
            #     themselves, and the operation was successful. This stops the recommendation
            #     content from being updated.
            #
            #     MarkRecommendationSucceeded can be applied to recommendations in ACTIVE,
            #     CLAIMED, SUCCEEDED, or FAILED state.
            #
            #     Requires the recommender.*.update IAM permission for the specified
            #     recommender.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload mark_recommendation_succeeded(name: nil, state_metadata: nil, etag: nil)
            #   @param name [String]
            #     Required. Name of the recommendation.
            #   @param state_metadata [Hash{String => String}]
            #     State properties to include with this state. Overwrites any existing
            #     `state_metadata`.
            #     Keys must match the regex /^[a-z0-9][a-z0-9_.-]\\\{0,62\}$/.
            #     Values must match the regex /^[a-zA-Z0-9_./-]\\\{0,255\}$/.
            #   @param etag [String]
            #     Required. Fingerprint of the Recommendation. Provides optimistic locking.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Recommender::V1::Recommendation]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Recommender::V1::Recommendation]
            #
            # @raise [Google::Cloud::Error] if the RPC is aborted.
            #
            def mark_recommendation_succeeded request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Recommender::V1::MarkRecommendationSucceededRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.mark_recommendation_succeeded.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Recommender::V1::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.mark_recommendation_succeeded.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.mark_recommendation_succeeded.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @recommender_stub.call_rpc :mark_recommendation_succeeded, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue GRPC::BadStatus => e
              raise Google::Cloud::Error.from_error(e)
            end

            ##
            # Mark the Recommendation State as Failed. Users can use this method to
            # indicate to the Recommender API that they have applied the recommendation
            # themselves, and the operation failed. This stops the recommendation content
            # from being updated.
            #
            # MarkRecommendationFailed can be applied to recommendations in ACTIVE,
            # CLAIMED, SUCCEEDED, or FAILED state.
            #
            # Requires the recommender.*.update IAM permission for the specified
            # recommender.
            #
            # @overload mark_recommendation_failed(request, options = nil)
            #   @param request [Google::Cloud::Recommender::V1::MarkRecommendationFailedRequest | Hash]
            #     Mark the Recommendation State as Failed. Users can use this method to
            #     indicate to the Recommender API that they have applied the recommendation
            #     themselves, and the operation failed. This stops the recommendation content
            #     from being updated.
            #
            #     MarkRecommendationFailed can be applied to recommendations in ACTIVE,
            #     CLAIMED, SUCCEEDED, or FAILED state.
            #
            #     Requires the recommender.*.update IAM permission for the specified
            #     recommender.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload mark_recommendation_failed(name: nil, state_metadata: nil, etag: nil)
            #   @param name [String]
            #     Required. Name of the recommendation.
            #   @param state_metadata [Hash{String => String}]
            #     State properties to include with this state. Overwrites any existing
            #     `state_metadata`.
            #     Keys must match the regex /^[a-z0-9][a-z0-9_.-]\\\{0,62\}$/.
            #     Values must match the regex /^[a-zA-Z0-9_./-]\\\{0,255\}$/.
            #   @param etag [String]
            #     Required. Fingerprint of the Recommendation. Provides optimistic locking.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Recommender::V1::Recommendation]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Recommender::V1::Recommendation]
            #
            # @raise [Google::Cloud::Error] if the RPC is aborted.
            #
            def mark_recommendation_failed request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Recommender::V1::MarkRecommendationFailedRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.mark_recommendation_failed.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Recommender::V1::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.mark_recommendation_failed.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.mark_recommendation_failed.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @recommender_stub.call_rpc :mark_recommendation_failed, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue GRPC::BadStatus => e
              raise Google::Cloud::Error.from_error(e)
            end

            ##
            # Configuration class for the Recommender API.
            #
            # This class represents the configuration for Recommender,
            # providing control over timeouts, retry behavior, logging, transport
            # parameters, and other low-level controls. Certain parameters can also be
            # applied individually to specific RPCs. See
            # {Google::Cloud::Recommender::V1::Recommender::Client::Configuration::Rpcs}
            # for a list of RPCs that can be configured independently.
            #
            # Configuration can be applied globally to all clients, or to a single client
            # on construction.
            #
            # # Examples
            #
            # To modify the global config, setting the timeout for list_recommendations
            # to 20 seconds, and all remaining timeouts to 10 seconds:
            #
            #     Google::Cloud::Recommender::V1::Recommender::Client.configure do |config|
            #       config.timeout = 10_000
            #       config.rpcs.list_recommendations.timeout = 20_000
            #     end
            #
            # To apply the above configuration only to a new client:
            #
            #     client = Google::Cloud::Recommender::V1::Recommender::Client.new do |config|
            #       config.timeout = 10_000
            #       config.rpcs.list_recommendations.timeout = 20_000
            #     end
            #
            # @!attribute [rw] endpoint
            #   The hostname or hostname:port of the service endpoint.
            #   Defaults to `"recommender.googleapis.com"`.
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

              config_attr :endpoint,     "recommender.googleapis.com", String
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
              # Configuration RPC class for the Recommender API.
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
                # RPC-specific configuration for `list_recommendations`
                # @return [Gapic::Config::Method]
                #
                attr_reader :list_recommendations
                ##
                # RPC-specific configuration for `get_recommendation`
                # @return [Gapic::Config::Method]
                #
                attr_reader :get_recommendation
                ##
                # RPC-specific configuration for `mark_recommendation_claimed`
                # @return [Gapic::Config::Method]
                #
                attr_reader :mark_recommendation_claimed
                ##
                # RPC-specific configuration for `mark_recommendation_succeeded`
                # @return [Gapic::Config::Method]
                #
                attr_reader :mark_recommendation_succeeded
                ##
                # RPC-specific configuration for `mark_recommendation_failed`
                # @return [Gapic::Config::Method]
                #
                attr_reader :mark_recommendation_failed

                # @private
                def initialize parent_rpcs = nil
                  list_recommendations_config = parent_rpcs&.list_recommendations if parent_rpcs&.respond_to? :list_recommendations
                  @list_recommendations = Gapic::Config::Method.new list_recommendations_config
                  get_recommendation_config = parent_rpcs&.get_recommendation if parent_rpcs&.respond_to? :get_recommendation
                  @get_recommendation = Gapic::Config::Method.new get_recommendation_config
                  mark_recommendation_claimed_config = parent_rpcs&.mark_recommendation_claimed if parent_rpcs&.respond_to? :mark_recommendation_claimed
                  @mark_recommendation_claimed = Gapic::Config::Method.new mark_recommendation_claimed_config
                  mark_recommendation_succeeded_config = parent_rpcs&.mark_recommendation_succeeded if parent_rpcs&.respond_to? :mark_recommendation_succeeded
                  @mark_recommendation_succeeded = Gapic::Config::Method.new mark_recommendation_succeeded_config
                  mark_recommendation_failed_config = parent_rpcs&.mark_recommendation_failed if parent_rpcs&.respond_to? :mark_recommendation_failed
                  @mark_recommendation_failed = Gapic::Config::Method.new mark_recommendation_failed_config

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
  require "google/cloud/recommender/v1/recommender/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
