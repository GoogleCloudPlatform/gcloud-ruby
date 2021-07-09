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
require "google/cloud/billing/budgets/v1beta1/budget_service_pb"

module Google
  module Cloud
    module Billing
      module Budgets
        module V1beta1
          module BudgetService
            ##
            # Client for the BudgetService service.
            #
            # BudgetService stores Cloud Billing budgets, which define a
            # budget plan and rules to execute as we track spend against that plan.
            #
            class Client
              include Paths

              # @private
              attr_reader :budget_service_stub

              ##
              # Configure the BudgetService Client class.
              #
              # See {::Google::Cloud::Billing::Budgets::V1beta1::BudgetService::Client::Configuration}
              # for a description of the configuration fields.
              #
              # ## Example
              #
              # To modify the configuration for all BudgetService clients:
              #
              #     ::Google::Cloud::Billing::Budgets::V1beta1::BudgetService::Client.configure do |config|
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
                  namespace = ["Google", "Cloud", "Billing", "Budgets", "V1beta1"]
                  parent_config = while namespace.any?
                                    parent_name = namespace.join "::"
                                    parent_const = const_get parent_name
                                    break parent_const.configure if parent_const.respond_to? :configure
                                    namespace.pop
                                  end
                  default_config = Client::Configuration.new parent_config

                  default_config.rpcs.create_budget.timeout = 60.0

                  default_config.rpcs.update_budget.timeout = 60.0
                  default_config.rpcs.update_budget.retry_policy = {
                    initial_delay: 0.1,
                max_delay: 60.0,
                multiplier: 1.3,
                retry_codes: [4, 14]
                  }

                  default_config.rpcs.get_budget.timeout = 60.0
                  default_config.rpcs.get_budget.retry_policy = {
                    initial_delay: 0.1,
                max_delay: 60.0,
                multiplier: 1.3,
                retry_codes: [4, 14]
                  }

                  default_config.rpcs.list_budgets.timeout = 60.0
                  default_config.rpcs.list_budgets.retry_policy = {
                    initial_delay: 0.1,
                max_delay: 60.0,
                multiplier: 1.3,
                retry_codes: [4, 14]
                  }

                  default_config.rpcs.delete_budget.timeout = 60.0
                  default_config.rpcs.delete_budget.retry_policy = {
                    initial_delay: 0.1,
                max_delay: 60.0,
                multiplier: 1.3,
                retry_codes: [4, 14]
                  }

                  default_config
                end
                yield @configure if block_given?
                @configure
              end

              ##
              # Configure the BudgetService Client instance.
              #
              # The configuration is set to the derived mode, meaning that values can be changed,
              # but structural changes (adding new fields, etc.) are not allowed. Structural changes
              # should be made on {Client.configure}.
              #
              # See {::Google::Cloud::Billing::Budgets::V1beta1::BudgetService::Client::Configuration}
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
              # Create a new BudgetService client object.
              #
              # ## Examples
              #
              # To create a new BudgetService client with the default
              # configuration:
              #
              #     client = ::Google::Cloud::Billing::Budgets::V1beta1::BudgetService::Client.new
              #
              # To create a new BudgetService client with a custom
              # configuration:
              #
              #     client = ::Google::Cloud::Billing::Budgets::V1beta1::BudgetService::Client.new do |config|
              #       config.timeout = 10.0
              #     end
              #
              # @yield [config] Configure the BudgetService client.
              # @yieldparam config [Client::Configuration]
              #
              def initialize
                # These require statements are intentionally placed here to initialize
                # the gRPC module only when it's required.
                # See https://github.com/googleapis/toolkit/issues/446
                require "gapic/grpc"
                require "google/cloud/billing/budgets/v1beta1/budget_service_services_pb"

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

                @budget_service_stub = ::Gapic::ServiceStub.new(
                  ::Google::Cloud::Billing::Budgets::V1beta1::BudgetService::Stub,
                  credentials:  credentials,
                  endpoint:     @config.endpoint,
                  channel_args: @config.channel_args,
                  interceptors: @config.interceptors
                )
              end

              # Service calls

              ##
              # Creates a new budget. See
              # <a href="https://cloud.google.com/billing/quotas">Quotas and limits</a>
              # for more information on the limits of the number of budgets you can create.
              #
              # @overload create_budget(request, options = nil)
              #   Pass arguments to `create_budget` via a request object, either of type
              #   {::Google::Cloud::Billing::Budgets::V1beta1::CreateBudgetRequest} or an equivalent Hash.
              #
              #   @param request [::Google::Cloud::Billing::Budgets::V1beta1::CreateBudgetRequest, ::Hash]
              #     A request object representing the call parameters. Required. To specify no
              #     parameters, or to keep all the default parameter values, pass an empty Hash.
              #   @param options [::Gapic::CallOptions, ::Hash]
              #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
              #
              # @overload create_budget(parent: nil, budget: nil)
              #   Pass arguments to `create_budget` via keyword arguments. Note that at
              #   least one keyword argument is required. To specify no parameters, or to keep all
              #   the default parameter values, pass an empty Hash as a request object (see above).
              #
              #   @param parent [::String]
              #     Required. The name of the billing account to create the budget in. Values
              #     are of the form `billingAccounts/{billingAccountId}`.
              #   @param budget [::Google::Cloud::Billing::Budgets::V1beta1::Budget, ::Hash]
              #     Required. Budget to create.
              #
              # @yield [response, operation] Access the result along with the RPC operation
              # @yieldparam response [::Google::Cloud::Billing::Budgets::V1beta1::Budget]
              # @yieldparam operation [::GRPC::ActiveCall::Operation]
              #
              # @return [::Google::Cloud::Billing::Budgets::V1beta1::Budget]
              #
              # @raise [::Google::Cloud::Error] if the RPC is aborted.
              #
              def create_budget request, options = nil
                raise ::ArgumentError, "request must be provided" if request.nil?

                request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Billing::Budgets::V1beta1::CreateBudgetRequest

                # Converts hash and nil to an options object
                options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

                # Customize the options with defaults
                metadata = @config.rpcs.create_budget.metadata.to_h

                # Set x-goog-api-client and x-goog-user-project headers
                metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                  lib_name: @config.lib_name, lib_version: @config.lib_version,
                  gapic_version: ::Google::Cloud::Billing::Budgets::V1beta1::VERSION
                metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

                header_params = {
                  "parent" => request.parent
                }
                request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
                metadata[:"x-goog-request-params"] ||= request_params_header

                options.apply_defaults timeout:      @config.rpcs.create_budget.timeout,
                                       metadata:     metadata,
                                       retry_policy: @config.rpcs.create_budget.retry_policy
                options.apply_defaults metadata:     @config.metadata,
                                       retry_policy: @config.retry_policy

                @budget_service_stub.call_rpc :create_budget, request, options: options do |response, operation|
                  yield response, operation if block_given?
                  return response
                end
              rescue ::GRPC::BadStatus => e
                raise ::Google::Cloud::Error.from_error(e)
              end

              ##
              # Updates a budget and returns the updated budget.
              #
              # WARNING: There are some fields exposed on the Google Cloud Console that
              # aren't available on this API. Budget fields that are not exposed in
              # this API will not be changed by this method.
              #
              # @overload update_budget(request, options = nil)
              #   Pass arguments to `update_budget` via a request object, either of type
              #   {::Google::Cloud::Billing::Budgets::V1beta1::UpdateBudgetRequest} or an equivalent Hash.
              #
              #   @param request [::Google::Cloud::Billing::Budgets::V1beta1::UpdateBudgetRequest, ::Hash]
              #     A request object representing the call parameters. Required. To specify no
              #     parameters, or to keep all the default parameter values, pass an empty Hash.
              #   @param options [::Gapic::CallOptions, ::Hash]
              #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
              #
              # @overload update_budget(budget: nil, update_mask: nil)
              #   Pass arguments to `update_budget` via keyword arguments. Note that at
              #   least one keyword argument is required. To specify no parameters, or to keep all
              #   the default parameter values, pass an empty Hash as a request object (see above).
              #
              #   @param budget [::Google::Cloud::Billing::Budgets::V1beta1::Budget, ::Hash]
              #     Required. The updated budget object.
              #     The budget to update is specified by the budget name in the budget.
              #   @param update_mask [::Google::Protobuf::FieldMask, ::Hash]
              #     Optional. Indicates which fields in the provided budget to update.
              #     Read-only fields (such as `name`) cannot be changed. If this is not
              #     provided, then only fields with non-default values from the request are
              #     updated. See
              #     https://developers.google.com/protocol-buffers/docs/proto3#default for more
              #     details about default values.
              #
              # @yield [response, operation] Access the result along with the RPC operation
              # @yieldparam response [::Google::Cloud::Billing::Budgets::V1beta1::Budget]
              # @yieldparam operation [::GRPC::ActiveCall::Operation]
              #
              # @return [::Google::Cloud::Billing::Budgets::V1beta1::Budget]
              #
              # @raise [::Google::Cloud::Error] if the RPC is aborted.
              #
              def update_budget request, options = nil
                raise ::ArgumentError, "request must be provided" if request.nil?

                request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Billing::Budgets::V1beta1::UpdateBudgetRequest

                # Converts hash and nil to an options object
                options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

                # Customize the options with defaults
                metadata = @config.rpcs.update_budget.metadata.to_h

                # Set x-goog-api-client and x-goog-user-project headers
                metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                  lib_name: @config.lib_name, lib_version: @config.lib_version,
                  gapic_version: ::Google::Cloud::Billing::Budgets::V1beta1::VERSION
                metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

                header_params = {
                  "budget.name" => request.budget.name
                }
                request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
                metadata[:"x-goog-request-params"] ||= request_params_header

                options.apply_defaults timeout:      @config.rpcs.update_budget.timeout,
                                       metadata:     metadata,
                                       retry_policy: @config.rpcs.update_budget.retry_policy
                options.apply_defaults metadata:     @config.metadata,
                                       retry_policy: @config.retry_policy

                @budget_service_stub.call_rpc :update_budget, request, options: options do |response, operation|
                  yield response, operation if block_given?
                  return response
                end
              rescue ::GRPC::BadStatus => e
                raise ::Google::Cloud::Error.from_error(e)
              end

              ##
              # Returns a budget.
              #
              # WARNING: There are some fields exposed on the Google Cloud Console that
              # aren't available on this API. When reading from the API, you will not
              # see these fields in the return value, though they may have been set
              # in the Cloud Console.
              #
              # @overload get_budget(request, options = nil)
              #   Pass arguments to `get_budget` via a request object, either of type
              #   {::Google::Cloud::Billing::Budgets::V1beta1::GetBudgetRequest} or an equivalent Hash.
              #
              #   @param request [::Google::Cloud::Billing::Budgets::V1beta1::GetBudgetRequest, ::Hash]
              #     A request object representing the call parameters. Required. To specify no
              #     parameters, or to keep all the default parameter values, pass an empty Hash.
              #   @param options [::Gapic::CallOptions, ::Hash]
              #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
              #
              # @overload get_budget(name: nil)
              #   Pass arguments to `get_budget` via keyword arguments. Note that at
              #   least one keyword argument is required. To specify no parameters, or to keep all
              #   the default parameter values, pass an empty Hash as a request object (see above).
              #
              #   @param name [::String]
              #     Required. Name of budget to get. Values are of the form
              #     `billingAccounts/{billingAccountId}/budgets/{budgetId}`.
              #
              # @yield [response, operation] Access the result along with the RPC operation
              # @yieldparam response [::Google::Cloud::Billing::Budgets::V1beta1::Budget]
              # @yieldparam operation [::GRPC::ActiveCall::Operation]
              #
              # @return [::Google::Cloud::Billing::Budgets::V1beta1::Budget]
              #
              # @raise [::Google::Cloud::Error] if the RPC is aborted.
              #
              def get_budget request, options = nil
                raise ::ArgumentError, "request must be provided" if request.nil?

                request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Billing::Budgets::V1beta1::GetBudgetRequest

                # Converts hash and nil to an options object
                options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

                # Customize the options with defaults
                metadata = @config.rpcs.get_budget.metadata.to_h

                # Set x-goog-api-client and x-goog-user-project headers
                metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                  lib_name: @config.lib_name, lib_version: @config.lib_version,
                  gapic_version: ::Google::Cloud::Billing::Budgets::V1beta1::VERSION
                metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

                header_params = {
                  "name" => request.name
                }
                request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
                metadata[:"x-goog-request-params"] ||= request_params_header

                options.apply_defaults timeout:      @config.rpcs.get_budget.timeout,
                                       metadata:     metadata,
                                       retry_policy: @config.rpcs.get_budget.retry_policy
                options.apply_defaults metadata:     @config.metadata,
                                       retry_policy: @config.retry_policy

                @budget_service_stub.call_rpc :get_budget, request, options: options do |response, operation|
                  yield response, operation if block_given?
                  return response
                end
              rescue ::GRPC::BadStatus => e
                raise ::Google::Cloud::Error.from_error(e)
              end

              ##
              # Returns a list of budgets for a billing account.
              #
              # WARNING: There are some fields exposed on the Google Cloud Console that
              # aren't available on this API. When reading from the API, you will not
              # see these fields in the return value, though they may have been set
              # in the Cloud Console.
              #
              # @overload list_budgets(request, options = nil)
              #   Pass arguments to `list_budgets` via a request object, either of type
              #   {::Google::Cloud::Billing::Budgets::V1beta1::ListBudgetsRequest} or an equivalent Hash.
              #
              #   @param request [::Google::Cloud::Billing::Budgets::V1beta1::ListBudgetsRequest, ::Hash]
              #     A request object representing the call parameters. Required. To specify no
              #     parameters, or to keep all the default parameter values, pass an empty Hash.
              #   @param options [::Gapic::CallOptions, ::Hash]
              #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
              #
              # @overload list_budgets(parent: nil, page_size: nil, page_token: nil)
              #   Pass arguments to `list_budgets` via keyword arguments. Note that at
              #   least one keyword argument is required. To specify no parameters, or to keep all
              #   the default parameter values, pass an empty Hash as a request object (see above).
              #
              #   @param parent [::String]
              #     Required. Name of billing account to list budgets under. Values
              #     are of the form `billingAccounts/{billingAccountId}`.
              #   @param page_size [::Integer]
              #     Optional. The maximum number of budgets to return per page.
              #     The default and maximum value are 100.
              #   @param page_token [::String]
              #     Optional. The value returned by the last `ListBudgetsResponse` which
              #     indicates that this is a continuation of a prior `ListBudgets` call,
              #     and that the system should return the next page of data.
              #
              # @yield [response, operation] Access the result along with the RPC operation
              # @yieldparam response [::Gapic::PagedEnumerable<::Google::Cloud::Billing::Budgets::V1beta1::Budget>]
              # @yieldparam operation [::GRPC::ActiveCall::Operation]
              #
              # @return [::Gapic::PagedEnumerable<::Google::Cloud::Billing::Budgets::V1beta1::Budget>]
              #
              # @raise [::Google::Cloud::Error] if the RPC is aborted.
              #
              def list_budgets request, options = nil
                raise ::ArgumentError, "request must be provided" if request.nil?

                request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Billing::Budgets::V1beta1::ListBudgetsRequest

                # Converts hash and nil to an options object
                options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

                # Customize the options with defaults
                metadata = @config.rpcs.list_budgets.metadata.to_h

                # Set x-goog-api-client and x-goog-user-project headers
                metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                  lib_name: @config.lib_name, lib_version: @config.lib_version,
                  gapic_version: ::Google::Cloud::Billing::Budgets::V1beta1::VERSION
                metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

                header_params = {
                  "parent" => request.parent
                }
                request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
                metadata[:"x-goog-request-params"] ||= request_params_header

                options.apply_defaults timeout:      @config.rpcs.list_budgets.timeout,
                                       metadata:     metadata,
                                       retry_policy: @config.rpcs.list_budgets.retry_policy
                options.apply_defaults metadata:     @config.metadata,
                                       retry_policy: @config.retry_policy

                @budget_service_stub.call_rpc :list_budgets, request, options: options do |response, operation|
                  response = ::Gapic::PagedEnumerable.new @budget_service_stub, :list_budgets, request, response, operation, options
                  yield response, operation if block_given?
                  return response
                end
              rescue ::GRPC::BadStatus => e
                raise ::Google::Cloud::Error.from_error(e)
              end

              ##
              # Deletes a budget. Returns successfully if already deleted.
              #
              # @overload delete_budget(request, options = nil)
              #   Pass arguments to `delete_budget` via a request object, either of type
              #   {::Google::Cloud::Billing::Budgets::V1beta1::DeleteBudgetRequest} or an equivalent Hash.
              #
              #   @param request [::Google::Cloud::Billing::Budgets::V1beta1::DeleteBudgetRequest, ::Hash]
              #     A request object representing the call parameters. Required. To specify no
              #     parameters, or to keep all the default parameter values, pass an empty Hash.
              #   @param options [::Gapic::CallOptions, ::Hash]
              #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
              #
              # @overload delete_budget(name: nil)
              #   Pass arguments to `delete_budget` via keyword arguments. Note that at
              #   least one keyword argument is required. To specify no parameters, or to keep all
              #   the default parameter values, pass an empty Hash as a request object (see above).
              #
              #   @param name [::String]
              #     Required. Name of the budget to delete. Values are of the form
              #     `billingAccounts/{billingAccountId}/budgets/{budgetId}`.
              #
              # @yield [response, operation] Access the result along with the RPC operation
              # @yieldparam response [::Google::Protobuf::Empty]
              # @yieldparam operation [::GRPC::ActiveCall::Operation]
              #
              # @return [::Google::Protobuf::Empty]
              #
              # @raise [::Google::Cloud::Error] if the RPC is aborted.
              #
              def delete_budget request, options = nil
                raise ::ArgumentError, "request must be provided" if request.nil?

                request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Billing::Budgets::V1beta1::DeleteBudgetRequest

                # Converts hash and nil to an options object
                options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

                # Customize the options with defaults
                metadata = @config.rpcs.delete_budget.metadata.to_h

                # Set x-goog-api-client and x-goog-user-project headers
                metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                  lib_name: @config.lib_name, lib_version: @config.lib_version,
                  gapic_version: ::Google::Cloud::Billing::Budgets::V1beta1::VERSION
                metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

                header_params = {
                  "name" => request.name
                }
                request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
                metadata[:"x-goog-request-params"] ||= request_params_header

                options.apply_defaults timeout:      @config.rpcs.delete_budget.timeout,
                                       metadata:     metadata,
                                       retry_policy: @config.rpcs.delete_budget.retry_policy
                options.apply_defaults metadata:     @config.metadata,
                                       retry_policy: @config.retry_policy

                @budget_service_stub.call_rpc :delete_budget, request, options: options do |response, operation|
                  yield response, operation if block_given?
                  return response
                end
              rescue ::GRPC::BadStatus => e
                raise ::Google::Cloud::Error.from_error(e)
              end

              ##
              # Configuration class for the BudgetService API.
              #
              # This class represents the configuration for BudgetService,
              # providing control over timeouts, retry behavior, logging, transport
              # parameters, and other low-level controls. Certain parameters can also be
              # applied individually to specific RPCs. See
              # {::Google::Cloud::Billing::Budgets::V1beta1::BudgetService::Client::Configuration::Rpcs}
              # for a list of RPCs that can be configured independently.
              #
              # Configuration can be applied globally to all clients, or to a single client
              # on construction.
              #
              # # Examples
              #
              # To modify the global config, setting the timeout for create_budget
              # to 20 seconds, and all remaining timeouts to 10 seconds:
              #
              #     ::Google::Cloud::Billing::Budgets::V1beta1::BudgetService::Client.configure do |config|
              #       config.timeout = 10.0
              #       config.rpcs.create_budget.timeout = 20.0
              #     end
              #
              # To apply the above configuration only to a new client:
              #
              #     client = ::Google::Cloud::Billing::Budgets::V1beta1::BudgetService::Client.new do |config|
              #       config.timeout = 10.0
              #       config.rpcs.create_budget.timeout = 20.0
              #     end
              #
              # @!attribute [rw] endpoint
              #   The hostname or hostname:port of the service endpoint.
              #   Defaults to `"billingbudgets.googleapis.com"`.
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

                config_attr :endpoint,      "billingbudgets.googleapis.com", ::String
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
                # Configuration RPC class for the BudgetService API.
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
                  # RPC-specific configuration for `create_budget`
                  # @return [::Gapic::Config::Method]
                  #
                  attr_reader :create_budget
                  ##
                  # RPC-specific configuration for `update_budget`
                  # @return [::Gapic::Config::Method]
                  #
                  attr_reader :update_budget
                  ##
                  # RPC-specific configuration for `get_budget`
                  # @return [::Gapic::Config::Method]
                  #
                  attr_reader :get_budget
                  ##
                  # RPC-specific configuration for `list_budgets`
                  # @return [::Gapic::Config::Method]
                  #
                  attr_reader :list_budgets
                  ##
                  # RPC-specific configuration for `delete_budget`
                  # @return [::Gapic::Config::Method]
                  #
                  attr_reader :delete_budget

                  # @private
                  def initialize parent_rpcs = nil
                    create_budget_config = parent_rpcs.create_budget if parent_rpcs.respond_to? :create_budget
                    @create_budget = ::Gapic::Config::Method.new create_budget_config
                    update_budget_config = parent_rpcs.update_budget if parent_rpcs.respond_to? :update_budget
                    @update_budget = ::Gapic::Config::Method.new update_budget_config
                    get_budget_config = parent_rpcs.get_budget if parent_rpcs.respond_to? :get_budget
                    @get_budget = ::Gapic::Config::Method.new get_budget_config
                    list_budgets_config = parent_rpcs.list_budgets if parent_rpcs.respond_to? :list_budgets
                    @list_budgets = ::Gapic::Config::Method.new list_budgets_config
                    delete_budget_config = parent_rpcs.delete_budget if parent_rpcs.respond_to? :delete_budget
                    @delete_budget = ::Gapic::Config::Method.new delete_budget_config

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
