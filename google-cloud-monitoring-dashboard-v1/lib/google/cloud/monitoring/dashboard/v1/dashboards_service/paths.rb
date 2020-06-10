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
    module Monitoring
      module Dashboard
        module V1
          module DashboardsService
            # Path helper methods for the DashboardsService API.
            module Paths
              ##
              # Create a fully-qualified Dashboard resource string.
              #
              # The resource will be in the following format:
              #
              # `projects/{project}/dashboards/{dashboard}`
              #
              # @param project [String]
              # @param dashboard [String]
              #
              # @return [::String]
              def dashboard_path project:, dashboard:
                raise ::ArgumentError, "project cannot contain /" if project.to_s.include? "/"

                "projects/#{project}/dashboards/#{dashboard}"
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
end
