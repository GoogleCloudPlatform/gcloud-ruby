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
require "google/cloud/retail/v2/product_service_pb"

module Google
  module Cloud
    module Retail
      module V2
        module ProductService
          ##
          # Client for the ProductService service.
          #
          # Service for ingesting {::Google::Cloud::Retail::V2::Product Product} information
          # of the customer's website.
          #
          class Client
            include Paths

            # @private
            attr_reader :product_service_stub

            ##
            # Configure the ProductService Client class.
            #
            # See {::Google::Cloud::Retail::V2::ProductService::Client::Configuration}
            # for a description of the configuration fields.
            #
            # ## Example
            #
            # To modify the configuration for all ProductService clients:
            #
            #     ::Google::Cloud::Retail::V2::ProductService::Client.configure do |config|
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
                namespace = ["Google", "Cloud", "Retail", "V2"]
                parent_config = while namespace.any?
                                  parent_name = namespace.join "::"
                                  parent_const = const_get parent_name
                                  break parent_const.configure if parent_const&.respond_to? :configure
                                  namespace.pop
                                end
                default_config = Client::Configuration.new parent_config

                default_config.timeout = 60.0
                default_config.retry_policy = {
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
            # Configure the ProductService Client instance.
            #
            # The configuration is set to the derived mode, meaning that values can be changed,
            # but structural changes (adding new fields, etc.) are not allowed. Structural changes
            # should be made on {Client.configure}.
            #
            # See {::Google::Cloud::Retail::V2::ProductService::Client::Configuration}
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
            # Create a new ProductService client object.
            #
            # ## Examples
            #
            # To create a new ProductService client with the default
            # configuration:
            #
            #     client = ::Google::Cloud::Retail::V2::ProductService::Client.new
            #
            # To create a new ProductService client with a custom
            # configuration:
            #
            #     client = ::Google::Cloud::Retail::V2::ProductService::Client.new do |config|
            #       config.timeout = 10.0
            #     end
            #
            # @yield [config] Configure the ProductService client.
            # @yieldparam config [Client::Configuration]
            #
            def initialize
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "gapic/grpc"
              require "google/cloud/retail/v2/product_service_services_pb"

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

              @product_service_stub = ::Gapic::ServiceStub.new(
                ::Google::Cloud::Retail::V2::ProductService::Stub,
                credentials:  credentials,
                endpoint:     @config.endpoint,
                channel_args: @config.channel_args,
                interceptors: @config.interceptors
              )
            end

            ##
            # Get the associated client for long-running operations.
            #
            # @return [::Google::Cloud::Retail::V2::ProductService::Operations]
            #
            attr_reader :operations_client

            # Service calls

            ##
            # Creates a {::Google::Cloud::Retail::V2::Product Product}.
            #
            # @overload create_product(request, options = nil)
            #   Pass arguments to `create_product` via a request object, either of type
            #   {::Google::Cloud::Retail::V2::CreateProductRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Retail::V2::CreateProductRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload create_product(parent: nil, product: nil, product_id: nil)
            #   Pass arguments to `create_product` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param parent [::String]
            #     Required. The parent catalog resource name, such as
            #     `projects/*/locations/global/catalogs/default_catalog/branches/default_branch`.
            #   @param product [::Google::Cloud::Retail::V2::Product, ::Hash]
            #     Required. The {::Google::Cloud::Retail::V2::Product Product} to create.
            #   @param product_id [::String]
            #     Required. The ID to use for the {::Google::Cloud::Retail::V2::Product Product},
            #     which will become the final component of the
            #     {::Google::Cloud::Retail::V2::Product#name Product.name}.
            #
            #     If the caller does not have permission to create the
            #     {::Google::Cloud::Retail::V2::Product Product}, regardless of whether or not it
            #     exists, a PERMISSION_DENIED error is returned.
            #
            #     This field must be unique among all
            #     {::Google::Cloud::Retail::V2::Product Product}s with the same
            #     {::Google::Cloud::Retail::V2::CreateProductRequest#parent parent}. Otherwise, an
            #     ALREADY_EXISTS error is returned.
            #
            #     This field must be a UTF-8 encoded string with a length limit of 128
            #     characters. Otherwise, an INVALID_ARGUMENT error is returned.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Retail::V2::Product]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Retail::V2::Product]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def create_product request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Retail::V2::CreateProductRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.create_product.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Retail::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.create_product.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.create_product.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_service_stub.call_rpc :create_product, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Gets a {::Google::Cloud::Retail::V2::Product Product}.
            #
            # @overload get_product(request, options = nil)
            #   Pass arguments to `get_product` via a request object, either of type
            #   {::Google::Cloud::Retail::V2::GetProductRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Retail::V2::GetProductRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload get_product(name: nil)
            #   Pass arguments to `get_product` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param name [::String]
            #     Required. Full resource name of {::Google::Cloud::Retail::V2::Product Product},
            #     such as
            #     `projects/*/locations/global/catalogs/default_catalog/branches/default_branch/products/some_product_id`.
            #
            #     If the caller does not have permission to access the
            #     {::Google::Cloud::Retail::V2::Product Product}, regardless of whether or not it
            #     exists, a PERMISSION_DENIED error is returned.
            #
            #     If the requested {::Google::Cloud::Retail::V2::Product Product} does not exist,
            #     a NOT_FOUND error is returned.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Retail::V2::Product]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Retail::V2::Product]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def get_product request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Retail::V2::GetProductRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.get_product.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Retail::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.get_product.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.get_product.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_service_stub.call_rpc :get_product, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Updates a {::Google::Cloud::Retail::V2::Product Product}.
            #
            # @overload update_product(request, options = nil)
            #   Pass arguments to `update_product` via a request object, either of type
            #   {::Google::Cloud::Retail::V2::UpdateProductRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Retail::V2::UpdateProductRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload update_product(product: nil, update_mask: nil)
            #   Pass arguments to `update_product` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param product [::Google::Cloud::Retail::V2::Product, ::Hash]
            #     Required. The product to update/create.
            #
            #     If the caller does not have permission to update the
            #     {::Google::Cloud::Retail::V2::Product Product}, regardless of whether or not it
            #     exists, a PERMISSION_DENIED error is returned.
            #
            #     If the {::Google::Cloud::Retail::V2::Product Product} to update does not exist,
            #     a NOT_FOUND error is returned.
            #   @param update_mask [::Google::Protobuf::FieldMask, ::Hash]
            #     Indicates which fields in the provided
            #     {::Google::Cloud::Retail::V2::Product Product} to update. The immutable and
            #     output only fields are NOT supported. If not set, all supported fields (the
            #     fields that are neither immutable nor output only) are updated.
            #
            #     If an unsupported or unknown field is provided, an INVALID_ARGUMENT error
            #     is returned.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Retail::V2::Product]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Retail::V2::Product]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def update_product request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Retail::V2::UpdateProductRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.update_product.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Retail::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "product.name" => request.product.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.update_product.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.update_product.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_service_stub.call_rpc :update_product, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Deletes a {::Google::Cloud::Retail::V2::Product Product}.
            #
            # @overload delete_product(request, options = nil)
            #   Pass arguments to `delete_product` via a request object, either of type
            #   {::Google::Cloud::Retail::V2::DeleteProductRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Retail::V2::DeleteProductRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload delete_product(name: nil)
            #   Pass arguments to `delete_product` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param name [::String]
            #     Required. Full resource name of {::Google::Cloud::Retail::V2::Product Product},
            #     such as
            #     `projects/*/locations/global/catalogs/default_catalog/branches/default_branch/products/some_product_id`.
            #
            #     If the caller does not have permission to delete the
            #     {::Google::Cloud::Retail::V2::Product Product}, regardless of whether or not it
            #     exists, a PERMISSION_DENIED error is returned.
            #
            #     If the {::Google::Cloud::Retail::V2::Product Product} to delete does not exist,
            #     a NOT_FOUND error is returned.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Protobuf::Empty]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Protobuf::Empty]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def delete_product request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Retail::V2::DeleteProductRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.delete_product.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Retail::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.delete_product.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.delete_product.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_service_stub.call_rpc :delete_product, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Bulk import of multiple {::Google::Cloud::Retail::V2::Product Product}s.
            #
            # Request processing may be synchronous. No partial updating is supported.
            # Non-existing items are created.
            #
            # Note that it is possible for a subset of the
            # {::Google::Cloud::Retail::V2::Product Product}s to be successfully updated.
            #
            # @overload import_products(request, options = nil)
            #   Pass arguments to `import_products` via a request object, either of type
            #   {::Google::Cloud::Retail::V2::ImportProductsRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Retail::V2::ImportProductsRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload import_products(parent: nil, input_config: nil, errors_config: nil, update_mask: nil)
            #   Pass arguments to `import_products` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param parent [::String]
            #     Required.
            #     `projects/1234/locations/global/catalogs/default_catalog/branches/default_branch`
            #
            #     If no updateMask is specified, requires products.create permission.
            #     If updateMask is specified, requires products.update permission.
            #   @param input_config [::Google::Cloud::Retail::V2::ProductInputConfig, ::Hash]
            #     Required. The desired input location of the data.
            #   @param errors_config [::Google::Cloud::Retail::V2::ImportErrorsConfig, ::Hash]
            #     The desired location of errors incurred during the Import.
            #   @param update_mask [::Google::Protobuf::FieldMask, ::Hash]
            #     Indicates which fields in the provided imported 'products' to update. If
            #     not set, will by default update all fields.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Gapic::Operation]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Gapic::Operation]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            def import_products request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Retail::V2::ImportProductsRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.import_products.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Retail::V2::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.import_products.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.import_products.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_service_stub.call_rpc :import_products, request, options: options do |response, operation|
                response = ::Gapic::Operation.new response, @operations_client, options: options
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Configuration class for the ProductService API.
            #
            # This class represents the configuration for ProductService,
            # providing control over timeouts, retry behavior, logging, transport
            # parameters, and other low-level controls. Certain parameters can also be
            # applied individually to specific RPCs. See
            # {::Google::Cloud::Retail::V2::ProductService::Client::Configuration::Rpcs}
            # for a list of RPCs that can be configured independently.
            #
            # Configuration can be applied globally to all clients, or to a single client
            # on construction.
            #
            # # Examples
            #
            # To modify the global config, setting the timeout for create_product
            # to 20 seconds, and all remaining timeouts to 10 seconds:
            #
            #     ::Google::Cloud::Retail::V2::ProductService::Client.configure do |config|
            #       config.timeout = 10.0
            #       config.rpcs.create_product.timeout = 20.0
            #     end
            #
            # To apply the above configuration only to a new client:
            #
            #     client = ::Google::Cloud::Retail::V2::ProductService::Client.new do |config|
            #       config.timeout = 10.0
            #       config.rpcs.create_product.timeout = 20.0
            #     end
            #
            # @!attribute [rw] endpoint
            #   The hostname or hostname:port of the service endpoint.
            #   Defaults to `"retail.googleapis.com"`.
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

              config_attr :endpoint,      "retail.googleapis.com", ::String
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
              # Configuration RPC class for the ProductService API.
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
                # RPC-specific configuration for `create_product`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :create_product
                ##
                # RPC-specific configuration for `get_product`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :get_product
                ##
                # RPC-specific configuration for `update_product`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :update_product
                ##
                # RPC-specific configuration for `delete_product`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :delete_product
                ##
                # RPC-specific configuration for `import_products`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :import_products

                # @private
                def initialize parent_rpcs = nil
                  create_product_config = parent_rpcs&.create_product if parent_rpcs&.respond_to? :create_product
                  @create_product = ::Gapic::Config::Method.new create_product_config
                  get_product_config = parent_rpcs&.get_product if parent_rpcs&.respond_to? :get_product
                  @get_product = ::Gapic::Config::Method.new get_product_config
                  update_product_config = parent_rpcs&.update_product if parent_rpcs&.respond_to? :update_product
                  @update_product = ::Gapic::Config::Method.new update_product_config
                  delete_product_config = parent_rpcs&.delete_product if parent_rpcs&.respond_to? :delete_product
                  @delete_product = ::Gapic::Config::Method.new delete_product_config
                  import_products_config = parent_rpcs&.import_products if parent_rpcs&.respond_to? :import_products
                  @import_products = ::Gapic::Config::Method.new import_products_config

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
