# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/talent/v4/tenant.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/talent/v4/tenant.proto", :syntax => :proto3) do
    add_message "google.cloud.talent.v4.Tenant" do
      optional :name, :string, 1
      optional :external_id, :string, 2
    end
  end
end

module Google
  module Cloud
    module Talent
      module V4
        Tenant = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.talent.v4.Tenant").msgclass
      end
    end
  end
end
