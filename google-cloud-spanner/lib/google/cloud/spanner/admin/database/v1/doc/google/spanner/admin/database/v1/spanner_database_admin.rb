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
  module Spanner
    module Admin
      module Database
        module V1
          # Information about the database restore.
          # @!attribute [rw] source_type
          #   @return [Google::Spanner::Admin::Database::V1::RestoreSourceType]
          #     The type of the restore source.
          # @!attribute [rw] backup_info
          #   @return [Google::Spanner::Admin::Database::V1::BackupInfo]
          #     Information about the backup used to restore the database. The backup
          #     may no longer exist.
          class RestoreInfo; end

          # A Cloud Spanner database.
          # @!attribute [rw] name
          #   @return [String]
          #     Required. The name of the database. Values are of the form
          #     `projects/<project>/instances/<instance>/databases/<database>`,
          #     where `<database>` is as specified in the `CREATE DATABASE`
          #     statement. This name can be passed to other API methods to
          #     identify the database.
          # @!attribute [rw] state
          #   @return [Google::Spanner::Admin::Database::V1::Database::State]
          #     Output only. The current database state.
          # @!attribute [rw] create_time
          #   @return [Google::Protobuf::Timestamp]
          #     Output only. If exists, the time at which the database creation started.
          # @!attribute [rw] restore_info
          #   @return [Google::Spanner::Admin::Database::V1::RestoreInfo]
          #     Output only. Applicable only for restored databases. Contains information
          #     about the restore source.
          class Database
            # Indicates the current state of the database.
            module State
              # Not specified.
              STATE_UNSPECIFIED = 0

              # The database is still being created. Operations on the database may fail
              # with `FAILED_PRECONDITION` in this state.
              CREATING = 1

              # The database is fully created and ready for use.
              READY = 2

              # The database is fully created and ready for use, but is still
              # being optimized for performance and cannot handle full load.
              #
              # In this state, the database still references the backup
              # it was restore from, preventing the backup
              # from being deleted. When optimizations are complete, the full performance
              # of the database will be restored, and the database will transition to
              # `READY` state.
              READY_OPTIMIZING = 3
            end
          end

          # The request for {Google::Spanner::Admin::Database::V1::DatabaseAdmin::ListDatabases ListDatabases}.
          # @!attribute [rw] parent
          #   @return [String]
          #     Required. The instance whose databases should be listed.
          #     Values are of the form `projects/<project>/instances/<instance>`.
          # @!attribute [rw] page_size
          #   @return [Integer]
          #     Number of databases to be returned in the response. If 0 or less,
          #     defaults to the server's maximum allowed page size.
          # @!attribute [rw] page_token
          #   @return [String]
          #     If non-empty, `page_token` should contain a
          #     {Google::Spanner::Admin::Database::V1::ListDatabasesResponse#next_page_token next_page_token} from a
          #     previous {Google::Spanner::Admin::Database::V1::ListDatabasesResponse ListDatabasesResponse}.
          class ListDatabasesRequest; end

          # The response for {Google::Spanner::Admin::Database::V1::DatabaseAdmin::ListDatabases ListDatabases}.
          # @!attribute [rw] databases
          #   @return [Array<Google::Spanner::Admin::Database::V1::Database>]
          #     Databases that matched the request.
          # @!attribute [rw] next_page_token
          #   @return [String]
          #     `next_page_token` can be sent in a subsequent
          #     {Google::Spanner::Admin::Database::V1::DatabaseAdmin::ListDatabases ListDatabases} call to fetch more
          #     of the matching databases.
          class ListDatabasesResponse; end

          # The request for {Google::Spanner::Admin::Database::V1::DatabaseAdmin::CreateDatabase CreateDatabase}.
          # @!attribute [rw] parent
          #   @return [String]
          #     Required. The name of the instance that will serve the new database.
          #     Values are of the form `projects/<project>/instances/<instance>`.
          # @!attribute [rw] create_statement
          #   @return [String]
          #     Required. A `CREATE DATABASE` statement, which specifies the ID of the
          #     new database.  The database ID must conform to the regular expression
          #     `[a-z][a-z0-9_\-]*[a-z0-9]` and be between 2 and 30 characters in length.
          #     If the database ID is a reserved word or if it contains a hyphen, the
          #     database ID must be enclosed in backticks (`` ` ``).
          # @!attribute [rw] extra_statements
          #   @return [Array<String>]
          #     Optional. A list of DDL statements to run inside the newly created
          #     database. Statements can create tables, indexes, etc. These
          #     statements execute atomically with the creation of the database:
          #     if there is an error in any statement, the database is not created.
          class CreateDatabaseRequest; end

          # Metadata type for the operation returned by
          # {Google::Spanner::Admin::Database::V1::DatabaseAdmin::CreateDatabase CreateDatabase}.
          # @!attribute [rw] database
          #   @return [String]
          #     The database being created.
          class CreateDatabaseMetadata; end

          # The request for {Google::Spanner::Admin::Database::V1::DatabaseAdmin::GetDatabase GetDatabase}.
          # @!attribute [rw] name
          #   @return [String]
          #     Required. The name of the requested database. Values are of the form
          #     `projects/<project>/instances/<instance>/databases/<database>`.
          class GetDatabaseRequest; end

          # Enqueues the given DDL statements to be applied, in order but not
          # necessarily all at once, to the database schema at some point (or
          # points) in the future. The server checks that the statements
          # are executable (syntactically valid, name tables that exist, etc.)
          # before enqueueing them, but they may still fail upon
          # later execution (e.g., if a statement from another batch of
          # statements is applied first and it conflicts in some way, or if
          # there is some data-related problem like a `NULL` value in a column to
          # which `NOT NULL` would be added). If a statement fails, all
          # subsequent statements in the batch are automatically cancelled.
          #
          # Each batch of statements is assigned a name which can be used with
          # the {Google::Longrunning::Operations Operations} API to monitor
          # progress. See the
          # {Google::Spanner::Admin::Database::V1::UpdateDatabaseDdlRequest#operation_id operation_id} field for more
          # details.
          # @!attribute [rw] database
          #   @return [String]
          #     Required. The database to update.
          # @!attribute [rw] statements
          #   @return [Array<String>]
          #     Required. DDL statements to be applied to the database.
          # @!attribute [rw] operation_id
          #   @return [String]
          #     If empty, the new update request is assigned an
          #     automatically-generated operation ID. Otherwise, `operation_id`
          #     is used to construct the name of the resulting
          #     {Google::Longrunning::Operation Operation}.
          #
          #     Specifying an explicit operation ID simplifies determining
          #     whether the statements were executed in the event that the
          #     {Google::Spanner::Admin::Database::V1::DatabaseAdmin::UpdateDatabaseDdl UpdateDatabaseDdl} call is replayed,
          #     or the return value is otherwise lost: the {Google::Spanner::Admin::Database::V1::UpdateDatabaseDdlRequest#database database} and
          #     `operation_id` fields can be combined to form the
          #     {Google::Longrunning::Operation#name name} of the resulting
          #     {Google::Longrunning::Operation longrunning::Operation}: `<database>/operations/<operation_id>`.
          #
          #     `operation_id` should be unique within the database, and must be
          #     a valid identifier: `[a-z][a-z0-9_]*`. Note that
          #     automatically-generated operation IDs always begin with an
          #     underscore. If the named operation already exists,
          #     {Google::Spanner::Admin::Database::V1::DatabaseAdmin::UpdateDatabaseDdl UpdateDatabaseDdl} returns
          #     `ALREADY_EXISTS`.
          class UpdateDatabaseDdlRequest; end

          # Metadata type for the operation returned by
          # {Google::Spanner::Admin::Database::V1::DatabaseAdmin::UpdateDatabaseDdl UpdateDatabaseDdl}.
          # @!attribute [rw] database
          #   @return [String]
          #     The database being modified.
          # @!attribute [rw] statements
          #   @return [Array<String>]
          #     For an update this list contains all the statements. For an
          #     individual statement, this list contains only that statement.
          # @!attribute [rw] commit_timestamps
          #   @return [Array<Google::Protobuf::Timestamp>]
          #     Reports the commit timestamps of all statements that have
          #     succeeded so far, where `commit_timestamps[i]` is the commit
          #     timestamp for the statement `statements[i]`.
          class UpdateDatabaseDdlMetadata; end

          # The request for {Google::Spanner::Admin::Database::V1::DatabaseAdmin::DropDatabase DropDatabase}.
          # @!attribute [rw] database
          #   @return [String]
          #     Required. The database to be dropped.
          class DropDatabaseRequest; end

          # The request for {Google::Spanner::Admin::Database::V1::DatabaseAdmin::GetDatabaseDdl GetDatabaseDdl}.
          # @!attribute [rw] database
          #   @return [String]
          #     Required. The database whose schema we wish to get.
          class GetDatabaseDdlRequest; end

          # The response for {Google::Spanner::Admin::Database::V1::DatabaseAdmin::GetDatabaseDdl GetDatabaseDdl}.
          # @!attribute [rw] statements
          #   @return [Array<String>]
          #     A list of formatted DDL statements defining the schema of the database
          #     specified in the request.
          class GetDatabaseDdlResponse; end

          # The request for
          # {Google::Spanner::Admin::Database::V1::DatabaseAdmin::ListDatabaseOperations ListDatabaseOperations}.
          # @!attribute [rw] parent
          #   @return [String]
          #     Required. The instance of the database operations.
          #     Values are of the form `projects/<project>/instances/<instance>`.
          # @!attribute [rw] filter
          #   @return [String]
          #     An expression that filters the list of returned operations.
          #
          #     A filter expression consists of a field name, a
          #     comparison operator, and a value for filtering.
          #     The value must be a string, a number, or a boolean. The comparison operator
          #     must be one of: `<`, `>`, `<=`, `>=`, `!=`, `=`, or `:`.
          #     Colon `:` is the contains operator. Filter rules are not case sensitive.
          #
          #     The following fields in the {Google::Longrunning::Operation Operation}
          #     are eligible for filtering:
          #
          #     * `name` - The name of the long-running operation
          #       * `done` - False if the operation is in progress, else true.
          #       * `metadata.@type` - the type of metadata. For example, the type string
          #         for {Google::Spanner::Admin::Database::V1::RestoreDatabaseMetadata RestoreDatabaseMetadata} is
          #         `type.googleapis.com/google.spanner.admin.database.v1.RestoreDatabaseMetadata`.
          #       * `metadata.<field_name>` - any field in metadata.value.
          #       * `error` - Error associated with the long-running operation.
          #       * `response.@type` - the type of response.
          #       * `response.<field_name>` - any field in response.value.
          #
          #       You can combine multiple expressions by enclosing each expression in
          #       parentheses. By default, expressions are combined with AND logic. However,
          #       you can specify AND, OR, and NOT logic explicitly.
          #
          #     Here are a few examples:
          #
          #     * `done:true` - The operation is complete.
          #       * `(metadata.@type=type.googleapis.com/google.spanner.admin.database.v1.RestoreDatabaseMetadata) AND` <br/>
          #         `(metadata.source_type:BACKUP) AND` <br/>
          #         `(metadata.backup_info.backup:backup_howl) AND` <br/>
          #         `(metadata.name:restored_howl) AND` <br/>
          #         `(metadata.progress.start_time < \"2018-03-28T14:50:00Z\") AND` <br/>
          #         `(error:*)` - Return operations where:
          #         * The operation's metadata type is {Google::Spanner::Admin::Database::V1::RestoreDatabaseMetadata RestoreDatabaseMetadata}.
          #         * The database is restored from a backup.
          #         * The backup name contains "backup_howl".
          #         * The restored database's name contains "restored_howl".
          #         * The operation started before 2018-03-28T14:50:00Z.
          #         * The operation resulted in an error.
          # @!attribute [rw] page_size
          #   @return [Integer]
          #     Number of operations to be returned in the response. If 0 or
          #     less, defaults to the server's maximum allowed page size.
          # @!attribute [rw] page_token
          #   @return [String]
          #     If non-empty, `page_token` should contain a
          #     {Google::Spanner::Admin::Database::V1::ListDatabaseOperationsResponse#next_page_token next_page_token}
          #     from a previous {Google::Spanner::Admin::Database::V1::ListDatabaseOperationsResponse ListDatabaseOperationsResponse} to the
          #     same `parent` and with the same `filter`.
          class ListDatabaseOperationsRequest; end

          # The response for
          # {Google::Spanner::Admin::Database::V1::DatabaseAdmin::ListDatabaseOperations ListDatabaseOperations}.
          # @!attribute [rw] operations
          #   @return [Array<Google::Longrunning::Operation>]
          #     The list of matching database [long-running
          #     operations][google.longrunning.Operation]. Each operation's name will be
          #     prefixed by the database's name. The operation's
          #     {Google::Longrunning::Operation#metadata metadata} field type
          #     `metadata.type_url` describes the type of the metadata.
          # @!attribute [rw] next_page_token
          #   @return [String]
          #     `next_page_token` can be sent in a subsequent
          #     {Google::Spanner::Admin::Database::V1::DatabaseAdmin::ListDatabaseOperations ListDatabaseOperations}
          #     call to fetch more of the matching metadata.
          class ListDatabaseOperationsResponse; end

          # The request for
          # {Google::Spanner::Admin::Database::V1::DatabaseAdmin::RestoreDatabase RestoreDatabase}.
          # @!attribute [rw] parent
          #   @return [String]
          #     Required. The name of the instance in which to create the
          #     restored database. This instance must be in the same project and
          #     have the same instance configuration as the instance containing
          #     the source backup. Values are of the form
          #     `projects/<project>/instances/<instance>`.
          # @!attribute [rw] database_id
          #   @return [String]
          #     Required. The id of the database to create and restore to. This
          #     database must not already exist. The `database_id` appended to
          #     `parent` forms the full database name of the form
          #     `projects/<project>/instances/<instance>/databases/<database_id>`.
          # @!attribute [rw] backup
          #   @return [String]
          #     Name of the backup from which to restore.  Values are of the form
          #     `projects/<project>/instances/<instance>/backups/<backup>`.
          class RestoreDatabaseRequest; end

          # Metadata type for the long-running operation returned by
          # {Google::Spanner::Admin::Database::V1::DatabaseAdmin::RestoreDatabase RestoreDatabase}.
          # @!attribute [rw] name
          #   @return [String]
          #     Name of the database being created and restored to.
          # @!attribute [rw] source_type
          #   @return [Google::Spanner::Admin::Database::V1::RestoreSourceType]
          #     The type of the restore source.
          # @!attribute [rw] backup_info
          #   @return [Google::Spanner::Admin::Database::V1::BackupInfo]
          #     Information about the backup used to restore the database.
          # @!attribute [rw] progress
          #   @return [Google::Spanner::Admin::Database::V1::OperationProgress]
          #     The progress of the
          #     {Google::Spanner::Admin::Database::V1::DatabaseAdmin::RestoreDatabase RestoreDatabase}
          #     operation.
          # @!attribute [rw] cancel_time
          #   @return [Google::Protobuf::Timestamp]
          #     The time at which cancellation of this operation was received.
          #     {Google::Longrunning::Operations::CancelOperation Operations::CancelOperation}
          #     starts asynchronous cancellation on a long-running operation. The server
          #     makes a best effort to cancel the operation, but success is not guaranteed.
          #     Clients can use
          #     {Google::Longrunning::Operations::GetOperation Operations::GetOperation} or
          #     other methods to check whether the cancellation succeeded or whether the
          #     operation completed despite cancellation. On successful cancellation,
          #     the operation is not deleted; instead, it becomes an operation with
          #     an {Google::Longrunning::Operation#error Operation#error} value with a
          #     {Google::Rpc::Status#code} of 1, corresponding to `Code.CANCELLED`.
          # @!attribute [rw] optimize_database_operation_name
          #   @return [String]
          #     If exists, the name of the long-running operation that will be used to
          #     track the post-restore optimization process to optimize the performance of
          #     the restored database, and remove the dependency on the restore source.
          #     The name is of the form
          #     `projects/<project>/instances/<instance>/databases/<database>/operations/<operation>`
          #     where the <database> is the name of database being created and restored to.
          #     The metadata type of the  long-running operation is
          #     {Google::Spanner::Admin::Database::V1::OptimizeRestoredDatabaseMetadata OptimizeRestoredDatabaseMetadata}. This long-running operation will be
          #     automatically created by the system after the RestoreDatabase long-running
          #     operation completes successfully. This operation will not be created if the
          #     restore was not successful.
          class RestoreDatabaseMetadata; end

          # Indicates the type of the restore source.
          module RestoreSourceType
            # No restore associated.
            TYPE_UNSPECIFIED = 0

            # A backup was used as the source of the restore.
            BACKUP = 1
          end
        end
      end
    end
  end
end