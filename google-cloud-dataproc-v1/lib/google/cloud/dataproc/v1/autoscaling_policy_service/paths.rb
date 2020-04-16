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
  module Cloud
    module Dataproc
      module V1
        module AutoscalingPolicyService
          # Path helper methods for the AutoscalingPolicyService API.
          module Paths
            ##
            # Create a fully-qualified AutoscalingPolicy resource string.
            #
            # @overload autoscaling_policy_path(project:, location:, autoscaling_policy:)
            #   The resource will be in the following format:
            #
            #   `projects/{project}/locations/{location}/autoscalingPolicies/{autoscaling_policy}`
            #
            #   @param project [String]
            #   @param location [String]
            #   @param autoscaling_policy [String]
            #
            # @overload autoscaling_policy_path(project:, region:, autoscaling_policy:)
            #   The resource will be in the following format:
            #
            #   `projects/{project}/regions/{region}/autoscalingPolicies/{autoscaling_policy}`
            #
            #   @param project [String]
            #   @param region [String]
            #   @param autoscaling_policy [String]
            #
            # @return [String]
            def autoscaling_policy_path **args
              resources = {
                "autoscaling_policy:location:project" => (proc do |project:, location:, autoscaling_policy:|
                  raise ArgumentError, "project cannot contain /" if project.to_s.include? "/"
                  raise ArgumentError, "location cannot contain /" if location.to_s.include? "/"

                  "projects/#{project}/locations/#{location}/autoscalingPolicies/#{autoscaling_policy}"
                end),
                "autoscaling_policy:project:region"   => (proc do |project:, region:, autoscaling_policy:|
                  raise ArgumentError, "project cannot contain /" if project.to_s.include? "/"
                  raise ArgumentError, "region cannot contain /" if region.to_s.include? "/"

                  "projects/#{project}/regions/#{region}/autoscalingPolicies/#{autoscaling_policy}"
                end)
              }

              resource = resources[args.keys.sort.join(":")]
              raise ArgumentError, "no resource found for values #{args.keys}" if resource.nil?
              resource.call(**args)
            end

            ##
            # Create a fully-qualified Location resource string.
            #
            # The resource will be in the following format:
            #
            # `projects/{project}/locations/{location}`
            #
            # @param project [String]
            # @param location [String]
            #
            # @return [String]
            def location_path project:, location:
              raise ArgumentError, "project cannot contain /" if project.to_s.include? "/"

              "projects/#{project}/locations/#{location}"
            end

            ##
            # Create a fully-qualified Region resource string.
            #
            # The resource will be in the following format:
            #
            # `projects/{project}/regions/{region}`
            #
            # @param project [String]
            # @param region [String]
            #
            # @return [String]
            def region_path project:, region:
              raise ArgumentError, "project cannot contain /" if project.to_s.include? "/"

              "projects/#{project}/regions/#{region}"
            end

            extend self
          end
        end
      end
    end
  end
end
