# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/channel/v1/operations.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/channel/v1/operations.proto", :syntax => :proto3) do
    add_message "google.cloud.channel.v1.OperationMetadata" do
      optional :operation_type, :enum, 1, "google.cloud.channel.v1.OperationMetadata.OperationType"
    end
    add_enum "google.cloud.channel.v1.OperationMetadata.OperationType" do
      value :OPERATION_TYPE_UNSPECIFIED, 0
      value :CREATE_ENTITLEMENT, 1
      value :CHANGE_RENEWAL_SETTINGS, 3
      value :START_PAID_SERVICE, 5
      value :ACTIVATE_ENTITLEMENT, 7
      value :SUSPEND_ENTITLEMENT, 8
      value :CANCEL_ENTITLEMENT, 9
      value :TRANSFER_ENTITLEMENTS, 10
      value :TRANSFER_ENTITLEMENTS_TO_GOOGLE, 11
      value :CHANGE_OFFER, 14
      value :CHANGE_PARAMETERS, 15
      value :PROVISION_CLOUD_IDENTITY, 16
    end
  end
end

module Google
  module Cloud
    module Channel
      module V1
        OperationMetadata = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.OperationMetadata").msgclass
        OperationMetadata::OperationType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.OperationMetadata.OperationType").enummodule
      end
    end
  end
end
