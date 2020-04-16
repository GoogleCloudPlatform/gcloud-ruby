# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/monitoring/v3/notification.proto

require 'google/protobuf'

require 'google/api/label_pb'
require 'google/api/launch_stage_pb'
require 'google/api/resource_pb'
require 'google/monitoring/v3/common_pb'
require 'google/protobuf/wrappers_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/monitoring/v3/notification.proto", :syntax => :proto3) do
    add_message "google.monitoring.v3.NotificationChannelDescriptor" do
      optional :name, :string, 6
      optional :type, :string, 1
      optional :display_name, :string, 2
      optional :description, :string, 3
      repeated :labels, :message, 4, "google.api.LabelDescriptor"
      repeated :supported_tiers, :enum, 5, "google.monitoring.v3.ServiceTier"
      optional :launch_stage, :enum, 7, "google.api.LaunchStage"
    end
    add_message "google.monitoring.v3.NotificationChannel" do
      optional :type, :string, 1
      optional :name, :string, 6
      optional :display_name, :string, 3
      optional :description, :string, 4
      map :labels, :string, :string, 5
      map :user_labels, :string, :string, 8
      optional :verification_status, :enum, 9, "google.monitoring.v3.NotificationChannel.VerificationStatus"
      optional :enabled, :message, 11, "google.protobuf.BoolValue"
    end
    add_enum "google.monitoring.v3.NotificationChannel.VerificationStatus" do
      value :VERIFICATION_STATUS_UNSPECIFIED, 0
      value :UNVERIFIED, 1
      value :VERIFIED, 2
    end
  end
end

module Google
  module Cloud
    module Monitoring
      module V3
        NotificationChannelDescriptor = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.NotificationChannelDescriptor").msgclass
        NotificationChannel = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.NotificationChannel").msgclass
        NotificationChannel::VerificationStatus = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.NotificationChannel.VerificationStatus").enummodule
      end
    end
  end
end
