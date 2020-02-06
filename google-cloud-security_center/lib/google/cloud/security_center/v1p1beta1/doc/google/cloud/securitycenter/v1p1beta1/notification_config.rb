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


module Google
  module Cloud
    module Securitycenter
      module V1p1beta1
        # Cloud Security Command Center (Cloud SCC) notification configs.
        #
        # A notification config is a Cloud SCC resource that contains the configuration
        # to send notifications for create/update events of findings, assets and etc.
        # @!attribute [rw] name
        #   @return [String]
        #     The relative resource name of this notification config. See:
        #     https://cloud.google.com/apis/design/resource_names#relative_resource_name
        #     Example:
        #     "organizations/{organization_id}/notificationConfigs/notify_public_bucket".
        # @!attribute [rw] description
        #   @return [String]
        #     The description of the notification config (max of 1024 characters).
        # @!attribute [rw] event_type
        #   @return [Google::Cloud::SecurityCenter::V1p1beta1::NotificationConfig::EventType]
        #     The type of events the config is for, e.g. FINDING.
        # @!attribute [rw] pubsub_topic
        #   @return [String]
        #     The PubSub topic to send notifications to. Its format is
        #     "projects/[project_id]/topics/[topic]".
        # @!attribute [rw] service_account
        #   @return [String]
        #     Output only. The service account that needs "pubsub.topics.publish"
        #     permission to publish to the PubSub topic.
        # @!attribute [rw] streaming_config
        #   @return [Google::Cloud::SecurityCenter::V1p1beta1::NotificationConfig::StreamingConfig]
        #     The config for triggering streaming-based notifications.
        class NotificationConfig
          # The config for streaming-based notifications, which send each event as soon
          # as it is detected.
          # @!attribute [rw] filter
          #   @return [String]
          #     Expression that defines the filter to apply across create/update events
          #     of assets or findings as specified by the event type. The expression is a
          #     list of zero or more restrictions combined via logical operators `AND`
          #     and `OR`. Parentheses are supported, and `OR` has higher precedence than
          #     `AND`.
          #
          #     Restrictions have the form `<field> <operator> <value>` and may have a
          #     `-` character in front of them to indicate negation. The fields map to
          #     those defined in the corresponding resource.
          #
          #     The supported operators are:
          #
          #     * `=` for all value types.
          #     * `>`, `<`, `>=`, `<=` for integer values.
          #     * `:`, meaning substring matching, for strings.
          #
          #     The supported value types are:
          #
          #     * string literals in quotes.
          #     * integer literals without quotes.
          #     * boolean literals `true` and `false` without quotes.
          class StreamingConfig; end

          # The type of events.
          module EventType
            # Unspecified event type.
            EVENT_TYPE_UNSPECIFIED = 0

            # Events for findings.
            FINDING = 1
          end
        end
      end
    end
  end
end