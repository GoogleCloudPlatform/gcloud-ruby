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
      module V3
        # A description of a notification channel. The descriptor includes
        # the properties of the channel and the set of labels or fields that
        # must be specified to configure channels of a given type.
        # @!attribute [rw] name
        #   @return [String]
        #     The full REST resource name for this descriptor. The format is:
        #
        #         projects/[PROJECT_ID_OR_NUMBER]/notificationChannelDescriptors/[TYPE]
        #
        #     In the above, `[TYPE]` is the value of the `type` field.
        # @!attribute [rw] type
        #   @return [String]
        #     The type of notification channel, such as "email", "sms", etc.
        #     Notification channel types are globally unique.
        # @!attribute [rw] display_name
        #   @return [String]
        #     A human-readable name for the notification channel type.  This
        #     form of the name is suitable for a user interface.
        # @!attribute [rw] description
        #   @return [String]
        #     A human-readable description of the notification channel
        #     type. The description may include a description of the properties
        #     of the channel and pointers to external documentation.
        # @!attribute [rw] labels
        #   @return [Array<Google::Api::LabelDescriptor>]
        #     The set of labels that must be defined to identify a particular
        #     channel of the corresponding type. Each label includes a
        #     description for how that field should be populated.
        # @!attribute [rw] supported_tiers
        #   @return [Array<Google::Cloud::Monitoring::V3::ServiceTier>]
        #     The tiers that support this notification channel; the project service tier
        #     must be one of the supported_tiers.
        # @!attribute [rw] launch_stage
        #   @return [Google::Api::LaunchStage]
        #     The product launch stage for channels of this type.
        class NotificationChannelDescriptor
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # A `NotificationChannel` is a medium through which an alert is
        # delivered when a policy violation is detected. Examples of channels
        # include email, SMS, and third-party messaging applications. Fields
        # containing sensitive information like authentication tokens or
        # contact info are only partially populated on retrieval.
        # @!attribute [rw] type
        #   @return [String]
        #     The type of the notification channel. This field matches the
        #     value of the {Google::Cloud::Monitoring::V3::NotificationChannelDescriptor#type NotificationChannelDescriptor.type} field.
        # @!attribute [rw] name
        #   @return [String]
        #     The full REST resource name for this channel. The format is:
        #
        #         projects/[PROJECT_ID_OR_NUMBER]/notificationChannels/[CHANNEL_ID]
        #
        #     The `[CHANNEL_ID]` is automatically assigned by the server on creation.
        # @!attribute [rw] display_name
        #   @return [String]
        #     An optional human-readable name for this notification channel. It is
        #     recommended that you specify a non-empty and unique name in order to
        #     make it easier to identify the channels in your project, though this is
        #     not enforced. The display name is limited to 512 Unicode characters.
        # @!attribute [rw] description
        #   @return [String]
        #     An optional human-readable description of this notification channel. This
        #     description may provide additional details, beyond the display
        #     name, for the channel. This may not exceed 1024 Unicode characters.
        # @!attribute [rw] labels
        #   @return [Google::Protobuf::Map{String => String}]
        #     Configuration fields that define the channel and its behavior. The
        #     permissible and required labels are specified in the
        #     {Google::Cloud::Monitoring::V3::NotificationChannelDescriptor#labels NotificationChannelDescriptor.labels} of the
        #     `NotificationChannelDescriptor` corresponding to the `type` field.
        # @!attribute [rw] user_labels
        #   @return [Google::Protobuf::Map{String => String}]
        #     User-supplied key/value data that does not need to conform to
        #     the corresponding `NotificationChannelDescriptor`'s schema, unlike
        #     the `labels` field. This field is intended to be used for organizing
        #     and identifying the `NotificationChannel` objects.
        #
        #     The field can contain up to 64 entries. Each key and value is limited to
        #     63 Unicode characters or 128 bytes, whichever is smaller. Labels and
        #     values can contain only lowercase letters, numerals, underscores, and
        #     dashes. Keys must begin with a letter.
        # @!attribute [rw] verification_status
        #   @return [Google::Cloud::Monitoring::V3::NotificationChannel::VerificationStatus]
        #     Indicates whether this channel has been verified or not. On a
        #     [`ListNotificationChannels`][google.monitoring.v3.NotificationChannelService.ListNotificationChannels]
        #     or
        #     [`GetNotificationChannel`][google.monitoring.v3.NotificationChannelService.GetNotificationChannel]
        #     operation, this field is expected to be populated.
        #
        #     If the value is `UNVERIFIED`, then it indicates that the channel is
        #     non-functioning (it both requires verification and lacks verification);
        #     otherwise, it is assumed that the channel works.
        #
        #     If the channel is neither `VERIFIED` nor `UNVERIFIED`, it implies that
        #     the channel is of a type that does not require verification or that
        #     this specific channel has been exempted from verification because it was
        #     created prior to verification being required for channels of this type.
        #
        #     This field cannot be modified using a standard
        #     [`UpdateNotificationChannel`][google.monitoring.v3.NotificationChannelService.UpdateNotificationChannel]
        #     operation. To change the value of this field, you must call
        #     [`VerifyNotificationChannel`][google.monitoring.v3.NotificationChannelService.VerifyNotificationChannel].
        # @!attribute [rw] enabled
        #   @return [Google::Protobuf::BoolValue]
        #     Whether notifications are forwarded to the described channel. This makes
        #     it possible to disable delivery of notifications to a particular channel
        #     without removing the channel from all alerting policies that reference
        #     the channel. This is a more convenient approach when the change is
        #     temporary and you want to receive notifications from the same set
        #     of alerting policies on the channel at some point in the future.
        class NotificationChannel
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods

          # @!attribute [rw] key
          #   @return [String]
          # @!attribute [rw] value
          #   @return [String]
          class LabelsEntry
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # @!attribute [rw] key
          #   @return [String]
          # @!attribute [rw] value
          #   @return [String]
          class UserLabelsEntry
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # Indicates whether the channel has been verified or not. It is illegal
          # to specify this field in a
          # [`CreateNotificationChannel`][google.monitoring.v3.NotificationChannelService.CreateNotificationChannel]
          # or an
          # [`UpdateNotificationChannel`][google.monitoring.v3.NotificationChannelService.UpdateNotificationChannel]
          # operation.
          module VerificationStatus
            # Sentinel value used to indicate that the state is unknown, omitted, or
            # is not applicable (as in the case of channels that neither support
            # nor require verification in order to function).
            VERIFICATION_STATUS_UNSPECIFIED = 0

            # The channel has yet to be verified and requires verification to function.
            # Note that this state also applies to the case where the verification
            # process has been initiated by sending a verification code but where
            # the verification code has not been submitted to complete the process.
            UNVERIFIED = 1

            # It has been proven that notifications can be received on this
            # notification channel and that someone on the project has access
            # to messages that are delivered to that channel.
            VERIFIED = 2
          end
        end
      end
    end
  end
end
