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
    module SecurityCenter
      module V1p1beta1
        # User specified security marks that are attached to the parent Security
        # Command Center resource. Security marks are scoped within a Security Command
        # Center organization -- they can be modified and viewed by all users who have
        # proper permissions on the organization.
        # @!attribute [rw] name
        #   @return [::String]
        #     The relative resource name of the SecurityMarks. See:
        #     https://cloud.google.com/apis/design/resource_names#relative_resource_name
        #     Examples:
        #     "organizations/\\{organization_id}/assets/\\{asset_id}/securityMarks"
        #     "organizations/\\{organization_id}/sources/\\{source_id}/findings/\\{finding_id}/securityMarks".
        # @!attribute [rw] marks
        #   @return [::Google::Protobuf::Map{::String => ::String}]
        #     Mutable user specified security marks belonging to the parent resource.
        #     Constraints are as follows:
        #
        #       * Keys and values are treated as case insensitive
        #       * Keys must be between 1 - 256 characters (inclusive)
        #       * Keys must be letters, numbers, underscores, or dashes
        #       * Values have leading and trailing whitespace trimmed, remaining
        #         characters must be between 1 - 4096 characters (inclusive)
        class SecurityMarks
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods

          # @!attribute [rw] key
          #   @return [::String]
          # @!attribute [rw] value
          #   @return [::String]
          class MarksEntry
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end
        end
      end
    end
  end
end
