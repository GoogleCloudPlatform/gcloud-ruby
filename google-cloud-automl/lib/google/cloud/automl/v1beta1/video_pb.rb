# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/automl/v1beta1/video.proto


require 'google/protobuf'

require 'google/cloud/automl/v1beta1/classification_pb'
require 'google/api/annotations_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "google.cloud.automl.v1beta1.VideoClassificationDatasetMetadata" do
  end
  add_message "google.cloud.automl.v1beta1.VideoObjectTrackingDatasetMetadata" do
  end
  add_message "google.cloud.automl.v1beta1.VideoClassificationModelMetadata" do
  end
  add_message "google.cloud.automl.v1beta1.VideoObjectTrackingModelMetadata" do
  end
end

module Google::Cloud::AutoML::V1beta1
  VideoClassificationDatasetMetadata = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.automl.v1beta1.VideoClassificationDatasetMetadata").msgclass
  VideoObjectTrackingDatasetMetadata = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.automl.v1beta1.VideoObjectTrackingDatasetMetadata").msgclass
  VideoClassificationModelMetadata = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.automl.v1beta1.VideoClassificationModelMetadata").msgclass
  VideoObjectTrackingModelMetadata = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.automl.v1beta1.VideoObjectTrackingModelMetadata").msgclass
end
