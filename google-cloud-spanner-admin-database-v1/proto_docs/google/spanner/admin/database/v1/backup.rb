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
    module Spanner
      module Admin
        module Database
          module V1
            # A backup of a Cloud Spanner database.
            # @!attribute [rw] database
            #   @return [::String]
            #     Required for the
            #     {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#create_backup CreateBackup}
            #     operation. Name of the database from which this backup was created. This
            #     needs to be in the same instance as the backup. Values are of the form
            #     `projects/<project>/instances/<instance>/databases/<database>`.
            # @!attribute [rw] version_time
            #   @return [::Google::Protobuf::Timestamp]
            #     The backup will contain an externally consistent copy of the database at
            #     the timestamp specified by `version_time`. If `version_time` is not
            #     specified, the system will set `version_time` to the `create_time` of the
            #     backup.
            # @!attribute [rw] expire_time
            #   @return [::Google::Protobuf::Timestamp]
            #     Required for the
            #     {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#create_backup CreateBackup}
            #     operation. The expiration time of the backup, with microseconds
            #     granularity that must be at least 6 hours and at most 366 days
            #     from the time the CreateBackup request is processed. Once the `expire_time`
            #     has passed, the backup is eligible to be automatically deleted by Cloud
            #     Spanner to free the resources used by the backup.
            # @!attribute [rw] name
            #   @return [::String]
            #     Output only for the
            #     {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#create_backup CreateBackup}
            #     operation. Required for the
            #     {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#update_backup UpdateBackup}
            #     operation.
            #
            #     A globally unique identifier for the backup which cannot be
            #     changed. Values are of the form
            #     `projects/<project>/instances/<instance>/backups/[a-z][a-z0-9_\-]*[a-z0-9]`
            #     The final segment of the name must be between 2 and 60 characters
            #     in length.
            #
            #     The backup is stored in the location(s) specified in the instance
            #     configuration of the instance containing the backup, identified
            #     by the prefix of the backup name of the form
            #     `projects/<project>/instances/<instance>`.
            # @!attribute [r] create_time
            #   @return [::Google::Protobuf::Timestamp]
            #     Output only. The time the
            #     {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#create_backup CreateBackup}
            #     request is received. If the request does not specify `version_time`, the
            #     `version_time` of the backup will be equivalent to the `create_time`.
            # @!attribute [r] size_bytes
            #   @return [::Integer]
            #     Output only. Size of the backup in bytes.
            # @!attribute [r] state
            #   @return [::Google::Cloud::Spanner::Admin::Database::V1::Backup::State]
            #     Output only. The current state of the backup.
            # @!attribute [r] referencing_databases
            #   @return [::Array<::String>]
            #     Output only. The names of the restored databases that reference the backup.
            #     The database names are of
            #     the form `projects/<project>/instances/<instance>/databases/<database>`.
            #     Referencing databases may exist in different instances. The existence of
            #     any referencing database prevents the backup from being deleted. When a
            #     restored database from the backup enters the `READY` state, the reference
            #     to the backup is removed.
            # @!attribute [r] encryption_info
            #   @return [::Google::Cloud::Spanner::Admin::Database::V1::EncryptionInfo]
            #     Output only. The encryption information for the backup.
            class Backup
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods

              # Indicates the current state of the backup.
              module State
                # Not specified.
                STATE_UNSPECIFIED = 0

                # The pending backup is still being created. Operations on the
                # backup may fail with `FAILED_PRECONDITION` in this state.
                CREATING = 1

                # The backup is complete and ready for use.
                READY = 2
              end
            end

            # The request for
            # {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#create_backup CreateBackup}.
            # @!attribute [rw] parent
            #   @return [::String]
            #     Required. The name of the instance in which the backup will be
            #     created. This must be the same instance that contains the database the
            #     backup will be created from. The backup will be stored in the
            #     location(s) specified in the instance configuration of this
            #     instance. Values are of the form
            #     `projects/<project>/instances/<instance>`.
            # @!attribute [rw] backup_id
            #   @return [::String]
            #     Required. The id of the backup to be created. The `backup_id` appended to
            #     `parent` forms the full backup name of the form
            #     `projects/<project>/instances/<instance>/backups/<backup_id>`.
            # @!attribute [rw] backup
            #   @return [::Google::Cloud::Spanner::Admin::Database::V1::Backup]
            #     Required. The backup to create.
            # @!attribute [rw] encryption_config
            #   @return [::Google::Cloud::Spanner::Admin::Database::V1::CreateBackupEncryptionConfig]
            #     Optional. The encryption configuration used to encrypt the backup. If this
            #     field is not specified, the backup will use the same encryption
            #     configuration as the database by default, namely
            #     {::Google::Cloud::Spanner::Admin::Database::V1::CreateBackupEncryptionConfig#encryption_type encryption_type}
            #     = `USE_DATABASE_ENCRYPTION`.
            class CreateBackupRequest
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods
            end

            # Metadata type for the operation returned by
            # {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#create_backup CreateBackup}.
            # @!attribute [rw] name
            #   @return [::String]
            #     The name of the backup being created.
            # @!attribute [rw] database
            #   @return [::String]
            #     The name of the database the backup is created from.
            # @!attribute [rw] progress
            #   @return [::Google::Cloud::Spanner::Admin::Database::V1::OperationProgress]
            #     The progress of the
            #     {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#create_backup CreateBackup}
            #     operation.
            # @!attribute [rw] cancel_time
            #   @return [::Google::Protobuf::Timestamp]
            #     The time at which cancellation of this operation was received.
            #     Operations.CancelOperation
            #     starts asynchronous cancellation on a long-running operation. The server
            #     makes a best effort to cancel the operation, but success is not guaranteed.
            #     Clients can use
            #     Operations.GetOperation or
            #     other methods to check whether the cancellation succeeded or whether the
            #     operation completed despite cancellation. On successful cancellation,
            #     the operation is not deleted; instead, it becomes an operation with
            #     an {::Google::Longrunning::Operation#error Operation.error} value with a
            #     {::Google::Rpc::Status#code google.rpc.Status.code} of 1,
            #     corresponding to `Code.CANCELLED`.
            class CreateBackupMetadata
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods
            end

            # The request for
            # {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#update_backup UpdateBackup}.
            # @!attribute [rw] backup
            #   @return [::Google::Cloud::Spanner::Admin::Database::V1::Backup]
            #     Required. The backup to update. `backup.name`, and the fields to be updated
            #     as specified by `update_mask` are required. Other fields are ignored.
            #     Update is only supported for the following fields:
            #      * `backup.expire_time`.
            # @!attribute [rw] update_mask
            #   @return [::Google::Protobuf::FieldMask]
            #     Required. A mask specifying which fields (e.g. `expire_time`) in the
            #     Backup resource should be updated. This mask is relative to the Backup
            #     resource, not to the request message. The field mask must always be
            #     specified; this prevents any future fields from being erased accidentally
            #     by clients that do not know about them.
            class UpdateBackupRequest
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods
            end

            # The request for
            # {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#get_backup GetBackup}.
            # @!attribute [rw] name
            #   @return [::String]
            #     Required. Name of the backup.
            #     Values are of the form
            #     `projects/<project>/instances/<instance>/backups/<backup>`.
            class GetBackupRequest
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods
            end

            # The request for
            # {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#delete_backup DeleteBackup}.
            # @!attribute [rw] name
            #   @return [::String]
            #     Required. Name of the backup to delete.
            #     Values are of the form
            #     `projects/<project>/instances/<instance>/backups/<backup>`.
            class DeleteBackupRequest
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods
            end

            # The request for
            # {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#list_backups ListBackups}.
            # @!attribute [rw] parent
            #   @return [::String]
            #     Required. The instance to list backups from.  Values are of the
            #     form `projects/<project>/instances/<instance>`.
            # @!attribute [rw] filter
            #   @return [::String]
            #     An expression that filters the list of returned backups.
            #
            #     A filter expression consists of a field name, a comparison operator, and a
            #     value for filtering.
            #     The value must be a string, a number, or a boolean. The comparison operator
            #     must be one of: `<`, `>`, `<=`, `>=`, `!=`, `=`, or `:`.
            #     Colon `:` is the contains operator. Filter rules are not case sensitive.
            #
            #     The following fields in the
            #     {::Google::Cloud::Spanner::Admin::Database::V1::Backup Backup} are eligible for
            #     filtering:
            #
            #       * `name`
            #       * `database`
            #       * `state`
            #       * `create_time`  (and values are of the format YYYY-MM-DDTHH:MM:SSZ)
            #       * `expire_time`  (and values are of the format YYYY-MM-DDTHH:MM:SSZ)
            #       * `version_time` (and values are of the format YYYY-MM-DDTHH:MM:SSZ)
            #       * `size_bytes`
            #
            #     You can combine multiple expressions by enclosing each expression in
            #     parentheses. By default, expressions are combined with AND logic, but
            #     you can specify AND, OR, and NOT logic explicitly.
            #
            #     Here are a few examples:
            #
            #       * `name:Howl` - The backup's name contains the string "howl".
            #       * `database:prod`
            #              - The database's name contains the string "prod".
            #       * `state:CREATING` - The backup is pending creation.
            #       * `state:READY` - The backup is fully created and ready for use.
            #       * `(name:howl) AND (create_time < \"2018-03-28T14:50:00Z\")`
            #              - The backup name contains the string "howl" and `create_time`
            #                  of the backup is before 2018-03-28T14:50:00Z.
            #       * `expire_time < \"2018-03-28T14:50:00Z\"`
            #              - The backup `expire_time` is before 2018-03-28T14:50:00Z.
            #       * `size_bytes > 10000000000` - The backup's size is greater than 10GB
            # @!attribute [rw] page_size
            #   @return [::Integer]
            #     Number of backups to be returned in the response. If 0 or
            #     less, defaults to the server's maximum allowed page size.
            # @!attribute [rw] page_token
            #   @return [::String]
            #     If non-empty, `page_token` should contain a
            #     {::Google::Cloud::Spanner::Admin::Database::V1::ListBackupsResponse#next_page_token next_page_token}
            #     from a previous
            #     {::Google::Cloud::Spanner::Admin::Database::V1::ListBackupsResponse ListBackupsResponse}
            #     to the same `parent` and with the same `filter`.
            class ListBackupsRequest
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods
            end

            # The response for
            # {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#list_backups ListBackups}.
            # @!attribute [rw] backups
            #   @return [::Array<::Google::Cloud::Spanner::Admin::Database::V1::Backup>]
            #     The list of matching backups. Backups returned are ordered by `create_time`
            #     in descending order, starting from the most recent `create_time`.
            # @!attribute [rw] next_page_token
            #   @return [::String]
            #     `next_page_token` can be sent in a subsequent
            #     {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#list_backups ListBackups}
            #     call to fetch more of the matching backups.
            class ListBackupsResponse
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods
            end

            # The request for
            # {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#list_backup_operations ListBackupOperations}.
            # @!attribute [rw] parent
            #   @return [::String]
            #     Required. The instance of the backup operations. Values are of
            #     the form `projects/<project>/instances/<instance>`.
            # @!attribute [rw] filter
            #   @return [::String]
            #     An expression that filters the list of returned backup operations.
            #
            #     A filter expression consists of a field name, a
            #     comparison operator, and a value for filtering.
            #     The value must be a string, a number, or a boolean. The comparison operator
            #     must be one of: `<`, `>`, `<=`, `>=`, `!=`, `=`, or `:`.
            #     Colon `:` is the contains operator. Filter rules are not case sensitive.
            #
            #     The following fields in the {::Google::Longrunning::Operation operation}
            #     are eligible for filtering:
            #
            #       * `name` - The name of the long-running operation
            #       * `done` - False if the operation is in progress, else true.
            #       * `metadata.@type` - the type of metadata. For example, the type string
            #          for
            #          {::Google::Cloud::Spanner::Admin::Database::V1::CreateBackupMetadata CreateBackupMetadata}
            #          is
            #          `type.googleapis.com/google.spanner.admin.database.v1.CreateBackupMetadata`.
            #       * `metadata.<field_name>` - any field in metadata.value.
            #       * `error` - Error associated with the long-running operation.
            #       * `response.@type` - the type of response.
            #       * `response.<field_name>` - any field in response.value.
            #
            #     You can combine multiple expressions by enclosing each expression in
            #     parentheses. By default, expressions are combined with AND logic, but
            #     you can specify AND, OR, and NOT logic explicitly.
            #
            #     Here are a few examples:
            #
            #       * `done:true` - The operation is complete.
            #       * `metadata.database:prod` - The database the backup was taken from has
            #          a name containing the string "prod".
            #       * `(metadata.@type=type.googleapis.com/google.spanner.admin.database.v1.CreateBackupMetadata) AND` \
            #         `(metadata.name:howl) AND` \
            #         `(metadata.progress.start_time < \"2018-03-28T14:50:00Z\") AND` \
            #         `(error:*)` - Returns operations where:
            #         * The operation's metadata type is
            #         {::Google::Cloud::Spanner::Admin::Database::V1::CreateBackupMetadata CreateBackupMetadata}.
            #         * The backup name contains the string "howl".
            #         * The operation started before 2018-03-28T14:50:00Z.
            #         * The operation resulted in an error.
            # @!attribute [rw] page_size
            #   @return [::Integer]
            #     Number of operations to be returned in the response. If 0 or
            #     less, defaults to the server's maximum allowed page size.
            # @!attribute [rw] page_token
            #   @return [::String]
            #     If non-empty, `page_token` should contain a
            #     {::Google::Cloud::Spanner::Admin::Database::V1::ListBackupOperationsResponse#next_page_token next_page_token}
            #     from a previous
            #     {::Google::Cloud::Spanner::Admin::Database::V1::ListBackupOperationsResponse ListBackupOperationsResponse}
            #     to the same `parent` and with the same `filter`.
            class ListBackupOperationsRequest
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods
            end

            # The response for
            # {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#list_backup_operations ListBackupOperations}.
            # @!attribute [rw] operations
            #   @return [::Array<::Google::Longrunning::Operation>]
            #     The list of matching backup [long-running
            #     operations][google.longrunning.Operation]. Each operation's name will be
            #     prefixed by the backup's name and the operation's
            #     {::Google::Longrunning::Operation#metadata metadata} will be of type
            #     {::Google::Cloud::Spanner::Admin::Database::V1::CreateBackupMetadata CreateBackupMetadata}.
            #     Operations returned include those that are pending or have
            #     completed/failed/canceled within the last 7 days. Operations returned are
            #     ordered by `operation.metadata.value.progress.start_time` in descending
            #     order starting from the most recently started operation.
            # @!attribute [rw] next_page_token
            #   @return [::String]
            #     `next_page_token` can be sent in a subsequent
            #     {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#list_backup_operations ListBackupOperations}
            #     call to fetch more of the matching metadata.
            class ListBackupOperationsResponse
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods
            end

            # Information about a backup.
            # @!attribute [rw] backup
            #   @return [::String]
            #     Name of the backup.
            # @!attribute [rw] version_time
            #   @return [::Google::Protobuf::Timestamp]
            #     The backup contains an externally consistent copy of `source_database` at
            #     the timestamp specified by `version_time`. If the
            #     {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#create_backup CreateBackup}
            #     request did not specify `version_time`, the `version_time` of the backup is
            #     equivalent to the `create_time`.
            # @!attribute [rw] create_time
            #   @return [::Google::Protobuf::Timestamp]
            #     The time the
            #     {::Google::Cloud::Spanner::Admin::Database::V1::DatabaseAdmin::Client#create_backup CreateBackup}
            #     request was received.
            # @!attribute [rw] source_database
            #   @return [::String]
            #     Name of the database the backup was created from.
            class BackupInfo
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods
            end

            # Encryption configuration for the backup to create.
            # @!attribute [rw] encryption_type
            #   @return [::Google::Cloud::Spanner::Admin::Database::V1::CreateBackupEncryptionConfig::EncryptionType]
            #     Required. The encryption type of the backup.
            # @!attribute [rw] kms_key_name
            #   @return [::String]
            #     Optional. The Cloud KMS key that will be used to protect the backup.
            #     This field should be set only when
            #     {::Google::Cloud::Spanner::Admin::Database::V1::CreateBackupEncryptionConfig#encryption_type encryption_type}
            #     is `CUSTOMER_MANAGED_ENCRYPTION`. Values are of the form
            #     `projects/<project>/locations/<location>/keyRings/<key_ring>/cryptoKeys/<kms_key_name>`.
            class CreateBackupEncryptionConfig
              include ::Google::Protobuf::MessageExts
              extend ::Google::Protobuf::MessageExts::ClassMethods

              # Encryption types for the backup.
              module EncryptionType
                # Unspecified. Do not use.
                ENCRYPTION_TYPE_UNSPECIFIED = 0

                # Use the same encryption configuration as the database. This is the
                # default option when
                # {::Google::Cloud::Spanner::Admin::Database::V1::CreateBackupEncryptionConfig encryption_config}
                # is empty. For example, if the database is using
                # `Customer_Managed_Encryption`, the backup will be using the same Cloud
                # KMS key as the database.
                USE_DATABASE_ENCRYPTION = 1

                # Use Google default encryption.
                GOOGLE_DEFAULT_ENCRYPTION = 2

                # Use customer managed encryption. If specified, `kms_key_name`
                # must contain a valid Cloud KMS key.
                CUSTOMER_MANAGED_ENCRYPTION = 3
              end
            end
          end
        end
      end
    end
  end
end
