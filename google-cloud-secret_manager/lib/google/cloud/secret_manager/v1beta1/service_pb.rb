# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/secret_manager/v1beta1/service.proto


require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/cloud/secret_manager/v1beta1/resources_pb'
require 'google/iam/v1/iam_policy_pb'
require 'google/iam/v1/policy_pb'
require 'google/protobuf/empty_pb'
require 'google/protobuf/field_mask_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "google.cloud.secrets.v1beta1.ListSecretsRequest" do
    optional :parent, :string, 1
    optional :page_size, :int32, 2
    optional :page_token, :string, 3
  end
  add_message "google.cloud.secrets.v1beta1.ListSecretsResponse" do
    repeated :secrets, :message, 1, "google.cloud.secrets.v1beta1.Secret"
    optional :next_page_token, :string, 2
    optional :total_size, :int32, 3
  end
  add_message "google.cloud.secrets.v1beta1.CreateSecretRequest" do
    optional :parent, :string, 1
    optional :secret_id, :string, 2
    optional :secret, :message, 3, "google.cloud.secrets.v1beta1.Secret"
  end
  add_message "google.cloud.secrets.v1beta1.AddSecretVersionRequest" do
    optional :parent, :string, 1
    optional :payload, :message, 2, "google.cloud.secrets.v1beta1.SecretPayload"
  end
  add_message "google.cloud.secrets.v1beta1.GetSecretRequest" do
    optional :name, :string, 1
  end
  add_message "google.cloud.secrets.v1beta1.ListSecretVersionsRequest" do
    optional :parent, :string, 1
    optional :page_size, :int32, 2
    optional :page_token, :string, 3
  end
  add_message "google.cloud.secrets.v1beta1.ListSecretVersionsResponse" do
    repeated :versions, :message, 1, "google.cloud.secrets.v1beta1.SecretVersion"
    optional :next_page_token, :string, 2
    optional :total_size, :int32, 3
  end
  add_message "google.cloud.secrets.v1beta1.GetSecretVersionRequest" do
    optional :name, :string, 1
  end
  add_message "google.cloud.secrets.v1beta1.UpdateSecretRequest" do
    optional :secret, :message, 1, "google.cloud.secrets.v1beta1.Secret"
    optional :update_mask, :message, 2, "google.protobuf.FieldMask"
  end
  add_message "google.cloud.secrets.v1beta1.AccessSecretVersionRequest" do
    optional :name, :string, 1
  end
  add_message "google.cloud.secrets.v1beta1.AccessSecretVersionResponse" do
    optional :name, :string, 1
    optional :payload, :message, 2, "google.cloud.secrets.v1beta1.SecretPayload"
  end
  add_message "google.cloud.secrets.v1beta1.DeleteSecretRequest" do
    optional :name, :string, 1
  end
  add_message "google.cloud.secrets.v1beta1.DisableSecretVersionRequest" do
    optional :name, :string, 1
  end
  add_message "google.cloud.secrets.v1beta1.EnableSecretVersionRequest" do
    optional :name, :string, 1
  end
  add_message "google.cloud.secrets.v1beta1.DestroySecretVersionRequest" do
    optional :name, :string, 1
  end
end

module Google::Cloud::SecretManager::V1beta1
  ListSecretsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.ListSecretsRequest").msgclass
  ListSecretsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.ListSecretsResponse").msgclass
  CreateSecretRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.CreateSecretRequest").msgclass
  AddSecretVersionRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.AddSecretVersionRequest").msgclass
  GetSecretRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.GetSecretRequest").msgclass
  ListSecretVersionsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.ListSecretVersionsRequest").msgclass
  ListSecretVersionsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.ListSecretVersionsResponse").msgclass
  GetSecretVersionRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.GetSecretVersionRequest").msgclass
  UpdateSecretRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.UpdateSecretRequest").msgclass
  AccessSecretVersionRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.AccessSecretVersionRequest").msgclass
  AccessSecretVersionResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.AccessSecretVersionResponse").msgclass
  DeleteSecretRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.DeleteSecretRequest").msgclass
  DisableSecretVersionRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.DisableSecretVersionRequest").msgclass
  EnableSecretVersionRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.EnableSecretVersionRequest").msgclass
  DestroySecretVersionRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.DestroySecretVersionRequest").msgclass
end
