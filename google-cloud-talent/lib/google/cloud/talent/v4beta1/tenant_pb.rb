# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/talent/v4beta1/tenant.proto


require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/field_behavior_pb'
require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "google.cloud.talent.v4beta1.Tenant" do
    optional :name, :string, 1
    optional :external_id, :string, 2
    optional :usage_type, :enum, 3, "google.cloud.talent.v4beta1.Tenant.DataUsageType"
    repeated :keyword_searchable_profile_custom_attributes, :string, 4
  end
  add_enum "google.cloud.talent.v4beta1.Tenant.DataUsageType" do
    value :DATA_USAGE_TYPE_UNSPECIFIED, 0
    value :AGGREGATED, 1
    value :ISOLATED, 2
  end
end

module Google
  module Cloud
    module Talent
      module V4beta1
        Tenant = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.talent.v4beta1.Tenant").msgclass
        Tenant::DataUsageType = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.talent.v4beta1.Tenant.DataUsageType").enummodule
      end
    end
  end
end
