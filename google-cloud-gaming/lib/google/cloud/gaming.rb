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

# Require this file early so that the version constant gets defined before
# requiring "google/cloud". This is because google-cloud-core will load the
# entrypoint (gem name) file, which in turn re-requires this file (hence
# causing a require cycle) unless the version constant is already defined.
require "google/cloud/gaming/version"

require "googleauth"
gem "google-cloud-core"
require "google/cloud" unless defined? ::Google::Cloud.new
require "google/cloud/config"

# Set the default configuration
::Google::Cloud.configure.add_config! :gaming do |config|
  config.add_field! :endpoint,      "gameservices.googleapis.com", match: ::String
  config.add_field! :credentials,   nil, match: [::String, ::Hash, ::Google::Auth::Credentials]
  config.add_field! :scope,         nil, match: [::Array, ::String]
  config.add_field! :lib_name,      nil, match: ::String
  config.add_field! :lib_version,   nil, match: ::String
  config.add_field! :interceptors,  nil, match: ::Array
  config.add_field! :timeout,       nil, match: ::Numeric
  config.add_field! :metadata,      nil, match: ::Hash
  config.add_field! :retry_policy,  nil, match: [::Hash, ::Proc]
  config.add_field! :quota_project, nil, match: ::String
end

module Google
  module Cloud
    module Gaming
      ##
      # Create a new client object for GameServerClustersService.
      #
      # By default, this returns an instance of
      # [Google::Cloud::Gaming::V1::GameServerClustersService::Client](https://googleapis.dev/ruby/google-cloud-gaming-v1/latest/Google/Cloud/Gaming/V1/GameServerClustersService/Client.html)
      # for version V1 of the API.
      # However, you can specify specify a different API version by passing it in the
      # `version` parameter. If the GameServerClustersService service is
      # supported by that API version, and the corresponding gem is available, the
      # appropriate versioned client will be returned.
      #
      # ## About GameServerClustersService
      #
      # The game server cluster maps to Kubernetes clusters running Agones and is
      # used to manage fleets within clusters.
      #
      # @param version [::String, ::Symbol] The API version to connect to. Optional.
      #   Defaults to `:v1`.
      # @return [GameServerClustersService::Client] A client object for the specified version.
      #
      def self.game_server_clusters_service version: :v1, &block
        require "google/cloud/gaming/#{version.to_s.downcase}"

        package_name = Google::Cloud::Gaming
                       .constants
                       .select { |sym| sym.to_s.downcase == version.to_s.downcase.tr("_", "") }
                       .first
        package_module = Google::Cloud::Gaming.const_get package_name
        package_module.const_get(:GameServerClustersService).const_get(:Client).new(&block)
      end

      ##
      # Create a new client object for GameServerConfigsService.
      #
      # By default, this returns an instance of
      # [Google::Cloud::Gaming::V1::GameServerConfigsService::Client](https://googleapis.dev/ruby/google-cloud-gaming-v1/latest/Google/Cloud/Gaming/V1/GameServerConfigsService/Client.html)
      # for version V1 of the API.
      # However, you can specify specify a different API version by passing it in the
      # `version` parameter. If the GameServerConfigsService service is
      # supported by that API version, and the corresponding gem is available, the
      # appropriate versioned client will be returned.
      #
      # ## About GameServerConfigsService
      #
      # The game server config configures the game servers in an Agones fleet.
      #
      # @param version [::String, ::Symbol] The API version to connect to. Optional.
      #   Defaults to `:v1`.
      # @return [GameServerConfigsService::Client] A client object for the specified version.
      #
      def self.game_server_configs_service version: :v1, &block
        require "google/cloud/gaming/#{version.to_s.downcase}"

        package_name = Google::Cloud::Gaming
                       .constants
                       .select { |sym| sym.to_s.downcase == version.to_s.downcase.tr("_", "") }
                       .first
        package_module = Google::Cloud::Gaming.const_get package_name
        package_module.const_get(:GameServerConfigsService).const_get(:Client).new(&block)
      end

      ##
      # Create a new client object for GameServerDeploymentsService.
      #
      # By default, this returns an instance of
      # [Google::Cloud::Gaming::V1::GameServerDeploymentsService::Client](https://googleapis.dev/ruby/google-cloud-gaming-v1/latest/Google/Cloud/Gaming/V1/GameServerDeploymentsService/Client.html)
      # for version V1 of the API.
      # However, you can specify specify a different API version by passing it in the
      # `version` parameter. If the GameServerDeploymentsService service is
      # supported by that API version, and the corresponding gem is available, the
      # appropriate versioned client will be returned.
      #
      # ## About GameServerDeploymentsService
      #
      # The game server deployment is used to control the deployment of Agones
      # fleets.
      #
      # @param version [::String, ::Symbol] The API version to connect to. Optional.
      #   Defaults to `:v1`.
      # @return [GameServerDeploymentsService::Client] A client object for the specified version.
      #
      def self.game_server_deployments_service version: :v1, &block
        require "google/cloud/gaming/#{version.to_s.downcase}"

        package_name = Google::Cloud::Gaming
                       .constants
                       .select { |sym| sym.to_s.downcase == version.to_s.downcase.tr("_", "") }
                       .first
        package_module = Google::Cloud::Gaming.const_get package_name
        package_module.const_get(:GameServerDeploymentsService).const_get(:Client).new(&block)
      end

      ##
      # Create a new client object for RealmsService.
      #
      # By default, this returns an instance of
      # [Google::Cloud::Gaming::V1::RealmsService::Client](https://googleapis.dev/ruby/google-cloud-gaming-v1/latest/Google/Cloud/Gaming/V1/RealmsService/Client.html)
      # for version V1 of the API.
      # However, you can specify specify a different API version by passing it in the
      # `version` parameter. If the RealmsService service is
      # supported by that API version, and the corresponding gem is available, the
      # appropriate versioned client will be returned.
      #
      # ## About RealmsService
      #
      # A realm is a grouping of game server clusters that are considered
      # interchangeable.
      #
      # @param version [::String, ::Symbol] The API version to connect to. Optional.
      #   Defaults to `:v1`.
      # @return [RealmsService::Client] A client object for the specified version.
      #
      def self.realms_service version: :v1, &block
        require "google/cloud/gaming/#{version.to_s.downcase}"

        package_name = Google::Cloud::Gaming
                       .constants
                       .select { |sym| sym.to_s.downcase == version.to_s.downcase.tr("_", "") }
                       .first
        package_module = Google::Cloud::Gaming.const_get package_name
        package_module.const_get(:RealmsService).const_get(:Client).new(&block)
      end

      ##
      # Configure the google-cloud-gaming library.
      #
      # The following configuration parameters are supported:
      #
      # * `credentials` (*type:* `String, Hash, Google::Auth::Credentials`) -
      #   The path to the keyfile as a String, the contents of the keyfile as a
      #   Hash, or a Google::Auth::Credentials object.
      # * `lib_name` (*type:* `String`) -
      #   The library name as recorded in instrumentation and logging.
      # * `lib_version` (*type:* `String`) -
      #   The library version as recorded in instrumentation and logging.
      # * `interceptors` (*type:* `Array<GRPC::ClientInterceptor>`) -
      #   An array of interceptors that are run before calls are executed.
      # * `timeout` (*type:* `Integer`) -
      #   Default timeout in milliseconds.
      # * `metadata` (*type:* `Hash{Symbol=>String}`) -
      #   Additional gRPC headers to be sent with the call.
      # * `retry_policy` (*type:* `Hash`) -
      #   The retry policy. The value is a hash with the following keys:
      #     * `:initial_delay` (*type:* `Numeric`) - The initial delay in seconds.
      #     * `:max_delay` (*type:* `Numeric`) - The max delay in seconds.
      #     * `:multiplier` (*type:* `Numeric`) - The incremental backoff multiplier.
      #     * `:retry_codes` (*type:* `Array<String>`) -
      #       The error codes that should trigger a retry.
      #
      # @return [::Google::Cloud::Config] The default configuration used by this library
      #
      def self.configure
        yield ::Google::Cloud.configure.gaming if block_given?

        ::Google::Cloud.configure.gaming
      end
    end
  end
end

helper_path = ::File.join __dir__, "gaming", "helpers.rb"
require "google/cloud/gaming/helpers" if ::File.file? helper_path
