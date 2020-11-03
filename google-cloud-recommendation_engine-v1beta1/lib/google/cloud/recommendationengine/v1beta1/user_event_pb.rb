# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/recommendationengine/v1beta1/user_event.proto

require 'google/protobuf'

require 'google/api/field_behavior_pb'
require 'google/cloud/recommendationengine/v1beta1/catalog_pb'
require 'google/cloud/recommendationengine/v1beta1/common_pb'
require 'google/protobuf/timestamp_pb'
require 'google/api/annotations_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/recommendationengine/v1beta1/user_event.proto", :syntax => :proto3) do
    add_message "google.cloud.recommendationengine.v1beta1.UserEvent" do
      optional :event_type, :string, 1
      optional :user_info, :message, 2, "google.cloud.recommendationengine.v1beta1.UserInfo"
      optional :event_detail, :message, 3, "google.cloud.recommendationengine.v1beta1.EventDetail"
      optional :product_event_detail, :message, 4, "google.cloud.recommendationengine.v1beta1.ProductEventDetail"
      optional :event_time, :message, 5, "google.protobuf.Timestamp"
      optional :event_source, :enum, 6, "google.cloud.recommendationengine.v1beta1.UserEvent.EventSource"
    end
    add_enum "google.cloud.recommendationengine.v1beta1.UserEvent.EventSource" do
      value :EVENT_SOURCE_UNSPECIFIED, 0
      value :AUTOML, 1
      value :ECOMMERCE, 2
      value :BATCH_UPLOAD, 3
    end
    add_message "google.cloud.recommendationengine.v1beta1.UserInfo" do
      optional :visitor_id, :string, 1
      optional :user_id, :string, 2
      optional :ip_address, :string, 3
      optional :user_agent, :string, 4
      optional :direct_user_request, :bool, 5
    end
    add_message "google.cloud.recommendationengine.v1beta1.EventDetail" do
      optional :uri, :string, 1
      optional :referrer_uri, :string, 6
      optional :page_view_id, :string, 2
      repeated :experiment_ids, :string, 3
      optional :recommendation_token, :string, 4
      optional :event_attributes, :message, 5, "google.cloud.recommendationengine.v1beta1.FeatureMap"
    end
    add_message "google.cloud.recommendationengine.v1beta1.ProductEventDetail" do
      optional :search_query, :string, 1
      repeated :page_categories, :message, 2, "google.cloud.recommendationengine.v1beta1.CatalogItem.CategoryHierarchy"
      repeated :product_details, :message, 3, "google.cloud.recommendationengine.v1beta1.ProductDetail"
      optional :list_id, :string, 4
      optional :cart_id, :string, 5
      optional :purchase_transaction, :message, 6, "google.cloud.recommendationengine.v1beta1.PurchaseTransaction"
    end
    add_message "google.cloud.recommendationengine.v1beta1.PurchaseTransaction" do
      optional :id, :string, 1
      optional :revenue, :float, 2
      map :taxes, :string, :float, 3
      map :costs, :string, :float, 4
      optional :currency_code, :string, 6
    end
    add_message "google.cloud.recommendationengine.v1beta1.ProductDetail" do
      optional :id, :string, 1
      optional :currency_code, :string, 2
      optional :original_price, :float, 3
      optional :display_price, :float, 4
      optional :stock_state, :enum, 5, "google.cloud.recommendationengine.v1beta1.ProductCatalogItem.StockState"
      optional :quantity, :int32, 6
      optional :available_quantity, :int32, 7
      optional :item_attributes, :message, 8, "google.cloud.recommendationengine.v1beta1.FeatureMap"
    end
  end
end

module Google
  module Cloud
    module RecommendationEngine
      module V1beta1
        UserEvent = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.recommendationengine.v1beta1.UserEvent").msgclass
        UserEvent::EventSource = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.recommendationengine.v1beta1.UserEvent.EventSource").enummodule
        UserInfo = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.recommendationengine.v1beta1.UserInfo").msgclass
        EventDetail = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.recommendationengine.v1beta1.EventDetail").msgclass
        ProductEventDetail = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.recommendationengine.v1beta1.ProductEventDetail").msgclass
        PurchaseTransaction = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.recommendationengine.v1beta1.PurchaseTransaction").msgclass
        ProductDetail = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.recommendationengine.v1beta1.ProductDetail").msgclass
      end
    end
  end
end
