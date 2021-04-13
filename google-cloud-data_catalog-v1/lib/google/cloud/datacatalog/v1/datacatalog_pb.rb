# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/datacatalog/v1/datacatalog.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/cloud/datacatalog/v1/common_pb'
require 'google/cloud/datacatalog/v1/data_source_pb'
require 'google/cloud/datacatalog/v1/gcs_fileset_spec_pb'
require 'google/cloud/datacatalog/v1/schema_pb'
require 'google/cloud/datacatalog/v1/search_pb'
require 'google/cloud/datacatalog/v1/table_spec_pb'
require 'google/cloud/datacatalog/v1/tags_pb'
require 'google/cloud/datacatalog/v1/timestamps_pb'
require 'google/iam/v1/iam_policy_pb'
require 'google/iam/v1/policy_pb'
require 'google/protobuf/empty_pb'
require 'google/protobuf/field_mask_pb'
require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/datacatalog/v1/datacatalog.proto", :syntax => :proto3) do
    add_message "google.cloud.datacatalog.v1.SearchCatalogRequest" do
      optional :scope, :message, 6, "google.cloud.datacatalog.v1.SearchCatalogRequest.Scope"
      optional :query, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
      optional :order_by, :string, 5
    end
    add_message "google.cloud.datacatalog.v1.SearchCatalogRequest.Scope" do
      repeated :include_org_ids, :string, 2
      repeated :include_project_ids, :string, 3
      optional :include_gcp_public_datasets, :bool, 7
      repeated :restricted_locations, :string, 16
    end
    add_message "google.cloud.datacatalog.v1.SearchCatalogResponse" do
      repeated :results, :message, 1, "google.cloud.datacatalog.v1.SearchCatalogResult"
      optional :next_page_token, :string, 3
      repeated :unreachable, :string, 6
    end
    add_message "google.cloud.datacatalog.v1.CreateEntryGroupRequest" do
      optional :parent, :string, 1
      optional :entry_group_id, :string, 3
      optional :entry_group, :message, 2, "google.cloud.datacatalog.v1.EntryGroup"
    end
    add_message "google.cloud.datacatalog.v1.UpdateEntryGroupRequest" do
      optional :entry_group, :message, 1, "google.cloud.datacatalog.v1.EntryGroup"
      optional :update_mask, :message, 2, "google.protobuf.FieldMask"
    end
    add_message "google.cloud.datacatalog.v1.GetEntryGroupRequest" do
      optional :name, :string, 1
      optional :read_mask, :message, 2, "google.protobuf.FieldMask"
    end
    add_message "google.cloud.datacatalog.v1.DeleteEntryGroupRequest" do
      optional :name, :string, 1
      optional :force, :bool, 2
    end
    add_message "google.cloud.datacatalog.v1.ListEntryGroupsRequest" do
      optional :parent, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
    end
    add_message "google.cloud.datacatalog.v1.ListEntryGroupsResponse" do
      repeated :entry_groups, :message, 1, "google.cloud.datacatalog.v1.EntryGroup"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.datacatalog.v1.CreateEntryRequest" do
      optional :parent, :string, 1
      optional :entry_id, :string, 3
      optional :entry, :message, 2, "google.cloud.datacatalog.v1.Entry"
    end
    add_message "google.cloud.datacatalog.v1.UpdateEntryRequest" do
      optional :entry, :message, 1, "google.cloud.datacatalog.v1.Entry"
      optional :update_mask, :message, 2, "google.protobuf.FieldMask"
    end
    add_message "google.cloud.datacatalog.v1.DeleteEntryRequest" do
      optional :name, :string, 1
    end
    add_message "google.cloud.datacatalog.v1.GetEntryRequest" do
      optional :name, :string, 1
    end
    add_message "google.cloud.datacatalog.v1.LookupEntryRequest" do
      oneof :target_name do
        optional :linked_resource, :string, 1
        optional :sql_resource, :string, 3
        optional :fully_qualified_name, :string, 5
      end
    end
    add_message "google.cloud.datacatalog.v1.Entry" do
      optional :name, :string, 1
      optional :linked_resource, :string, 9
      optional :fully_qualified_name, :string, 29
      optional :display_name, :string, 3
      optional :description, :string, 4
      optional :schema, :message, 5, "google.cloud.datacatalog.v1.Schema"
      optional :source_system_timestamps, :message, 7, "google.cloud.datacatalog.v1.SystemTimestamps"
      optional :data_source, :message, 20, "google.cloud.datacatalog.v1.DataSource"
      oneof :entry_type do
        optional :type, :enum, 2, "google.cloud.datacatalog.v1.EntryType"
        optional :user_specified_type, :string, 16
      end
      oneof :system do
        optional :integrated_system, :enum, 17, "google.cloud.datacatalog.v1.IntegratedSystem"
        optional :user_specified_system, :string, 18
      end
      oneof :type_spec do
        optional :gcs_fileset_spec, :message, 6, "google.cloud.datacatalog.v1.GcsFilesetSpec"
        optional :bigquery_table_spec, :message, 12, "google.cloud.datacatalog.v1.BigQueryTableSpec"
        optional :bigquery_date_sharded_spec, :message, 15, "google.cloud.datacatalog.v1.BigQueryDateShardedSpec"
      end
      oneof :spec do
        optional :database_table_spec, :message, 24, "google.cloud.datacatalog.v1.DatabaseTableSpec"
      end
    end
    add_message "google.cloud.datacatalog.v1.DatabaseTableSpec" do
      optional :type, :enum, 1, "google.cloud.datacatalog.v1.DatabaseTableSpec.TableType"
    end
    add_enum "google.cloud.datacatalog.v1.DatabaseTableSpec.TableType" do
      value :TABLE_TYPE_UNSPECIFIED, 0
      value :NATIVE, 1
      value :EXTERNAL, 2
    end
    add_message "google.cloud.datacatalog.v1.EntryGroup" do
      optional :name, :string, 1
      optional :display_name, :string, 2
      optional :description, :string, 3
      optional :data_catalog_timestamps, :message, 4, "google.cloud.datacatalog.v1.SystemTimestamps"
    end
    add_message "google.cloud.datacatalog.v1.CreateTagTemplateRequest" do
      optional :parent, :string, 1
      optional :tag_template_id, :string, 3
      optional :tag_template, :message, 2, "google.cloud.datacatalog.v1.TagTemplate"
    end
    add_message "google.cloud.datacatalog.v1.GetTagTemplateRequest" do
      optional :name, :string, 1
    end
    add_message "google.cloud.datacatalog.v1.UpdateTagTemplateRequest" do
      optional :tag_template, :message, 1, "google.cloud.datacatalog.v1.TagTemplate"
      optional :update_mask, :message, 2, "google.protobuf.FieldMask"
    end
    add_message "google.cloud.datacatalog.v1.DeleteTagTemplateRequest" do
      optional :name, :string, 1
      optional :force, :bool, 2
    end
    add_message "google.cloud.datacatalog.v1.CreateTagRequest" do
      optional :parent, :string, 1
      optional :tag, :message, 2, "google.cloud.datacatalog.v1.Tag"
    end
    add_message "google.cloud.datacatalog.v1.UpdateTagRequest" do
      optional :tag, :message, 1, "google.cloud.datacatalog.v1.Tag"
      optional :update_mask, :message, 2, "google.protobuf.FieldMask"
    end
    add_message "google.cloud.datacatalog.v1.DeleteTagRequest" do
      optional :name, :string, 1
    end
    add_message "google.cloud.datacatalog.v1.CreateTagTemplateFieldRequest" do
      optional :parent, :string, 1
      optional :tag_template_field_id, :string, 2
      optional :tag_template_field, :message, 3, "google.cloud.datacatalog.v1.TagTemplateField"
    end
    add_message "google.cloud.datacatalog.v1.UpdateTagTemplateFieldRequest" do
      optional :name, :string, 1
      optional :tag_template_field, :message, 2, "google.cloud.datacatalog.v1.TagTemplateField"
      optional :update_mask, :message, 3, "google.protobuf.FieldMask"
    end
    add_message "google.cloud.datacatalog.v1.RenameTagTemplateFieldRequest" do
      optional :name, :string, 1
      optional :new_tag_template_field_id, :string, 2
    end
    add_message "google.cloud.datacatalog.v1.RenameTagTemplateFieldEnumValueRequest" do
      optional :name, :string, 1
      optional :new_enum_value_display_name, :string, 2
    end
    add_message "google.cloud.datacatalog.v1.DeleteTagTemplateFieldRequest" do
      optional :name, :string, 1
      optional :force, :bool, 2
    end
    add_message "google.cloud.datacatalog.v1.ListTagsRequest" do
      optional :parent, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
    end
    add_message "google.cloud.datacatalog.v1.ListTagsResponse" do
      repeated :tags, :message, 1, "google.cloud.datacatalog.v1.Tag"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.datacatalog.v1.ListEntriesRequest" do
      optional :parent, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
      optional :read_mask, :message, 4, "google.protobuf.FieldMask"
    end
    add_message "google.cloud.datacatalog.v1.ListEntriesResponse" do
      repeated :entries, :message, 1, "google.cloud.datacatalog.v1.Entry"
      optional :next_page_token, :string, 2
    end
    add_enum "google.cloud.datacatalog.v1.EntryType" do
      value :ENTRY_TYPE_UNSPECIFIED, 0
      value :TABLE, 2
      value :MODEL, 5
      value :DATA_STREAM, 3
      value :FILESET, 4
      value :DATABASE, 7
      value :SERVICE, 14
    end
  end
