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
        # Request message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::ListSecrets SecretManagerService::ListSecrets}.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The resource name of the project associated with the
        #     {Google::Cloud::SecretManager::V1beta1::Secret Secrets}, in the format `projects/*`.
        # @!attribute [rw] page_size
        #   @return [Integer]
        #     Optional. The maximum number of results to be returned in a single page. If
        #     set to 0, the server decides the number of results to return. If the
        #     number is greater than 25000, it is capped at 25000.
        # @!attribute [rw] page_token
        #   @return [String]
        #     Optional. Pagination token, returned earlier via
        #     {Google::Cloud::SecretManager::V1beta1::ListSecretsResponse#next_page_token ListSecretsResponse#next_page_token}.
        class ListSecretsRequest; end

        # Response message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::ListSecrets SecretManagerService::ListSecrets}.
        # @!attribute [rw] secrets
        #   @return [Array<Google::Cloud::SecretManager::V1beta1::Secret>]
        #     The list of {Google::Cloud::SecretManager::V1beta1::Secret Secrets} sorted in reverse by create_time (newest
        #     first).
        # @!attribute [rw] next_page_token
        #   @return [String]
        #     A token to retrieve the next page of results. Pass this value in
        #     {Google::Cloud::SecretManager::V1beta1::ListSecretsRequest#page_token ListSecretsRequest#page_token} to retrieve the next page.
        # @!attribute [rw] total_size
        #   @return [Integer]
        #     The total number of {Google::Cloud::SecretManager::V1beta1::Secret Secrets}.
        class ListSecretsResponse; end

        # Request message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::CreateSecret SecretManagerService::CreateSecret}.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The resource name of the project to associate with the
        #     {Google::Cloud::SecretManager::V1beta1::Secret Secret}, in the format `projects/*`.
        # @!attribute [rw] secret_id
        #   @return [String]
        #     Required. This must be unique within the project.
        # @!attribute [rw] secret
        #   @return [Google::Cloud::SecretManager::V1beta1::Secret]
        #     A {Google::Cloud::SecretManager::V1beta1::Secret Secret} with initial field values.
        class CreateSecretRequest; end

        # Request message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::AddSecretVersion SecretManagerService::AddSecretVersion}.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The resource name of the {Google::Cloud::SecretManager::V1beta1::Secret Secret} to associate with the
        #     {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} in the format `projects/*/secrets/*`.
        # @!attribute [rw] payload
        #   @return [Google::Cloud::SecretManager::V1beta1::SecretPayload]
        #     Required. The secret payload of the {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion}.
        class AddSecretVersionRequest; end

        # Request message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::GetSecret SecretManagerService::GetSecret}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The resource name of the {Google::Cloud::SecretManager::V1beta1::Secret Secret}, in the format `projects/*/secrets/*`.
        class GetSecretRequest; end

        # Request message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::ListSecretVersions SecretManagerService::ListSecretVersions}.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The resource name of the {Google::Cloud::SecretManager::V1beta1::Secret Secret} associated with the
        #     {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersions} to list, in the format
        #     `projects/*/secrets/*`.
        # @!attribute [rw] page_size
        #   @return [Integer]
        #     Optional. The maximum number of results to be returned in a single page. If
        #     set to 0, the server decides the number of results to return. If the
        #     number is greater than 25000, it is capped at 25000.
        # @!attribute [rw] page_token
        #   @return [String]
        #     Optional. Pagination token, returned earlier via
        #     ListSecretVersionsResponse.next_page_token][].
        class ListSecretVersionsRequest; end

        # Response message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::ListSecretVersions SecretManagerService::ListSecretVersions}.
        # @!attribute [rw] versions
        #   @return [Array<Google::Cloud::SecretManager::V1beta1::SecretVersion>]
        #     The list of {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersions} sorted in reverse by
        #     create_time (newest first).
        # @!attribute [rw] next_page_token
        #   @return [String]
        #     A token to retrieve the next page of results. Pass this value in
        #     {Google::Cloud::SecretManager::V1beta1::ListSecretVersionsRequest#page_token ListSecretVersionsRequest#page_token} to retrieve the next page.
        # @!attribute [rw] total_size
        #   @return [Integer]
        #     The total number of {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersions}.
        class ListSecretVersionsResponse; end

        # Request message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::GetSecretVersion SecretManagerService::GetSecretVersion}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The resource name of the {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} in the format
        #     `projects/*/secrets/*/versions/*`.
        #     `projects/*/secrets/*/versions/latest` is an alias to the `latest`
        #     {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion}.
        class GetSecretVersionRequest; end

        # Request message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::UpdateSecret SecretManagerService::UpdateSecret}.
        # @!attribute [rw] secret
        #   @return [Google::Cloud::SecretManager::V1beta1::Secret]
        #     Required. {Google::Cloud::SecretManager::V1beta1::Secret Secret} with updated field values.
        # @!attribute [rw] update_mask
        #   @return [Google::Protobuf::FieldMask]
        #     Required. Specifies the fields to be updated.
        class UpdateSecretRequest; end

        # Request message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::AccessSecretVersion SecretManagerService::AccessSecretVersion}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The resource name of the {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} in the format
        #     `projects/*/secrets/*/versions/*`.
        class AccessSecretVersionRequest; end

        # Response message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::AccessSecretVersion SecretManagerService::AccessSecretVersion}.
        # @!attribute [rw] name
        #   @return [String]
        #     The resource name of the {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} in the format
        #     `projects/*/secrets/*/versions/*`.
        # @!attribute [rw] payload
        #   @return [Google::Cloud::SecretManager::V1beta1::SecretPayload]
        #     Secret payload
        class AccessSecretVersionResponse; end

        # Request message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::DeleteSecret SecretManagerService::DeleteSecret}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The resource name of the {Google::Cloud::SecretManager::V1beta1::Secret Secret} to delete in the format
        #     `projects/*/secrets/*`.
        class DeleteSecretRequest; end

        # Request message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::DisableSecretVersion SecretManagerService::DisableSecretVersion}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The resource name of the {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} to disable in the format
        #     `projects/*/secrets/*/versions/*`.
        class DisableSecretVersionRequest; end

        # Request message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::EnableSecretVersion SecretManagerService::EnableSecretVersion}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The resource name of the {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} to enable in the format
        #     `projects/*/secrets/*/versions/*`.
        class EnableSecretVersionRequest; end

        # Request message for {Google::Cloud::SecretManager::V1beta1::SecretManagerService::DestroySecretVersion SecretManagerService::DestroySecretVersion}.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The resource name of the {Google::Cloud::SecretManager::V1beta1::SecretVersion SecretVersion} to destroy in the format
        #     `projects/*/secrets/*/versions/*`.
        class DestroySecretVersionRequest; end
      end
    end
  end
end