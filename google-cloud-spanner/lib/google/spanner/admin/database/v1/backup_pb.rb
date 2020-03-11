# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/spanner/admin/database/v1/backup.proto


require 'google/protobuf'

require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/longrunning/operations_pb'
require 'google/protobuf/field_mask_pb'
require 'google/protobuf/timestamp_pb'
require 'google/spanner/admin/database/v1/common_pb'
require 'google/api/annotations_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "google.spanner.admin.database.v1.Backup" do
    optional :database, :string, 2
    optional :expire_time, :message, 3, "google.protobuf.Timestamp"
    optional :name, :string, 1
    optional :create_time, :message, 4, "google.protobuf.Timestamp"
    optional :size_bytes, :int64, 5
    optional :state, :enum, 6, "google.spanner.admin.database.v1.Backup.State"
    repeated :referencing_databases, :string, 7
  end
  add_enum "google.spanner.admin.database.v1.Backup.State" do
    value :STATE_UNSPECIFIED, 0
    value :CREATING, 1
    value :READY, 2
  end
  add_message "google.spanner.admin.database.v1.CreateBackupRequest" do
    optional :parent, :string, 1
    optional :backup_id, :string, 2
    optional :backup, :message, 3, "google.spanner.admin.database.v1.Backup"
  end
  add_message "google.spanner.admin.database.v1.CreateBackupMetadata" do
    optional :name, :string, 1
    optional :database, :string, 2
    optional :progress, :message, 3, "google.spanner.admin.database.v1.OperationProgress"
    optional :cancel_time, :message, 4, "google.protobuf.Timestamp"
  end
  add_message "google.spanner.admin.database.v1.UpdateBackupRequest" do
    optional :backup, :message, 1, "google.spanner.admin.database.v1.Backup"
    optional :update_mask, :message, 2, "google.protobuf.FieldMask"
  end
  add_message "google.spanner.admin.database.v1.GetBackupRequest" do
    optional :name, :string, 1
  end
  add_message "google.spanner.admin.database.v1.DeleteBackupRequest" do
    optional :name, :string, 1
  end
  add_message "google.spanner.admin.database.v1.ListBackupsRequest" do
    optional :parent, :string, 1
    optional :filter, :string, 2
    optional :page_size, :int32, 3
    optional :page_token, :string, 4
  end
  add_message "google.spanner.admin.database.v1.ListBackupsResponse" do
    repeated :backups, :message, 1, "google.spanner.admin.database.v1.Backup"
    optional :next_page_token, :string, 2
  end
  add_message "google.spanner.admin.database.v1.ListBackupOperationsRequest" do
    optional :parent, :string, 1
    optional :filter, :string, 2
    optional :page_size, :int32, 3
    optional :page_token, :string, 4
  end
  add_message "google.spanner.admin.database.v1.ListBackupOperationsResponse" do
    repeated :operations, :message, 1, "google.longrunning.Operation"
    optional :next_page_token, :string, 2
  end
  add_message "google.spanner.admin.database.v1.BackupInfo" do
    optional :backup, :string, 1
    optional :create_time, :message, 2, "google.protobuf.Timestamp"
    optional :source_database, :string, 3
  end
end

module Google
  module Spanner
    module Admin
      module Database
        module V1
          Backup = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.spanner.admin.database.v1.Backup").msgclass
          Backup::State = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.spanner.admin.database.v1.Backup.State").enummodule
          CreateBackupRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.spanner.admin.database.v1.CreateBackupRequest").msgclass
          CreateBackupMetadata = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.spanner.admin.database.v1.CreateBackupMetadata").msgclass
          UpdateBackupRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.spanner.admin.database.v1.UpdateBackupRequest").msgclass
          GetBackupRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.spanner.admin.database.v1.GetBackupRequest").msgclass
          DeleteBackupRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.spanner.admin.database.v1.DeleteBackupRequest").msgclass
          ListBackupsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.spanner.admin.database.v1.ListBackupsRequest").msgclass
          ListBackupsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.spanner.admin.database.v1.ListBackupsResponse").msgclass
          ListBackupOperationsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.spanner.admin.database.v1.ListBackupOperationsRequest").msgclass
          ListBackupOperationsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.spanner.admin.database.v1.ListBackupOperationsResponse").msgclass
          BackupInfo = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.spanner.admin.database.v1.BackupInfo").msgclass
        end
      end
    end
  end
end