end

module Google
  module Cloud
    module DataCatalog
      module V1
        SearchCatalogRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.SearchCatalogRequest").msgclass
        SearchCatalogRequest::Scope = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.SearchCatalogRequest.Scope").msgclass
        SearchCatalogResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.SearchCatalogResponse").msgclass
        CreateEntryGroupRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.CreateEntryGroupRequest").msgclass
        UpdateEntryGroupRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.UpdateEntryGroupRequest").msgclass
        GetEntryGroupRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.GetEntryGroupRequest").msgclass
        DeleteEntryGroupRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.DeleteEntryGroupRequest").msgclass
        ListEntryGroupsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.ListEntryGroupsRequest").msgclass
        ListEntryGroupsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.ListEntryGroupsResponse").msgclass
        CreateEntryRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.CreateEntryRequest").msgclass
        UpdateEntryRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.UpdateEntryRequest").msgclass
        DeleteEntryRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.DeleteEntryRequest").msgclass
        GetEntryRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.GetEntryRequest").msgclass
        LookupEntryRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.LookupEntryRequest").msgclass
        Entry = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.Entry").msgclass
        DatabaseTableSpec = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.DatabaseTableSpec").msgclass
        DatabaseTableSpec::TableType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.DatabaseTableSpec.TableType").enummodule
        EntryGroup = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.EntryGroup").msgclass
        CreateTagTemplateRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.CreateTagTemplateRequest").msgclass
        GetTagTemplateRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.GetTagTemplateRequest").msgclass
        UpdateTagTemplateRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.UpdateTagTemplateRequest").msgclass
        DeleteTagTemplateRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.DeleteTagTemplateRequest").msgclass
        CreateTagRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.CreateTagRequest").msgclass
        UpdateTagRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.UpdateTagRequest").msgclass
        DeleteTagRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.DeleteTagRequest").msgclass
        CreateTagTemplateFieldRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.CreateTagTemplateFieldRequest").msgclass
        UpdateTagTemplateFieldRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.UpdateTagTemplateFieldRequest").msgclass
        RenameTagTemplateFieldRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.RenameTagTemplateFieldRequest").msgclass
        RenameTagTemplateFieldEnumValueRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.RenameTagTemplateFieldEnumValueRequest").msgclass
        DeleteTagTemplateFieldRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.DeleteTagTemplateFieldRequest").msgclass
        ListTagsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.ListTagsRequest").msgclass
        ListTagsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.ListTagsResponse").msgclass
        ListEntriesRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.ListEntriesRequest").msgclass
        ListEntriesResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.ListEntriesResponse").msgclass
        EntryType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.datacatalog.v1.EntryType").enummodule
      end
    end
  end
end
