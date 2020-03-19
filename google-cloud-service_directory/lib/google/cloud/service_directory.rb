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


require "google-cloud-service_directory"

module Google
  module Cloud
    ##
    # Service directory is the single place to register, browse, and resolve application services.
    module ServiceDirectory
      ##
      # Create a new `LookupService::Client` object.
      #
      # @param version [String, Symbol] The API version to create the client instance. Optional. If not provided
      #   defaults to `:v1beta1`, which will return an instance of
      #   [Google::Cloud::ServiceDirectory::V1beta1::LookupService::Client](https://googleapis.dev/ruby/google-cloud-service_directory-v1beta1/latest/Google/Cloud/ServiceDirectory/V1beta1/LookupService/Client.html).
      #
      # @return [LookupService::Client] A client object for the specified version.
      #
      def self.lookup_service version: :v1beta1, &block
        require "google/cloud/service_directory/#{version.to_s.downcase}"

        package_name = Google::Cloud::ServiceDirectory
                       .constants
                       .select { |sym| sym.to_s.downcase == version.to_s.downcase.tr("_", "") }
                       .first
        package_module = Google::Cloud::ServiceDirectory.const_get package_name
        package_module.const_get(:LookupService).const_get(:Client).new(&block)
      end

      ##
      # Create a new `RegistrationService::Client` object.
      #
      # @param version [String, Symbol] The API version to create the client instance. Optional. If not provided
      #   defaults to `:v1beta1`, which will return an instance of
      #   [Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client](https://googleapis.dev/ruby/google-cloud-service_directory-v1beta1/latest/Google/Cloud/ServiceDirectory/V1beta1/RegistrationService/Client.html).
      #
      # @return [RegistrationService::Client] A client object for the specified version.
      #
      def self.registration_service version: :v1beta1, &block
        require "google/cloud/service_directory/#{version.to_s.downcase}"

        package_name = Google::Cloud::ServiceDirectory
                       .constants
                       .select { |sym| sym.to_s.downcase == version.to_s.downcase.tr("_", "") }
                       .first
        package_module = Google::Cloud::ServiceDirectory.const_get package_name
        package_module.const_get(:RegistrationService).const_get(:Client).new(&block)
      end

      ##
      # Configure the Google Service Directory library.
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
      # @return [Google::Cloud::Config] The default configuration used by this library
      #
      def self.configure
        yield Google::Cloud.configure.service_directory if block_given?

        Google::Cloud.configure.service_directory
      end
    end
  end
end
