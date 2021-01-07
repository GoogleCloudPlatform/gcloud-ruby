# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/retail/v2/catalog_service.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/cloud/retail/v2/catalog_pb'
require 'google/protobuf/empty_pb'
require 'google/protobuf/field_mask_pb'
require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/retail/v2/catalog_service.proto", :syntax => :proto3) do
    add_message "google.cloud.retail.v2.ListCatalogsRequest" do
      optional :parent, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
    end
    add_message "google.cloud.retail.v2.ListCatalogsResponse" do
      repeated :catalogs, :message, 1, "google.cloud.retail.v2.Catalog"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.retail.v2.UpdateCatalogRequest" do
      optional :catalog, :message, 1, "google.cloud.retail.v2.Catalog"
      optional :update_mask, :message, 2, "google.protobuf.FieldMask"
    end
  end
end

module Google
  module Cloud
    module Retail
      module V2
        ListCatalogsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.retail.v2.ListCatalogsRequest").msgclass
        ListCatalogsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.retail.v2.ListCatalogsResponse").msgclass
        UpdateCatalogRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.retail.v2.UpdateCatalogRequest").msgclass
      end
    end
  end
end
