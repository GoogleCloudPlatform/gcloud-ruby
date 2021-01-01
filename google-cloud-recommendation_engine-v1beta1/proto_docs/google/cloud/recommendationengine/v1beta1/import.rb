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
    module RecommendationEngine
      module V1beta1
        # Google Cloud Storage location for input content.
        # format.
        # @!attribute [rw] input_uris
        #   @return [::Array<::String>]
        #     Required. Google Cloud Storage URIs to input files. URI can be up to
        #     2000 characters long. URIs can match the full object path (for example,
        #     gs://bucket/directory/object.json) or a pattern matching one or more
        #     files, such as gs://bucket/directory/*.json. A request can
        #     contain at most 100 files, and each file can be up to 2 GB. See
        #     [Importing catalog information](/recommendations-ai/docs/upload-catalog)
        #     for the expected file format and setup instructions.
        class GcsSource
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # The inline source for the input config for ImportCatalogItems method.
        # @!attribute [rw] catalog_items
        #   @return [::Array<::Google::Cloud::RecommendationEngine::V1beta1::CatalogItem>]
        #     Optional. A list of catalog items to update/create. Recommended max of 10k
        #     items.
        class CatalogInlineSource
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # The inline source for the input config for ImportUserEvents method.
        # @!attribute [rw] user_events
        #   @return [::Array<::Google::Cloud::RecommendationEngine::V1beta1::UserEvent>]
        #     Optional. A list of user events to import. Recommended max of 10k items.
        class UserEventInlineSource
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # Configuration of destination for Import related errors.
        # @!attribute [rw] gcs_prefix
        #   @return [::String]
        #     Google Cloud Storage path for import errors. This must be an empty,
        #     existing Cloud Storage bucket. Import errors will be written to a file in
        #     this bucket, one per line, as a JSON-encoded
        #     `google.rpc.Status` message.
        class ImportErrorsConfig
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for Import methods.
        # @!attribute [rw] parent
        #   @return [::String]
        #     Required. "projects/1234/locations/global/catalogs/default_catalog"
        # @!attribute [rw] request_id
        #   @return [::String]
        #     Optional. Unique identifier provided by client, within the ancestor
        #     dataset scope. Ensures idempotency and used for request deduplication.
        #     Server-generated if unspecified. Up to 128 characters long. This is
        #     returned as google.longrunning.Operation.name in the response.
        # @!attribute [rw] input_config
        #   @return [::Google::Cloud::RecommendationEngine::V1beta1::InputConfig]
        #     Required. The desired input location of the data.
        # @!attribute [rw] errors_config
        #   @return [::Google::Cloud::RecommendationEngine::V1beta1::ImportErrorsConfig]
        #     Optional. The desired location of errors incurred during the Import.
        class ImportCatalogItemsRequest
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the ImportUserEvents request.
        # @!attribute [rw] parent
        #   @return [::String]
        #     Required.
        #     "projects/1234/locations/global/catalogs/default_catalog/eventStores/default_event_store"
        # @!attribute [rw] request_id
        #   @return [::String]
        #     Optional. Unique identifier provided by client, within the ancestor
        #     dataset scope. Ensures idempotency for expensive long running operations.
        #     Server-generated if unspecified. Up to 128 characters long. This is
        #     returned as google.longrunning.Operation.name in the response. Note that
        #     this field must not be set if the desired input config is
        #     catalog_inline_source.
        # @!attribute [rw] input_config
        #   @return [::Google::Cloud::RecommendationEngine::V1beta1::InputConfig]
        #     Required. The desired input location of the data.
        # @!attribute [rw] errors_config
        #   @return [::Google::Cloud::RecommendationEngine::V1beta1::ImportErrorsConfig]
        #     Optional. The desired location of errors incurred during the Import.
        class ImportUserEventsRequest
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # The input config source.
        # @!attribute [rw] catalog_inline_source
        #   @return [::Google::Cloud::RecommendationEngine::V1beta1::CatalogInlineSource]
        #     The Inline source for the input content for Catalog items.
        # @!attribute [rw] gcs_source
        #   @return [::Google::Cloud::RecommendationEngine::V1beta1::GcsSource]
        #     Google Cloud Storage location for the input content.
        # @!attribute [rw] user_event_inline_source
        #   @return [::Google::Cloud::RecommendationEngine::V1beta1::UserEventInlineSource]
        #     The Inline source for the input content for UserEvents.
        class InputConfig
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # Metadata related to the progress of the Import operation. This will be
        # returned by the google.longrunning.Operation.metadata field.
        # @!attribute [rw] operation_name
        #   @return [::String]
        #     Name of the operation.
        # @!attribute [rw] request_id
        #   @return [::String]
        #     Id of the request / operation. This is parroting back the requestId that
        #     was passed in the request.
        # @!attribute [rw] create_time
        #   @return [::Google::Protobuf::Timestamp]
        #     Operation create time.
        # @!attribute [rw] success_count
        #   @return [::Integer]
        #     Count of entries that were processed successfully.
        # @!attribute [rw] failure_count
        #   @return [::Integer]
        #     Count of entries that encountered errors while processing.
        # @!attribute [rw] update_time
        #   @return [::Google::Protobuf::Timestamp]
        #     Operation last update time. If the operation is done, this is also the
        #     finish time.
        class ImportMetadata
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # Response of the ImportCatalogItemsRequest. If the long running
        # operation is done, then this message is returned by the
        # google.longrunning.Operations.response field if the operation was successful.
        # @!attribute [rw] error_samples
        #   @return [::Array<::Google::Rpc::Status>]
        #     A sample of errors encountered while processing the request.
        # @!attribute [rw] errors_config
        #   @return [::Google::Cloud::RecommendationEngine::V1beta1::ImportErrorsConfig]
        #     Echoes the destination for the complete errors in the request if set.
        class ImportCatalogItemsResponse
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # Response of the ImportUserEventsRequest. If the long running
        # operation was successful, then this message is returned by the
        # google.longrunning.Operations.response field if the operation was successful.
        # @!attribute [rw] error_samples
        #   @return [::Array<::Google::Rpc::Status>]
        #     A sample of errors encountered while processing the request.
        # @!attribute [rw] errors_config
        #   @return [::Google::Cloud::RecommendationEngine::V1beta1::ImportErrorsConfig]
        #     Echoes the destination for the complete errors if this field was set in
        #     the request.
        # @!attribute [rw] import_summary
        #   @return [::Google::Cloud::RecommendationEngine::V1beta1::UserEventImportSummary]
        #     Aggregated statistics of user event import status.
        class ImportUserEventsResponse
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # A summary of import result. The UserEventImportSummary summarizes
        # the import status for user events.
        # @!attribute [rw] joined_events_count
        #   @return [::Integer]
        #     Count of user events imported with complete existing catalog information.
        # @!attribute [rw] unjoined_events_count
        #   @return [::Integer]
        #     Count of user events imported, but with catalog information not found
        #     in the imported catalog.
        class UserEventImportSummary
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end
      end
    end
  end
end
