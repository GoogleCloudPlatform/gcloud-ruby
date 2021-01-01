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


module Google
  module Cloud
    module SecurityCenter
      module V1
        module SecurityCenter
          # Path helper methods for the SecurityCenter API.
          module Paths
            ##
            # Create a fully-qualified Finding resource string.
            #
            # The resource will be in the following format:
            #
            # `organizations/{organization}/sources/{source}/findings/{finding}`
            #
            # @param organization [String]
            # @param source [String]
            # @param finding [String]
            #
            # @return [::String]
            def finding_path organization:, source:, finding:
              raise ::ArgumentError, "organization cannot contain /" if organization.to_s.include? "/"
              raise ::ArgumentError, "source cannot contain /" if source.to_s.include? "/"

              "organizations/#{organization}/sources/#{source}/findings/#{finding}"
            end

            ##
            # Create a fully-qualified NotificationConfig resource string.
            #
            # The resource will be in the following format:
            #
            # `organizations/{organization}/notificationConfigs/{notification_config}`
            #
            # @param organization [String]
            # @param notification_config [String]
            #
            # @return [::String]
            def notification_config_path organization:, notification_config:
              raise ::ArgumentError, "organization cannot contain /" if organization.to_s.include? "/"

              "organizations/#{organization}/notificationConfigs/#{notification_config}"
            end

            ##
            # Create a fully-qualified Organization resource string.
            #
            # The resource will be in the following format:
            #
            # `organizations/{organization}`
            #
            # @param organization [String]
            #
            # @return [::String]
            def organization_path organization:
              "organizations/#{organization}"
            end

            ##
            # Create a fully-qualified OrganizationSettings resource string.
            #
            # The resource will be in the following format:
            #
            # `organizations/{organization}/organizationSettings`
            #
            # @param organization [String]
            #
            # @return [::String]
            def organization_settings_path organization:
              "organizations/#{organization}/organizationSettings"
            end

            ##
            # Create a fully-qualified SecurityMarks resource string.
            #
            # @overload security_marks_path(organization:, asset:)
            #   The resource will be in the following format:
            #
            #   `organizations/{organization}/assets/{asset}/securityMarks`
            #
            #   @param organization [String]
            #   @param asset [String]
            #
            # @overload security_marks_path(organization:, source:, finding:)
            #   The resource will be in the following format:
            #
            #   `organizations/{organization}/sources/{source}/findings/{finding}/securityMarks`
            #
            #   @param organization [String]
            #   @param source [String]
            #   @param finding [String]
            #
            # @return [::String]
            def security_marks_path **args
              resources = {
                "asset:organization"          => (proc do |organization:, asset:|
                  raise ::ArgumentError, "organization cannot contain /" if organization.to_s.include? "/"

                  "organizations/#{organization}/assets/#{asset}/securityMarks"
                end),
                "finding:organization:source" => (proc do |organization:, source:, finding:|
                  raise ::ArgumentError, "organization cannot contain /" if organization.to_s.include? "/"
                  raise ::ArgumentError, "source cannot contain /" if source.to_s.include? "/"

                  "organizations/#{organization}/sources/#{source}/findings/#{finding}/securityMarks"
                end)
              }

              resource = resources[args.keys.sort.join(":")]
              raise ::ArgumentError, "no resource found for values #{args.keys}" if resource.nil?
              resource.call(**args)
            end

            ##
            # Create a fully-qualified Source resource string.
            #
            # The resource will be in the following format:
            #
            # `organizations/{organization}/sources/{source}`
            #
            # @param organization [String]
            # @param source [String]
            #
            # @return [::String]
            def source_path organization:, source:
              raise ::ArgumentError, "organization cannot contain /" if organization.to_s.include? "/"

              "organizations/#{organization}/sources/#{source}"
            end

            ##
            # Create a fully-qualified Topic resource string.
            #
            # The resource will be in the following format:
            #
            # `projects/{project}/topics/{topic}`
            #
            # @param project [String]
            # @param topic [String]
            #
            # @return [::String]
            def topic_path project:, topic:
              raise ::ArgumentError, "project cannot contain /" if project.to_s.include? "/"

              "projects/#{project}/topics/#{topic}"
            end

            extend self
          end
        end
      end
    end
  end
end
