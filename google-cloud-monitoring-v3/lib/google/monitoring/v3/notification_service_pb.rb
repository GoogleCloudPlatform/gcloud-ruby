# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/monitoring/v3/notification_service.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/monitoring/v3/notification_pb'
require 'google/protobuf/empty_pb'
require 'google/protobuf/field_mask_pb'
require 'google/protobuf/struct_pb'
require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/monitoring/v3/notification_service.proto", :syntax => :proto3) do
    add_message "google.monitoring.v3.ListNotificationChannelDescriptorsRequest" do
      optional :name, :string, 4
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
    end
    add_message "google.monitoring.v3.ListNotificationChannelDescriptorsResponse" do
      repeated :channel_descriptors, :message, 1, "google.monitoring.v3.NotificationChannelDescriptor"
      optional :next_page_token, :string, 2
    end
    add_message "google.monitoring.v3.GetNotificationChannelDescriptorRequest" do
      optional :name, :string, 3
    end
    add_message "google.monitoring.v3.CreateNotificationChannelRequest" do
      optional :name, :string, 3
      optional :notification_channel, :message, 2, "google.monitoring.v3.NotificationChannel"
    end
    add_message "google.monitoring.v3.ListNotificationChannelsRequest" do
      optional :name, :string, 5
      optional :filter, :string, 6
      optional :order_by, :string, 7
      optional :page_size, :int32, 3
      optional :page_token, :string, 4
    end
    add_message "google.monitoring.v3.ListNotificationChannelsResponse" do
      repeated :notification_channels, :message, 3, "google.monitoring.v3.NotificationChannel"
      optional :next_page_token, :string, 2
    end
    add_message "google.monitoring.v3.GetNotificationChannelRequest" do
      optional :name, :string, 3
    end
    add_message "google.monitoring.v3.UpdateNotificationChannelRequest" do
      optional :update_mask, :message, 2, "google.protobuf.FieldMask"
      optional :notification_channel, :message, 3, "google.monitoring.v3.NotificationChannel"
    end
    add_message "google.monitoring.v3.DeleteNotificationChannelRequest" do
      optional :name, :string, 3
      optional :force, :bool, 5
    end
    add_message "google.monitoring.v3.SendNotificationChannelVerificationCodeRequest" do
      optional :name, :string, 1
    end
    add_message "google.monitoring.v3.GetNotificationChannelVerificationCodeRequest" do
      optional :name, :string, 1
      optional :expire_time, :message, 2, "google.protobuf.Timestamp"
    end
    add_message "google.monitoring.v3.GetNotificationChannelVerificationCodeResponse" do
      optional :code, :string, 1
      optional :expire_time, :message, 2, "google.protobuf.Timestamp"
    end
    add_message "google.monitoring.v3.VerifyNotificationChannelRequest" do
      optional :name, :string, 1
      optional :code, :string, 2
    end
  end
end

module Google
  module Cloud
    module Monitoring
      module V3
        ListNotificationChannelDescriptorsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.ListNotificationChannelDescriptorsRequest").msgclass
        ListNotificationChannelDescriptorsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.ListNotificationChannelDescriptorsResponse").msgclass
        GetNotificationChannelDescriptorRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.GetNotificationChannelDescriptorRequest").msgclass
        CreateNotificationChannelRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.CreateNotificationChannelRequest").msgclass
        ListNotificationChannelsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.ListNotificationChannelsRequest").msgclass
        ListNotificationChannelsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.ListNotificationChannelsResponse").msgclass
        GetNotificationChannelRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.GetNotificationChannelRequest").msgclass
        UpdateNotificationChannelRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.UpdateNotificationChannelRequest").msgclass
        DeleteNotificationChannelRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.DeleteNotificationChannelRequest").msgclass
        SendNotificationChannelVerificationCodeRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.SendNotificationChannelVerificationCodeRequest").msgclass
        GetNotificationChannelVerificationCodeRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.GetNotificationChannelVerificationCodeRequest").msgclass
        GetNotificationChannelVerificationCodeResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.GetNotificationChannelVerificationCodeResponse").msgclass
        VerifyNotificationChannelRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.VerifyNotificationChannelRequest").msgclass
      end
    end
  end
end
