# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/recommendationengine/v1beta1/common.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/recommendationengine/v1beta1/common.proto", :syntax => :proto3) do
    add_message "google.cloud.recommendationengine.v1beta1.FeatureMap" do
      map :categorical_features, :string, :message, 1, "google.cloud.recommendationengine.v1beta1.FeatureMap.StringList"
      map :numerical_features, :string, :message, 2, "google.cloud.recommendationengine.v1beta1.FeatureMap.FloatList"
    end
    add_message "google.cloud.recommendationengine.v1beta1.FeatureMap.StringList" do
      repeated :value, :string, 1
    end
    add_message "google.cloud.recommendationengine.v1beta1.FeatureMap.FloatList" do
      repeated :value, :float, 1
    end
  end
end

module Google
  module Cloud
    module RecommendationEngine
      module V1beta1
        FeatureMap = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.recommendationengine.v1beta1.FeatureMap").msgclass
        FeatureMap::StringList = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.recommendationengine.v1beta1.FeatureMap.StringList").msgclass
        FeatureMap::FloatList = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.recommendationengine.v1beta1.FeatureMap.FloatList").msgclass
      end
    end
  end
end
