# Copyright 2019 Google LLC
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
    module SecretManager
      module V1beta1
        # A {Google::Cloud::SecretManager::V1beta1::Secret Secret} is a logical secret whose value and versions can
        # be accessed.
        #
        # A {Google::Cloud::SecretManager::V1beta1::Secret Secret} is made up of zero or more {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersions} that
        # represent the secret data.
        # @!attribute [rw] name
        #   @return [String]
        #     Output only. The resource name of the {Google::Cloud::SecretManager::V1beta1::Secret Secret} in the format `projects/*/secrets/*`.
        # @!attribute [rw] replication
        #   @return [Google::Cloud::SecretManager::V1beta1::Replication]
        #     Required. Immutable. The replication policy of the secret data attached to the {Google::Cloud::SecretManager::V1beta1::Secret Secret}.
        #
        #     The replication policy cannot be changed after the Secret has been created.
        # @!attribute [rw] create_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time at which the {Google::Cloud::SecretManager::V1beta1::Secret Secret} was created.
        # @!attribute [rw] labels
        #   @return [Hash{String => String}]
        #     The labels assigned to this Secret.
        #
        #     Label keys must be between 1 and 63 characters long, have a UTF-8 encoding
        #     of maximum 128 bytes, and must conform to the following PCRE regular
        #     expression: `[\p{Ll}\p{Lo}][\p{Ll}\p{Lo}\p{N}_-]{0,62}`
        #
        #     Label values must be between 0 and 63 characters long, have a UTF-8
        #     encoding of maximum 128 bytes, and must conform to the following PCRE
        #     regular expression: `[\p{Ll}\p{Lo}\p{N}_-]{0,63}`
        #
        #     No more than 64 labels can be assigned to a given resource.
        class Secret; end

        # A secret version resource in the Secret Manager API.
        # @!attribute [rw] name
        #   @return [String]
        #     Output only. The resource name of the {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} in the
        #     format `projects/*/secrets/*/versions/*`.
        #
        #     {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} IDs in a {Google::Cloud::SecretManager::V1beta1::Secret Secret} start at 1 and
        #     are incremented for each subsequent version of the secret.
        # @!attribute [rw] create_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time at which the {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} was created.
        # @!attribute [rw] destroy_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time this {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} was destroyed.
        #     Only present if {Google::Cloud::SecretManager::V1beta1::SecretVersion#state state} is
        #     {Google::Cloud::SecretManager::V1beta1::SecretVersion::State::DESTROYED DESTROYED}.
        # @!attribute [rw] state
        #   @return [Google::Cloud::SecretManager::V1beta1::SecretVersion::State]
        #     Output only. The current state of the {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion}.
        class SecretVersion
          # The state of a {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion}, indicating if it can be accessed.
          module State
            # Not specified. This value is unused and invalid.
            STATE_UNSPECIFIED = 0

            # The {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} may be accessed.
            ENABLED = 1

            # The {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} may not be accessed, but the secret data
            # is still available and can be placed back into the {Google::Cloud::SecretManager::V1beta1::SecretVersion::State::ENABLED ENABLED}
            # state.
            DISABLED = 2

            # The {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} is destroyed and the secret data is no longer
            # stored. A version may not leave this state once entered.
            DESTROYED = 3
          end
        end

        # A policy that defines the replication configuration of data.
        # @!attribute [rw] automatic
        #   @return [Google::Cloud::SecretManager::V1beta1::Replication::Automatic]
        #     The {Google::Cloud::SecretManager::V1beta1::Secret Secret} will automatically be replicated without any restrictions.
        # @!attribute [rw] user_managed
        #   @return [Google::Cloud::SecretManager::V1beta1::Replication::UserManaged]
        #     The {Google::Cloud::SecretManager::V1beta1::Secret Secret} will only be replicated into the locations specified.
        class Replication
          # A replication policy that replicates the {Google::Cloud::SecretManager::V1beta1::Secret Secret} payload without any
          # restrictions.
          class Automatic; end

          # A replication policy that replicates the {Google::Cloud::SecretManager::V1beta1::Secret Secret} payload into the
          # locations specified in {Secret#replication#user_managed#replicas}
          # @!attribute [rw] replicas
          #   @return [Array<Google::Cloud::SecretManager::V1beta1::Replication::UserManaged::Replica>]
          #     Required. The list of Replicas for this {Google::Cloud::SecretManager::V1beta1::Secret Secret}.
          #
          #     Cannot be empty.
          class UserManaged
            # Represents a Replica for this {Google::Cloud::SecretManager::V1beta1::Secret Secret}.
            # @!attribute [rw] location
            #   @return [String]
            #     The canonical IDs of the location to replicate data.
            #     For example: `"us-east1"`.
            class Replica; end
          end
        end

        # A secret payload resource in the Secret Manager API. This contains the
        # sensitive secret data that is associated with a {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion}.
        # @!attribute [rw] data
        #   @return [String]
        #     The secret data. Must be no larger than 64KiB.
        class SecretPayload; end
      end
    end
  end
end