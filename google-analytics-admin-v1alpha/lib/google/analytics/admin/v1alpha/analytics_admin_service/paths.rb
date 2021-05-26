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


module Google
  module Analytics
    module Admin
      module V1alpha
        module AnalyticsAdminService
          # Path helper methods for the AnalyticsAdminService API.
          module Paths
            ##
            # Create a fully-qualified Account resource string.
            #
            # The resource will be in the following format:
            #
            # `accounts/{account}`
            #
            # @param account [String]
            #
            # @return [::String]
            def account_path account:
              "accounts/#{account}"
            end

            ##
            # Create a fully-qualified AndroidAppDataStream resource string.
            #
            # The resource will be in the following format:
            #
            # `properties/{property}/androidAppDataStreams/{android_app_data_stream}`
            #
            # @param property [String]
            # @param android_app_data_stream [String]
            #
            # @return [::String]
            def android_app_data_stream_path property:, android_app_data_stream:
              raise ::ArgumentError, "property cannot contain /" if property.to_s.include? "/"

              "properties/#{property}/androidAppDataStreams/#{android_app_data_stream}"
            end

            ##
            # Create a fully-qualified ConversionEvent resource string.
            #
            # The resource will be in the following format:
            #
            # `properties/{property}/conversionEvents/{conversion_event}`
            #
            # @param property [String]
            # @param conversion_event [String]
            #
            # @return [::String]
            def conversion_event_path property:, conversion_event:
              raise ::ArgumentError, "property cannot contain /" if property.to_s.include? "/"

              "properties/#{property}/conversionEvents/#{conversion_event}"
            end

            ##
            # Create a fully-qualified CustomDimension resource string.
            #
            # The resource will be in the following format:
            #
            # `properties/{property}/customDimensions`
            #
            # @param property [String]
            #
            # @return [::String]
            def custom_dimension_path property:
              "properties/#{property}/customDimensions"
            end

            ##
            # Create a fully-qualified CustomMetric resource string.
            #
            # The resource will be in the following format:
            #
            # `properties/{property}/customMetrics`
            #
            # @param property [String]
            #
            # @return [::String]
            def custom_metric_path property:
              "properties/#{property}/customMetrics"
            end

            ##
            # Create a fully-qualified DataSharingSettings resource string.
            #
            # The resource will be in the following format:
            #
            # `accounts/{account}/dataSharingSettings`
            #
            # @param account [String]
            #
            # @return [::String]
            def data_sharing_settings_path account:
              "accounts/#{account}/dataSharingSettings"
            end

            ##
            # Create a fully-qualified EnhancedMeasurementSettings resource string.
            #
            # The resource will be in the following format:
            #
            # `properties/{property}/webDataStreams/{web_data_stream}/enhancedMeasurementSettings`
            #
            # @param property [String]
            # @param web_data_stream [String]
            #
            # @return [::String]
            def enhanced_measurement_settings_path property:, web_data_stream:
              raise ::ArgumentError, "property cannot contain /" if property.to_s.include? "/"

              "properties/#{property}/webDataStreams/#{web_data_stream}/enhancedMeasurementSettings"
            end

            ##
            # Create a fully-qualified FirebaseLink resource string.
            #
            # The resource will be in the following format:
            #
            # `properties/{property}/firebaseLinks/{firebase_link}`
            #
            # @param property [String]
            # @param firebase_link [String]
            #
            # @return [::String]
            def firebase_link_path property:, firebase_link:
              raise ::ArgumentError, "property cannot contain /" if property.to_s.include? "/"

              "properties/#{property}/firebaseLinks/#{firebase_link}"
            end

            ##
            # Create a fully-qualified GlobalSiteTag resource string.
            #
            # The resource will be in the following format:
            #
            # `properties/{property}/globalSiteTag`
            #
            # @param property [String]
            #
            # @return [::String]
            def global_site_tag_path property:
              "properties/#{property}/globalSiteTag"
            end

            ##
            # Create a fully-qualified GoogleAdsLink resource string.
            #
            # The resource will be in the following format:
            #
            # `properties/{property}/googleAdsLinks/{google_ads_link}`
            #
            # @param property [String]
            # @param google_ads_link [String]
            #
            # @return [::String]
            def google_ads_link_path property:, google_ads_link:
              raise ::ArgumentError, "property cannot contain /" if property.to_s.include? "/"

              "properties/#{property}/googleAdsLinks/#{google_ads_link}"
            end

            ##
            # Create a fully-qualified GoogleSignalsSettings resource string.
            #
            # The resource will be in the following format:
            #
            # `properties/{property}/googleSignalsSettings`
            #
            # @param property [String]
            #
            # @return [::String]
            def google_signals_settings_path property:
              "properties/#{property}/googleSignalsSettings"
            end

            ##
            # Create a fully-qualified IosAppDataStream resource string.
            #
            # The resource will be in the following format:
            #
            # `properties/{property}/iosAppDataStreams/{ios_app_data_stream}`
            #
            # @param property [String]
            # @param ios_app_data_stream [String]
            #
            # @return [::String]
            def ios_app_data_stream_path property:, ios_app_data_stream:
              raise ::ArgumentError, "property cannot contain /" if property.to_s.include? "/"

              "properties/#{property}/iosAppDataStreams/#{ios_app_data_stream}"
            end

            ##
            # Create a fully-qualified MeasurementProtocolSecret resource string.
            #
            # The resource will be in the following format:
            #
            # `properties/{property}/webDataStreams/{web_data_stream}/measurementProtocolSecrets/{measurement_protocol_secret}`
            #
            # @param property [String]
            # @param web_data_stream [String]
            # @param measurement_protocol_secret [String]
            #
            # @return [::String]
            def measurement_protocol_secret_path property:, web_data_stream:, measurement_protocol_secret:
              raise ::ArgumentError, "property cannot contain /" if property.to_s.include? "/"
              raise ::ArgumentError, "web_data_stream cannot contain /" if web_data_stream.to_s.include? "/"

              "properties/#{property}/webDataStreams/#{web_data_stream}/measurementProtocolSecrets/#{measurement_protocol_secret}"
            end

            ##
            # Create a fully-qualified Property resource string.
            #
            # The resource will be in the following format:
            #
            # `properties/{property}`
            #
            # @param property [String]
            #
            # @return [::String]
            def property_path property:
              "properties/#{property}"
            end

            ##
            # Create a fully-qualified UserLink resource string.
            #
            # @overload user_link_path(account:, user_link:)
            #   The resource will be in the following format:
            #
            #   `accounts/{account}/userLinks/{user_link}`
            #
            #   @param account [String]
            #   @param user_link [String]
            #
            # @overload user_link_path(property:, user_link:)
            #   The resource will be in the following format:
            #
            #   `properties/{property}/userLinks/{user_link}`
            #
            #   @param property [String]
            #   @param user_link [String]
            #
            # @return [::String]
            def user_link_path **args
              resources = {
                "account:user_link" => (proc do |account:, user_link:|
                  raise ::ArgumentError, "account cannot contain /" if account.to_s.include? "/"

                  "accounts/#{account}/userLinks/#{user_link}"
                end),
                "property:user_link" => (proc do |property:, user_link:|
                  raise ::ArgumentError, "property cannot contain /" if property.to_s.include? "/"

                  "properties/#{property}/userLinks/#{user_link}"
                end)
              }

              resource = resources[args.keys.sort.join(":")]
              raise ::ArgumentError, "no resource found for values #{args.keys}" if resource.nil?
              resource.call(**args)
            end

            ##
            # Create a fully-qualified WebDataStream resource string.
            #
            # The resource will be in the following format:
            #
            # `properties/{property}/webDataStreams/{web_data_stream}`
            #
            # @param property [String]
            # @param web_data_stream [String]
            #
            # @return [::String]
            def web_data_stream_path property:, web_data_stream:
              raise ::ArgumentError, "property cannot contain /" if property.to_s.include? "/"

              "properties/#{property}/webDataStreams/#{web_data_stream}"
            end

            extend self
          end
        end
      end
    end
  end
end
