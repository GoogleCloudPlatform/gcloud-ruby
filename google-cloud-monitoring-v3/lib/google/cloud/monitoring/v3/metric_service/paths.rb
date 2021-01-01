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
    module Monitoring
      module V3
        module MetricService
          # Path helper methods for the MetricService API.
          module Paths
            ##
            # Create a fully-qualified Folder resource string.
            #
            # The resource will be in the following format:
            #
            # `folders/{folder}`
            #
            # @param folder [String]
            #
            # @return [::String]
            def folder_path folder:
              "folders/#{folder}"
            end

            ##
            # Create a fully-qualified MetricDescriptor resource string.
            #
            # @overload metric_descriptor_path(project:, metric_descriptor:)
            #   The resource will be in the following format:
            #
            #   `projects/{project}/metricDescriptors/{metric_descriptor=**}`
            #
            #   @param project [String]
            #   @param metric_descriptor [String]
            #
            # @overload metric_descriptor_path(organization:, metric_descriptor:)
            #   The resource will be in the following format:
            #
            #   `organizations/{organization}/metricDescriptors/{metric_descriptor=**}`
            #
            #   @param organization [String]
            #   @param metric_descriptor [String]
            #
            # @overload metric_descriptor_path(folder:, metric_descriptor:)
            #   The resource will be in the following format:
            #
            #   `folders/{folder}/metricDescriptors/{metric_descriptor=**}`
            #
            #   @param folder [String]
            #   @param metric_descriptor [String]
            #
            # @return [::String]
            def metric_descriptor_path **args
              resources = {
                "metric_descriptor:project"      => (proc do |project:, metric_descriptor:|
                  raise ::ArgumentError, "project cannot contain /" if project.to_s.include? "/"

                  "projects/#{project}/metricDescriptors/#{metric_descriptor}"
                end),
                "metric_descriptor:organization" => (proc do |organization:, metric_descriptor:|
                  raise ::ArgumentError, "organization cannot contain /" if organization.to_s.include? "/"

                  "organizations/#{organization}/metricDescriptors/#{metric_descriptor}"
                end),
                "folder:metric_descriptor"       => (proc do |folder:, metric_descriptor:|
                  raise ::ArgumentError, "folder cannot contain /" if folder.to_s.include? "/"

                  "folders/#{folder}/metricDescriptors/#{metric_descriptor}"
                end)
              }

              resource = resources[args.keys.sort.join(":")]
              raise ::ArgumentError, "no resource found for values #{args.keys}" if resource.nil?
              resource.call(**args)
            end

            ##
            # Create a fully-qualified MonitoredResourceDescriptor resource string.
            #
            # @overload monitored_resource_descriptor_path(project:, monitored_resource_descriptor:)
            #   The resource will be in the following format:
            #
            #   `projects/{project}/monitoredResourceDescriptors/{monitored_resource_descriptor}`
            #
            #   @param project [String]
            #   @param monitored_resource_descriptor [String]
            #
            # @overload monitored_resource_descriptor_path(organization:, monitored_resource_descriptor:)
            #   The resource will be in the following format:
            #
            #   `organizations/{organization}/monitoredResourceDescriptors/{monitored_resource_descriptor}`
            #
            #   @param organization [String]
            #   @param monitored_resource_descriptor [String]
            #
            # @overload monitored_resource_descriptor_path(folder:, monitored_resource_descriptor:)
            #   The resource will be in the following format:
            #
            #   `folders/{folder}/monitoredResourceDescriptors/{monitored_resource_descriptor}`
            #
            #   @param folder [String]
            #   @param monitored_resource_descriptor [String]
            #
            # @return [::String]
            def monitored_resource_descriptor_path **args
              resources = {
                "monitored_resource_descriptor:project"      => (proc do |project:, monitored_resource_descriptor:|
                  raise ::ArgumentError, "project cannot contain /" if project.to_s.include? "/"

                  "projects/#{project}/monitoredResourceDescriptors/#{monitored_resource_descriptor}"
                end),
                "monitored_resource_descriptor:organization" => (proc do |organization:, monitored_resource_descriptor:|
                  raise ::ArgumentError, "organization cannot contain /" if organization.to_s.include? "/"

                  "organizations/#{organization}/monitoredResourceDescriptors/#{monitored_resource_descriptor}"
                end),
                "folder:monitored_resource_descriptor"       => (proc do |folder:, monitored_resource_descriptor:|
                  raise ::ArgumentError, "folder cannot contain /" if folder.to_s.include? "/"

                  "folders/#{folder}/monitoredResourceDescriptors/#{monitored_resource_descriptor}"
                end)
              }

              resource = resources[args.keys.sort.join(":")]
              raise ::ArgumentError, "no resource found for values #{args.keys}" if resource.nil?
              resource.call(**args)
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
            # Create a fully-qualified Project resource string.
            #
            # The resource will be in the following format:
            #
            # `projects/{project}`
            #
            # @param project [String]
            #
            # @return [::String]
            def project_path project:
              "projects/#{project}"
            end

            extend self
          end
        end
      end
    end
  end
end
