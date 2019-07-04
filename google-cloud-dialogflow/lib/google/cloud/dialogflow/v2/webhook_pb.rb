# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/dialogflow/v2/webhook.proto


require 'google/protobuf'

require 'google/cloud/dialogflow/v2/context_pb'
require 'google/cloud/dialogflow/v2/intent_pb'
require 'google/cloud/dialogflow/v2/session_pb'
require 'google/cloud/dialogflow/v2/session_entity_type_pb'
require 'google/protobuf/struct_pb'
require 'google/api/annotations_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "google.cloud.dialogflow.v2.WebhookRequest" do
    optional :session, :string, 4
    optional :response_id, :string, 1
    optional :query_result, :message, 2, "google.cloud.dialogflow.v2.QueryResult"
    optional :original_detect_intent_request, :message, 3, "google.cloud.dialogflow.v2.OriginalDetectIntentRequest"
  end
  add_message "google.cloud.dialogflow.v2.WebhookResponse" do
    optional :fulfillment_text, :string, 1
    repeated :fulfillment_messages, :message, 2, "google.cloud.dialogflow.v2.Intent.Message"
    optional :source, :string, 3
    optional :payload, :message, 4, "google.protobuf.Struct"
    repeated :output_contexts, :message, 5, "google.cloud.dialogflow.v2.Context"
    optional :followup_event_input, :message, 6, "google.cloud.dialogflow.v2.EventInput"
  end
  add_message "google.cloud.dialogflow.v2.OriginalDetectIntentRequest" do
    optional :source, :string, 1
    optional :version, :string, 2
    optional :payload, :message, 3, "google.protobuf.Struct"
  end
end

module Google
  module Cloud
    module Dialogflow
      module V2
        WebhookRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dialogflow.v2.WebhookRequest").msgclass
        WebhookResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dialogflow.v2.WebhookResponse").msgclass
        OriginalDetectIntentRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.dialogflow.v2.OriginalDetectIntentRequest").msgclass
      end
    end
  end
end
