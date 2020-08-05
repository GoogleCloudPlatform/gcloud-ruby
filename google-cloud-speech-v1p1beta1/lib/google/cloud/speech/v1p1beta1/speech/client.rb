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
require "google/cloud/speech/v1p1beta1/cloud_speech_pb"

module Google
  module Cloud
    module Speech
      module V1p1beta1
        module Speech
          ##
          # Client for the Speech service.
          #
          # Service that implements Google Cloud Speech API.
          #
          class Client
            include Paths

            # @private
            attr_reader :speech_stub

            ##
            # Configure the Speech Client class.
            #
            # See {::Google::Cloud::Speech::V1p1beta1::Speech::Client::Configuration}
            # for a description of the configuration fields.
            #
            # ## Example
            #
            # To modify the configuration for all Speech clients:
            #
            #     ::Google::Cloud::Speech::V1p1beta1::Speech::Client.configure do |config|
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
                namespace = ["Google", "Cloud", "Speech", "V1p1beta1"]
                parent_config = while namespace.any?
                                  parent_name = namespace.join "::"
                                  parent_const = const_get parent_name
                                  break parent_const.configure if parent_const&.respond_to? :configure
                                  namespace.pop
                                end
                default_config = Client::Configuration.new parent_config

                default_config.rpcs.recognize.timeout = 5000.0
                default_config.rpcs.recognize.retry_policy = {
                  initial_delay: 0.1,
                  max_delay:     60.0,
                  multiplier:    1.3,
                  retry_codes:   [4, 14]
                }

                default_config.rpcs.long_running_recognize.timeout = 5000.0

                default_config.rpcs.streaming_recognize.timeout = 5000.0
                default_config.rpcs.streaming_recognize.retry_policy = {
                  initial_delay: 0.1,
                  max_delay:     60.0,
                  multiplier:    1.3,
                  retry_codes:   [4, 14]
                }

                default_config
              end
              yield @configure if block_given?
              @configure
            end

            ##
            # Configure the Speech Client instance.
            #
            # The configuration is set to the derived mode, meaning that values can be changed,
            # but structural changes (adding new fields, etc.) are not allowed. Structural changes
            # should be made on {Client.configure}.
            #
            # See {::Google::Cloud::Speech::V1p1beta1::Speech::Client::Configuration}
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
            # Create a new Speech client object.
            #
            # ## Examples
            #
            # To create a new Speech client with the default
            # configuration:
            #
            #     client = ::Google::Cloud::Speech::V1p1beta1::Speech::Client.new
            #
            # To create a new Speech client with a custom
            # configuration:
            #
            #     client = ::Google::Cloud::Speech::V1p1beta1::Speech::Client.new do |config|
            #       config.timeout = 10.0
            #     end
            #
            # @yield [config] Configure the Speech client.
            # @yieldparam config [Client::Configuration]
            #
            def initialize
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "gapic/grpc"
              require "google/cloud/speech/v1p1beta1/cloud_speech_services_pb"

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

              @operations_client = Operations.new do |config|
                config.credentials = credentials
                config.endpoint = @config.endpoint
              end

              @speech_stub = ::Gapic::ServiceStub.new(
                ::Google::Cloud::Speech::V1p1beta1::Speech::Stub,
                credentials:  credentials,
                endpoint:     @config.endpoint,
                channel_args: @config.channel_args,
                interceptors: @config.interceptors
              )
            end

            ##
            # Get the associated client for long-running operations.
            #
            # @return [::Google::Cloud::Speech::V1p1beta1::Speech::Operations]
            #
            attr_reader :operations_client

            # Service calls

            ##
            # Performs synchronous speech recognition: receive results after all audio
            # has been sent and processed.
            #
            # @overload recognize(request, options = nil)
            #   Pass arguments to `recognize` via a request object, either of type
            #   {::Google::Cloud::Speech::V1p1beta1::RecognizeRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Speech::V1p1beta1::RecognizeRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload recognize(config: nil, audio: nil)
            #   Pass arguments to `recognize` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param config [::Google::Cloud::Speech::V1p1beta1::RecognitionConfig, ::Hash]
            #     Required. Provides information to the recognizer that specifies how to
            #     process the request.
            #   @param audio [::Google::Cloud::Speech::V1p1beta1::RecognitionAudio, ::Hash]
            #     Required. The audio data to be recognized.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Speech::V1p1beta1::RecognizeResponse]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Speech::V1p1beta1::RecognizeResponse]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def recognize request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Speech::V1p1beta1::RecognizeRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.recognize.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Speech::V1p1beta1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.recognize.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.recognize.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @speech_stub.call_rpc :recognize, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Performs asynchronous speech recognition: receive results via the
            # google.longrunning.Operations interface. Returns either an
            # `Operation.error` or an `Operation.response` which contains
            # a `LongRunningRecognizeResponse` message.
            # For more information on asynchronous speech recognition, see the
            # [how-to](https://cloud.google.com/speech-to-text/docs/async-recognize).
            #
            # @overload long_running_recognize(request, options = nil)
            #   Pass arguments to `long_running_recognize` via a request object, either of type
            #   {::Google::Cloud::Speech::V1p1beta1::LongRunningRecognizeRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Speech::V1p1beta1::LongRunningRecognizeRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload long_running_recognize(config: nil, audio: nil)
            #   Pass arguments to `long_running_recognize` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param config [::Google::Cloud::Speech::V1p1beta1::RecognitionConfig, ::Hash]
            #     Required. Provides information to the recognizer that specifies how to
            #     process the request.
            #   @param audio [::Google::Cloud::Speech::V1p1beta1::RecognitionAudio, ::Hash]
            #     Required. The audio data to be recognized.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Gapic::Operation]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Gapic::Operation]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def long_running_recognize request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Speech::V1p1beta1::LongRunningRecognizeRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.long_running_recognize.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Speech::V1p1beta1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.long_running_recognize.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.long_running_recognize.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @speech_stub.call_rpc :long_running_recognize, request, options: options do |response, operation|
                response = ::Gapic::Operation.new response, @operations_client, options: options
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Performs bidirectional streaming speech recognition: receive results while
            # sending audio. This method is only available via the gRPC API (not REST).
            #
            # @param request [::Gapic::StreamInput, ::Enumerable<::Google::Cloud::Speech::V1p1beta1::StreamingRecognizeRequest, ::Hash>]
            #   An enumerable of {::Google::Cloud::Speech::V1p1beta1::StreamingRecognizeRequest} instances.
            # @param options [::Gapic::CallOptions, ::Hash]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Enumerable<::Google::Cloud::Speech::V1p1beta1::StreamingRecognizeResponse>]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Enumerable<::Google::Cloud::Speech::V1p1beta1::StreamingRecognizeResponse>]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def streaming_recognize request, options = nil
              unless request.is_a? ::Enumerable
                raise ::ArgumentError, "request must be an Enumerable" unless request.respond_to? :to_enum
                request = request.to_enum
              end

              request = request.lazy.map do |req|
                ::Gapic::Protobuf.coerce req, to: ::Google::Cloud::Speech::V1p1beta1::StreamingRecognizeRequest
              end

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.streaming_recognize.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Speech::V1p1beta1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.streaming_recognize.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.streaming_recognize.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @speech_stub.call_rpc :streaming_recognize, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Configuration class for the Speech API.
            #
            # This class represents the configuration for Speech,
            # providing control over timeouts, retry behavior, logging, transport
            # parameters, and other low-level controls. Certain parameters can also be
            # applied individually to specific RPCs. See
            # {::Google::Cloud::Speech::V1p1beta1::Speech::Client::Configuration::Rpcs}
            # for a list of RPCs that can be configured independently.
            #
            # Configuration can be applied globally to all clients, or to a single client
            # on construction.
            #
            # # Examples
            #
            # To modify the global config, setting the timeout for recognize
            # to 20 seconds, and all remaining timeouts to 10 seconds:
            #
            #     ::Google::Cloud::Speech::V1p1beta1::Speech::Client.configure do |config|
            #       config.timeout = 10.0
            #       config.rpcs.recognize.timeout = 20.0
            #     end
            #
            # To apply the above configuration only to a new client:
            #
            #     client = ::Google::Cloud::Speech::V1p1beta1::Speech::Client.new do |config|
            #       config.timeout = 10.0
            #       config.rpcs.recognize.timeout = 20.0
            #     end
            #
            # @!attribute [rw] endpoint
            #   The hostname or hostname:port of the service endpoint.
            #   Defaults to `"speech.googleapis.com"`.
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

              config_attr :endpoint,      "speech.googleapis.com", ::String
              config_attr :credentials,   nil do |value|
                allowed = [::String, ::Hash, ::Proc, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
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
              # Configuration RPC class for the Speech API.
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
                # RPC-specific configuration for `recognize`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :recognize
                ##
                # RPC-specific configuration for `long_running_recognize`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :long_running_recognize
                ##
                # RPC-specific configuration for `streaming_recognize`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :streaming_recognize

                # @private
                def initialize parent_rpcs = nil
                  recognize_config = parent_rpcs&.recognize if parent_rpcs&.respond_to? :recognize
                  @recognize = ::Gapic::Config::Method.new recognize_config
                  long_running_recognize_config = parent_rpcs&.long_running_recognize if parent_rpcs&.respond_to? :long_running_recognize
                  @long_running_recognize = ::Gapic::Config::Method.new long_running_recognize_config
                  streaming_recognize_config = parent_rpcs&.streaming_recognize if parent_rpcs&.respond_to? :streaming_recognize
                  @streaming_recognize = ::Gapic::Config::Method.new streaming_recognize_config

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
