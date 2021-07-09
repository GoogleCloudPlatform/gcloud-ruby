# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/bigtable/admin/v2/bigtable_instance_admin.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/bigtable/admin/v2/instance_pb'
require 'google/iam/v1/iam_policy_pb'
require 'google/iam/v1/policy_pb'
require 'google/longrunning/operations_pb'
require 'google/protobuf/empty_pb'
require 'google/protobuf/field_mask_pb'
require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/bigtable/admin/v2/bigtable_instance_admin.proto", :syntax => :proto3) do
    add_message "google.bigtable.admin.v2.CreateInstanceRequest" do
      optional :parent, :string, 1
      optional :instance_id, :string, 2
      optional :instance, :message, 3, "google.bigtable.admin.v2.Instance"
      map :clusters, :string, :message, 4, "google.bigtable.admin.v2.Cluster"
    end
    add_message "google.bigtable.admin.v2.GetInstanceRequest" do
      optional :name, :string, 1
    end
    add_message "google.bigtable.admin.v2.ListInstancesRequest" do
      optional :parent, :string, 1
      optional :page_token, :string, 2
    end
    add_message "google.bigtable.admin.v2.ListInstancesResponse" do
      repeated :instances, :message, 1, "google.bigtable.admin.v2.Instance"
      repeated :failed_locations, :string, 2
      optional :next_page_token, :string, 3
    end
    add_message "google.bigtable.admin.v2.PartialUpdateInstanceRequest" do
      optional :instance, :message, 1, "google.bigtable.admin.v2.Instance"
      optional :update_mask, :message, 2, "google.protobuf.FieldMask"
    end
    add_message "google.bigtable.admin.v2.DeleteInstanceRequest" do
      optional :name, :string, 1
    end
    add_message "google.bigtable.admin.v2.CreateClusterRequest" do
      optional :parent, :string, 1
      optional :cluster_id, :string, 2
      optional :cluster, :message, 3, "google.bigtable.admin.v2.Cluster"
    end
    add_message "google.bigtable.admin.v2.GetClusterRequest" do
      optional :name, :string, 1
    end
    add_message "google.bigtable.admin.v2.ListClustersRequest" do
      optional :parent, :string, 1
      optional :page_token, :string, 2
    end
    add_message "google.bigtable.admin.v2.ListClustersResponse" do
      repeated :clusters, :message, 1, "google.bigtable.admin.v2.Cluster"
      repeated :failed_locations, :string, 2
      optional :next_page_token, :string, 3
    end
    add_message "google.bigtable.admin.v2.DeleteClusterRequest" do
      optional :name, :string, 1
    end
    add_message "google.bigtable.admin.v2.CreateInstanceMetadata" do
      optional :original_request, :message, 1, "google.bigtable.admin.v2.CreateInstanceRequest"
      optional :request_time, :message, 2, "google.protobuf.Timestamp"
      optional :finish_time, :message, 3, "google.protobuf.Timestamp"
    end
    add_message "google.bigtable.admin.v2.UpdateInstanceMetadata" do
      optional :original_request, :message, 1, "google.bigtable.admin.v2.PartialUpdateInstanceRequest"
      optional :request_time, :message, 2, "google.protobuf.Timestamp"
      optional :finish_time, :message, 3, "google.protobuf.Timestamp"
    end
    add_message "google.bigtable.admin.v2.CreateClusterMetadata" do
      optional :original_request, :message, 1, "google.bigtable.admin.v2.CreateClusterRequest"
      optional :request_time, :message, 2, "google.protobuf.Timestamp"
      optional :finish_time, :message, 3, "google.protobuf.Timestamp"
    end
    add_message "google.bigtable.admin.v2.UpdateClusterMetadata" do
      optional :original_request, :message, 1, "google.bigtable.admin.v2.Cluster"
      optional :request_time, :message, 2, "google.protobuf.Timestamp"
      optional :finish_time, :message, 3, "google.protobuf.Timestamp"
    end
    add_message "google.bigtable.admin.v2.CreateAppProfileRequest" do
      optional :parent, :string, 1
      optional :app_profile_id, :string, 2
      optional :app_profile, :message, 3, "google.bigtable.admin.v2.AppProfile"
      optional :ignore_warnings, :bool, 4
    end
    add_message "google.bigtable.admin.v2.GetAppProfileRequest" do
      optional :name, :string, 1
    end
    add_message "google.bigtable.admin.v2.ListAppProfilesRequest" do
      optional :parent, :string, 1
      optional :page_size, :int32, 3
      optional :page_token, :string, 2
    end
    add_message "google.bigtable.admin.v2.ListAppProfilesResponse" do
      repeated :app_profiles, :message, 1, "google.bigtable.admin.v2.AppProfile"
      optional :next_page_token, :string, 2
      repeated :failed_locations, :string, 3
    end
    add_message "google.bigtable.admin.v2.UpdateAppProfileRequest" do
      optional :app_profile, :message, 1, "google.bigtable.admin.v2.AppProfile"
      optional :update_mask, :message, 2, "google.protobuf.FieldMask"
      optional :ignore_warnings, :bool, 3
    end
    add_message "google.bigtable.admin.v2.DeleteAppProfileRequest" do
      optional :name, :string, 1
      optional :ignore_warnings, :bool, 2
    end
    add_message "google.bigtable.admin.v2.UpdateAppProfileMetadata" do
    end
  end
end

module Google
  module Cloud
    module Bigtable
      module Admin
        module V2
          CreateInstanceRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.CreateInstanceRequest").msgclass
          GetInstanceRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.GetInstanceRequest").msgclass
          ListInstancesRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.ListInstancesRequest").msgclass
          ListInstancesResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.ListInstancesResponse").msgclass
          PartialUpdateInstanceRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.PartialUpdateInstanceRequest").msgclass
          DeleteInstanceRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.DeleteInstanceRequest").msgclass
          CreateClusterRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.CreateClusterRequest").msgclass
          GetClusterRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.GetClusterRequest").msgclass
          ListClustersRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.ListClustersRequest").msgclass
          ListClustersResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.ListClustersResponse").msgclass
          DeleteClusterRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.DeleteClusterRequest").msgclass
          CreateInstanceMetadata = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.CreateInstanceMetadata").msgclass
          UpdateInstanceMetadata = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.UpdateInstanceMetadata").msgclass
          CreateClusterMetadata = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.CreateClusterMetadata").msgclass
          UpdateClusterMetadata = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.UpdateClusterMetadata").msgclass
          CreateAppProfileRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.CreateAppProfileRequest").msgclass
          GetAppProfileRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.GetAppProfileRequest").msgclass
          ListAppProfilesRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.ListAppProfilesRequest").msgclass
          ListAppProfilesResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.ListAppProfilesResponse").msgclass
          UpdateAppProfileRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.UpdateAppProfileRequest").msgclass
          DeleteAppProfileRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.DeleteAppProfileRequest").msgclass
          UpdateAppProfileMetadata = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.admin.v2.UpdateAppProfileMetadata").msgclass
        end
      end
    end
  end
end
