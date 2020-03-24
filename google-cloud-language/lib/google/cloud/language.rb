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

require "google-cloud-language"

module Google
  module Cloud
    module Language
      ##
      # Create a new client object for LanguageService.
      #
      # By default, this returns an instance of
      # [Google::Cloud::Language::V1::LanguageService::Client](https://googleapis.dev/ruby/google-cloud-language-v1/latest/Google/Cloud/Language/V1/LanguageService/Client.html)
      # for version V1 of the API.
      # However, you can specify specify a different API version by passing it in the
      # `version` parameter. If the LanguageService service is
      # supported by that API version, and the corresponding gem is available, the
      # appropriate versioned client will be returned.
      #
      # ## About LanguageService
      #
      # Provides text analysis operations such as sentiment analysis and entity
      # recognition.
      #
      # @param version [String, Symbol] The API version to connect to. Optional.
      #   Defaults to `:v1`.
      # @return [LanguageService::Client] A client object for the specified version.
      #
      def self.language_service version: :v1, &block
        require "google/cloud/language/#{version.to_s.downcase}"

        package_name = Google::Cloud::Language
                       .constants
                       .select { |sym| sym.to_s.downcase == version.to_s.downcase.tr("_", "") }
                       .first
        package_module = Google::Cloud::Language.const_get package_name
        package_module.const_get(:LanguageService).const_get(:Client).new(&block)
      end

      ##
      # Configure the google-cloud-language library.
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
        yield Google::Cloud.configure.language if block_given?

        Google::Cloud.configure.language
      end
    end
  end
end
