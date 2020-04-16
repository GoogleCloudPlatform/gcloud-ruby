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
  module Iam
    module V1
      # Request message for `SetIamPolicy` method.
      # @!attribute [rw] resource
      #   @return [String]
      #     REQUIRED: The resource for which the policy is being specified.
      #     See the operation documentation for the appropriate value for this field.
      # @!attribute [rw] policy
      #   @return [Google::Iam::V1::Policy]
      #     REQUIRED: The complete policy to be applied to the `resource`. The size of
      #     the policy is limited to a few 10s of KB. An empty policy is a
      #     valid policy but certain Cloud Platform services (such as Projects)
      #     might reject them.
      class SetIamPolicyRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # Request message for `GetIamPolicy` method.
      # @!attribute [rw] resource
      #   @return [String]
      #     REQUIRED: The resource for which the policy is being requested.
      #     See the operation documentation for the appropriate value for this field.
      # @!attribute [rw] options
      #   @return [Google::Iam::V1::GetPolicyOptions]
      #     OPTIONAL: A `GetPolicyOptions` object for specifying options to
      #     `GetIamPolicy`. This field is only used by Cloud IAM.
      class GetIamPolicyRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # Request message for `TestIamPermissions` method.
      # @!attribute [rw] resource
      #   @return [String]
      #     REQUIRED: The resource for which the policy detail is being requested.
      #     See the operation documentation for the appropriate value for this field.
      # @!attribute [rw] permissions
      #   @return [Array<String>]
      #     The set of permissions to check for the `resource`. Permissions with
      #     wildcards (such as '*' or 'storage.*') are not allowed. For more
      #     information see
      #     [IAM Overview](https://cloud.google.com/iam/docs/overview#permissions).
      class TestIamPermissionsRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # Response message for `TestIamPermissions` method.
      # @!attribute [rw] permissions
      #   @return [Array<String>]
      #     A subset of `TestPermissionsRequest.permissions` that the caller is
      #     allowed.
      class TestIamPermissionsResponse
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end
    end
  end
end
