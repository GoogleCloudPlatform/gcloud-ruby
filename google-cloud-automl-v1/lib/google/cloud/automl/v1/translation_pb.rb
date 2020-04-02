# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/automl/v1/translation.proto

require 'google/protobuf'

require 'google/api/field_behavior_pb'
require 'google/cloud/automl/v1/data_items_pb'
require 'google/api/annotations_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/automl/v1/translation.proto", :syntax => :proto3) do
    add_message "google.cloud.automl.v1.TranslationDatasetMetadata" do
      optional :source_language_code, :string, 1
      optional :target_language_code, :string, 2
    end
    add_message "google.cloud.automl.v1.TranslationEvaluationMetrics" do
      optional :bleu_score, :double, 1
      optional :base_bleu_score, :double, 2
    end
    add_message "google.cloud.automl.v1.TranslationModelMetadata" do
      optional :base_model, :string, 1
      optional :source_language_code, :string, 2
      optional :target_language_code, :string, 3
    end
    add_message "google.cloud.automl.v1.TranslationAnnotation" do
      optional :translated_content, :message, 1, "google.cloud.automl.v1.TextSnippet"
    end
  end
end

module Google
  module Cloud
    module AutoML
      module V1
        TranslationDatasetMetadata = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.automl.v1.TranslationDatasetMetadata").msgclass
        TranslationEvaluationMetrics = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.automl.v1.TranslationEvaluationMetrics").msgclass
        TranslationModelMetadata = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.automl.v1.TranslationModelMetadata").msgclass
        TranslationAnnotation = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.automl.v1.TranslationAnnotation").msgclass
      end
    end
  end
end
