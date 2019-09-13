# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/talent/v4beta1/profile_service.proto


require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/cloud/talent/v4beta1/common_pb'
require 'google/cloud/talent/v4beta1/filters_pb'
require 'google/cloud/talent/v4beta1/histogram_pb'
require 'google/cloud/talent/v4beta1/profile_pb'
require 'google/protobuf/any_pb'
require 'google/protobuf/empty_pb'
require 'google/protobuf/field_mask_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "google.cloud.talent.v4beta1.ListProfilesRequest" do
    optional :parent, :string, 1
    optional :filter, :string, 5
    optional :page_token, :string, 2
    optional :page_size, :int32, 3
    optional :read_mask, :message, 4, "google.protobuf.FieldMask"
  end
  add_message "google.cloud.talent.v4beta1.ListProfilesResponse" do
    repeated :profiles, :message, 1, "google.cloud.talent.v4beta1.Profile"
    optional :next_page_token, :string, 2
  end
  add_message "google.cloud.talent.v4beta1.CreateProfileRequest" do
    optional :parent, :string, 1
    optional :profile, :message, 2, "google.cloud.talent.v4beta1.Profile"
  end
  add_message "google.cloud.talent.v4beta1.GetProfileRequest" do
    optional :name, :string, 1
  end
  add_message "google.cloud.talent.v4beta1.UpdateProfileRequest" do
    optional :profile, :message, 1, "google.cloud.talent.v4beta1.Profile"
    optional :update_mask, :message, 2, "google.protobuf.FieldMask"
  end
  add_message "google.cloud.talent.v4beta1.DeleteProfileRequest" do
    optional :name, :string, 1
  end
  add_message "google.cloud.talent.v4beta1.SearchProfilesRequest" do
    optional :parent, :string, 1
    optional :request_metadata, :message, 2, "google.cloud.talent.v4beta1.RequestMetadata"
    optional :profile_query, :message, 3, "google.cloud.talent.v4beta1.ProfileQuery"
    optional :page_size, :int32, 4
    optional :page_token, :string, 5
    optional :offset, :int32, 6
    optional :disable_spell_check, :bool, 7
    optional :order_by, :string, 8
    optional :case_sensitive_sort, :bool, 9
    repeated :histogram_queries, :message, 10, "google.cloud.talent.v4beta1.HistogramQuery"
    optional :result_set_id, :string, 12
    optional :strict_keywords_search, :bool, 13
  end
  add_message "google.cloud.talent.v4beta1.SearchProfilesResponse" do
    optional :estimated_total_size, :int64, 1
    optional :spell_correction, :message, 2, "google.cloud.talent.v4beta1.SpellingCorrection"
    optional :metadata, :message, 3, "google.cloud.talent.v4beta1.ResponseMetadata"
    optional :next_page_token, :string, 4
    repeated :histogram_query_results, :message, 5, "google.cloud.talent.v4beta1.HistogramQueryResult"
    repeated :summarized_profiles, :message, 6, "google.cloud.talent.v4beta1.SummarizedProfile"
    optional :result_set_id, :string, 7
  end
  add_message "google.cloud.talent.v4beta1.SummarizedProfile" do
    repeated :profiles, :message, 1, "google.cloud.talent.v4beta1.Profile"
    optional :summary, :message, 2, "google.cloud.talent.v4beta1.Profile"
  end
end

module Google
  module Cloud
    module Talent
      module V4beta1
        ListProfilesRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.talent.v4beta1.ListProfilesRequest").msgclass
        ListProfilesResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.talent.v4beta1.ListProfilesResponse").msgclass
        CreateProfileRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.talent.v4beta1.CreateProfileRequest").msgclass
        GetProfileRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.talent.v4beta1.GetProfileRequest").msgclass
        UpdateProfileRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.talent.v4beta1.UpdateProfileRequest").msgclass
        DeleteProfileRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.talent.v4beta1.DeleteProfileRequest").msgclass
        SearchProfilesRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.talent.v4beta1.SearchProfilesRequest").msgclass
        SearchProfilesResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.talent.v4beta1.SearchProfilesResponse").msgclass
        SummarizedProfile = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.talent.v4beta1.SummarizedProfile").msgclass
      end
    end
  end
end
