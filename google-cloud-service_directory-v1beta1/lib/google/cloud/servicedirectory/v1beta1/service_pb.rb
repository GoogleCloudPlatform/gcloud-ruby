# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/servicedirectory/v1beta1/service.proto

require 'google/protobuf'

require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/cloud/servicedirectory/v1beta1/endpoint_pb'
require 'google/api/annotations_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/servicedirectory/v1beta1/service.proto", :syntax => :proto3) do
    add_message "google.cloud.servicedirectory.v1beta1.Service" do
      optional :name, :string, 1
      map :metadata, :string, :string, 2
      repeated :endpoints, :message, 3, "google.cloud.servicedirectory.v1beta1.Endpoint"
    end
  end
end

module Google
  module Cloud
    module ServiceDirectory
      module V1beta1
        Service = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.servicedirectory.v1beta1.Service").msgclass
      end
    end
  end
end
