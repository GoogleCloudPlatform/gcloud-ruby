# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/securitycenter/v1p1beta1/asset.proto

require 'google/protobuf'

require 'google/api/resource_pb'
require 'google/cloud/securitycenter/v1p1beta1/folder_pb'
require 'google/cloud/securitycenter/v1p1beta1/security_marks_pb'
require 'google/protobuf/struct_pb'
require 'google/protobuf/timestamp_pb'
require 'google/api/annotations_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/securitycenter/v1p1beta1/asset.proto", :syntax => :proto3) do
    add_message "google.cloud.securitycenter.v1p1beta1.Asset" do
      optional :name, :string, 1
      optional :security_center_properties, :message, 2, "google.cloud.securitycenter.v1p1beta1.Asset.SecurityCenterProperties"
      map :resource_properties, :string, :message, 7, "google.protobuf.Value"
      optional :security_marks, :message, 8, "google.cloud.securitycenter.v1p1beta1.SecurityMarks"
      optional :create_time, :message, 9, "google.protobuf.Timestamp"
      optional :update_time, :message, 10, "google.protobuf.Timestamp"
      optional :iam_policy, :message, 11, "google.cloud.securitycenter.v1p1beta1.Asset.IamPolicy"
      optional :canonical_name, :string, 13
    end
    add_message "google.cloud.securitycenter.v1p1beta1.Asset.SecurityCenterProperties" do
      optional :resource_name, :string, 1
      optional :resource_type, :string, 2
      optional :resource_parent, :string, 3
      optional :resource_project, :string, 4
      repeated :resource_owners, :string, 5
      optional :resource_display_name, :string, 6
      optional :resource_parent_display_name, :string, 7
      optional :resource_project_display_name, :string, 8
      repeated :folders, :message, 10, "google.cloud.securitycenter.v1p1beta1.Folder"
    end
    add_message "google.cloud.securitycenter.v1p1beta1.Asset.IamPolicy" do
      optional :policy_blob, :string, 1
    end
  end
end

module Google
  module Cloud
    module SecurityCenter
      module V1p1beta1
        Asset = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.securitycenter.v1p1beta1.Asset").msgclass
        Asset::SecurityCenterProperties = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.securitycenter.v1p1beta1.Asset.SecurityCenterProperties").msgclass
        Asset::IamPolicy = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.securitycenter.v1p1beta1.Asset.IamPolicy").msgclass
      end
    end
  end
end
