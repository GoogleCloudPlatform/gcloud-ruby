# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/monitoring/v3/alert_service.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/monitoring/v3/alert_pb'
require 'google/protobuf/empty_pb'
require 'google/protobuf/field_mask_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/monitoring/v3/alert_service.proto", :syntax => :proto3) do
    add_message "google.monitoring.v3.CreateAlertPolicyRequest" do
      optional :name, :string, 3
      optional :alert_policy, :message, 2, "google.monitoring.v3.AlertPolicy"
    end
    add_message "google.monitoring.v3.GetAlertPolicyRequest" do
      optional :name, :string, 3
    end
    add_message "google.monitoring.v3.ListAlertPoliciesRequest" do
      optional :name, :string, 4
      optional :filter, :string, 5
      optional :order_by, :string, 6
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
    end
    add_message "google.monitoring.v3.ListAlertPoliciesResponse" do
      repeated :alert_policies, :message, 3, "google.monitoring.v3.AlertPolicy"
      optional :next_page_token, :string, 2
    end
    add_message "google.monitoring.v3.UpdateAlertPolicyRequest" do
      optional :update_mask, :message, 2, "google.protobuf.FieldMask"
      optional :alert_policy, :message, 3, "google.monitoring.v3.AlertPolicy"
    end
    add_message "google.monitoring.v3.DeleteAlertPolicyRequest" do
      optional :name, :string, 3
    end
  end
end

module Google
  module Cloud
    module Monitoring
      module V3
        CreateAlertPolicyRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.CreateAlertPolicyRequest").msgclass
        GetAlertPolicyRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.GetAlertPolicyRequest").msgclass
        ListAlertPoliciesRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.ListAlertPoliciesRequest").msgclass
        ListAlertPoliciesResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.ListAlertPoliciesResponse").msgclass
        UpdateAlertPolicyRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.UpdateAlertPolicyRequest").msgclass
        DeleteAlertPolicyRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.monitoring.v3.DeleteAlertPolicyRequest").msgclass
      end
    end
  end
end
