# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/devtools/clouderrorreporting/v1beta1/error_group_service.proto


require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/devtools/clouderrorreporting/v1beta1/common_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "google.devtools.clouderrorreporting.v1beta1.GetGroupRequest" do
    optional :group_name, :string, 1
  end
  add_message "google.devtools.clouderrorreporting.v1beta1.UpdateGroupRequest" do
    optional :group, :message, 1, "google.devtools.clouderrorreporting.v1beta1.ErrorGroup"
  end
end

module Google
  module Devtools
    module Clouderrorreporting
    end
  end
end
module Google::Devtools::Clouderrorreporting::V1beta1
  GetGroupRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.clouderrorreporting.v1beta1.GetGroupRequest").msgclass
  UpdateGroupRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.devtools.clouderrorreporting.v1beta1.UpdateGroupRequest").msgclass
end
