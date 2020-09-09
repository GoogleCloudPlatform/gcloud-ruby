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
        # Security Command Center finding.
        #
        # A finding is a record of assessment data (security, risk, health or privacy)
        # ingested into Security Command Center for presentation, notification,
        # analysis, policy testing, and enforcement. For example, an XSS vulnerability
        # in an App Engine application is a finding.
        # @!attribute [rw] name
        #   @return [::String]
        #     The relative resource name of this finding. See:
        #     https://cloud.google.com/apis/design/resource_names#relative_resource_name
        #     Example:
        #     "organizations/\\{organization_id}/sources/\\{source_id}/findings/\\{finding_id}"
        # @!attribute [rw] parent
        #   @return [::String]
        #     The relative resource name of the source the finding belongs to. See:
        #     https://cloud.google.com/apis/design/resource_names#relative_resource_name
        #     This field is immutable after creation time.
        #     For example:
        #     "organizations/\\{organization_id}/sources/\\{source_id}"
        # @!attribute [rw] resource_name
        #   @return [::String]
        #     For findings on Google Cloud resources, the full resource
        #     name of the Google Cloud resource this finding is for. See:
        #     https://cloud.google.com/apis/design/resource_names#full_resource_name
        #     When the finding is for a non-Google Cloud resource, the resourceName can
        #     be a customer or partner defined string. This field is immutable after
        #     creation time.
        # @!attribute [rw] state
        #   @return [::Google::Cloud::SecurityCenter::V1p1beta1::Finding::State]
        #     The state of the finding.
        # @!attribute [rw] category
        #   @return [::String]
        #     The additional taxonomy group within findings from a given source.
        #     This field is immutable after creation time.
        #     Example: "XSS_FLASH_INJECTION"
        # @!attribute [rw] external_uri
        #   @return [::String]
        #     The URI that, if available, points to a web page outside of Security
        #     Command Center where additional information about the finding can be found.
        #     This field is guaranteed to be either empty or a well formed URL.
        # @!attribute [rw] source_properties
        #   @return [::Google::Protobuf::Map{::String => ::Google::Protobuf::Value}]
        #     Source specific properties. These properties are managed by the source
        #     that writes the finding. The key names in the source_properties map must be
        #     between 1 and 255 characters, and must start with a letter and contain
        #     alphanumeric characters or underscores only.
        # @!attribute [r] security_marks
        #   @return [::Google::Cloud::SecurityCenter::V1p1beta1::SecurityMarks]
        #     Output only. User specified security marks. These marks are entirely
        #     managed by the user and come from the SecurityMarks resource that belongs
        #     to the finding.
        # @!attribute [rw] event_time
        #   @return [::Google::Protobuf::Timestamp]
        #     The time at which the event took place, or when an update to the finding
        #     occurred. For example, if the finding represents an open firewall it would
        #     capture the time the detector believes the firewall became open. The
        #     accuracy is determined by the detector. If the finding were to be resolved
        #     afterward, this time would reflect when the finding was resolved.
        # @!attribute [rw] create_time
        #   @return [::Google::Protobuf::Timestamp]
        #     The time at which the finding was created in Security Command Center.
        # @!attribute [rw] severity
        #   @return [::Google::Cloud::SecurityCenter::V1p1beta1::Finding::Severity]
        #     The severity of the finding.
        class Finding
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods

          # @!attribute [rw] key
          #   @return [::String]
          # @!attribute [rw] value
          #   @return [::Google::Protobuf::Value]
          class SourcePropertiesEntry
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # The state of the finding.
          module State
            # Unspecified state.
            STATE_UNSPECIFIED = 0

            # The finding requires attention and has not been addressed yet.
            ACTIVE = 1

            # The finding has been fixed, triaged as a non-issue or otherwise addressed
            # and is no longer active.
            INACTIVE = 2
          end

          # The severity of the finding.
          module Severity
            # No severity specified. The default value.
            SEVERITY_UNSPECIFIED = 0

            # Critical severity.
            CRITICAL = 1

            # High severity.
            HIGH = 2

            # Medium severity.
            MEDIUM = 3

            # Low severity.
            LOW = 4
          end
        end
      end
    end
  end
end
