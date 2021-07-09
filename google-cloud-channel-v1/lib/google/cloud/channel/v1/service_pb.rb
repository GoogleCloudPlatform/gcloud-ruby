# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/channel/v1/service.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/cloud/channel/v1/channel_partner_links_pb'
require 'google/cloud/channel/v1/common_pb'
require 'google/cloud/channel/v1/customers_pb'
require 'google/cloud/channel/v1/entitlements_pb'
require 'google/cloud/channel/v1/offers_pb'
require 'google/cloud/channel/v1/products_pb'
require 'google/longrunning/operations_pb'
require 'google/protobuf/empty_pb'
require 'google/protobuf/field_mask_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/channel/v1/service.proto", :syntax => :proto3) do
    add_message "google.cloud.channel.v1.CheckCloudIdentityAccountsExistRequest" do
      optional :parent, :string, 1
      optional :domain, :string, 2
    end
    add_message "google.cloud.channel.v1.CloudIdentityCustomerAccount" do
      optional :existing, :bool, 1
      optional :owned, :bool, 2
      optional :customer_name, :string, 3
      optional :customer_cloud_identity_id, :string, 4
    end
    add_message "google.cloud.channel.v1.CheckCloudIdentityAccountsExistResponse" do
      repeated :cloud_identity_accounts, :message, 1, "google.cloud.channel.v1.CloudIdentityCustomerAccount"
    end
    add_message "google.cloud.channel.v1.ListCustomersRequest" do
      optional :parent, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
    end
    add_message "google.cloud.channel.v1.ListCustomersResponse" do
      repeated :customers, :message, 1, "google.cloud.channel.v1.Customer"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.channel.v1.GetCustomerRequest" do
      optional :name, :string, 1
    end
    add_message "google.cloud.channel.v1.CreateCustomerRequest" do
      optional :parent, :string, 1
      optional :customer, :message, 2, "google.cloud.channel.v1.Customer"
    end
    add_message "google.cloud.channel.v1.UpdateCustomerRequest" do
      optional :customer, :message, 2, "google.cloud.channel.v1.Customer"
      optional :update_mask, :message, 3, "google.protobuf.FieldMask"
    end
    add_message "google.cloud.channel.v1.DeleteCustomerRequest" do
      optional :name, :string, 1
    end
    add_message "google.cloud.channel.v1.ProvisionCloudIdentityRequest" do
      optional :customer, :string, 1
      optional :cloud_identity_info, :message, 2, "google.cloud.channel.v1.CloudIdentityInfo"
      optional :user, :message, 3, "google.cloud.channel.v1.AdminUser"
      optional :validate_only, :bool, 4
    end
    add_message "google.cloud.channel.v1.ListEntitlementsRequest" do
      optional :parent, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
    end
    add_message "google.cloud.channel.v1.ListEntitlementsResponse" do
      repeated :entitlements, :message, 1, "google.cloud.channel.v1.Entitlement"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.channel.v1.ListTransferableSkusRequest" do
      optional :parent, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
      optional :auth_token, :string, 5
      optional :language_code, :string, 6
      oneof :transferred_customer_identity do
        optional :cloud_identity_id, :string, 4
        optional :customer_name, :string, 7
      end
    end
    add_message "google.cloud.channel.v1.ListTransferableSkusResponse" do
      repeated :transferable_skus, :message, 1, "google.cloud.channel.v1.TransferableSku"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.channel.v1.ListTransferableOffersRequest" do
      optional :parent, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
      optional :sku, :string, 6
      optional :language_code, :string, 7
      oneof :transferred_customer_identity do
        optional :cloud_identity_id, :string, 4
        optional :customer_name, :string, 5
      end
    end
    add_message "google.cloud.channel.v1.ListTransferableOffersResponse" do
      repeated :transferable_offers, :message, 1, "google.cloud.channel.v1.TransferableOffer"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.channel.v1.TransferableOffer" do
      optional :offer, :message, 1, "google.cloud.channel.v1.Offer"
    end
    add_message "google.cloud.channel.v1.GetEntitlementRequest" do
      optional :name, :string, 1
    end
    add_message "google.cloud.channel.v1.ListChannelPartnerLinksRequest" do
      optional :parent, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
      optional :view, :enum, 4, "google.cloud.channel.v1.ChannelPartnerLinkView"
    end
    add_message "google.cloud.channel.v1.ListChannelPartnerLinksResponse" do
      repeated :channel_partner_links, :message, 1, "google.cloud.channel.v1.ChannelPartnerLink"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.channel.v1.GetChannelPartnerLinkRequest" do
      optional :name, :string, 1
      optional :view, :enum, 2, "google.cloud.channel.v1.ChannelPartnerLinkView"
    end
    add_message "google.cloud.channel.v1.CreateChannelPartnerLinkRequest" do
      optional :parent, :string, 1
      optional :channel_partner_link, :message, 2, "google.cloud.channel.v1.ChannelPartnerLink"
    end
    add_message "google.cloud.channel.v1.UpdateChannelPartnerLinkRequest" do
      optional :name, :string, 1
      optional :channel_partner_link, :message, 2, "google.cloud.channel.v1.ChannelPartnerLink"
      optional :update_mask, :message, 3, "google.protobuf.FieldMask"
    end
    add_message "google.cloud.channel.v1.CreateEntitlementRequest" do
      optional :parent, :string, 1
      optional :entitlement, :message, 2, "google.cloud.channel.v1.Entitlement"
      optional :request_id, :string, 5
    end
    add_message "google.cloud.channel.v1.TransferEntitlementsRequest" do
      optional :parent, :string, 1
      repeated :entitlements, :message, 2, "google.cloud.channel.v1.Entitlement"
      optional :auth_token, :string, 4
      optional :request_id, :string, 6
    end
    add_message "google.cloud.channel.v1.TransferEntitlementsResponse" do
      repeated :entitlements, :message, 1, "google.cloud.channel.v1.Entitlement"
    end
    add_message "google.cloud.channel.v1.TransferEntitlementsToGoogleRequest" do
      optional :parent, :string, 1
      repeated :entitlements, :message, 2, "google.cloud.channel.v1.Entitlement"
      optional :request_id, :string, 3
    end
    add_message "google.cloud.channel.v1.ChangeParametersRequest" do
      optional :name, :string, 1
      repeated :parameters, :message, 2, "google.cloud.channel.v1.Parameter"
      optional :request_id, :string, 4
      optional :purchase_order_id, :string, 5
    end
    add_message "google.cloud.channel.v1.ChangeRenewalSettingsRequest" do
      optional :name, :string, 1
      optional :renewal_settings, :message, 4, "google.cloud.channel.v1.RenewalSettings"
      optional :request_id, :string, 5
    end
    add_message "google.cloud.channel.v1.ChangeOfferRequest" do
      optional :name, :string, 1
      optional :offer, :string, 2
      repeated :parameters, :message, 3, "google.cloud.channel.v1.Parameter"
      optional :purchase_order_id, :string, 5
      optional :request_id, :string, 6
    end
    add_message "google.cloud.channel.v1.StartPaidServiceRequest" do
      optional :name, :string, 1
      optional :request_id, :string, 3
    end
    add_message "google.cloud.channel.v1.CancelEntitlementRequest" do
      optional :name, :string, 1
      optional :request_id, :string, 3
    end
    add_message "google.cloud.channel.v1.SuspendEntitlementRequest" do
      optional :name, :string, 1
      optional :request_id, :string, 3
    end
    add_message "google.cloud.channel.v1.ActivateEntitlementRequest" do
      optional :name, :string, 1
      optional :request_id, :string, 3
    end
    add_message "google.cloud.channel.v1.LookupOfferRequest" do
      optional :entitlement, :string, 1
    end
    add_message "google.cloud.channel.v1.ListProductsRequest" do
      optional :account, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
      optional :language_code, :string, 4
    end
    add_message "google.cloud.channel.v1.ListProductsResponse" do
      repeated :products, :message, 1, "google.cloud.channel.v1.Product"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.channel.v1.ListSkusRequest" do
      optional :parent, :string, 1
      optional :account, :string, 2
      optional :page_size, :int32, 3
      optional :page_token, :string, 4
      optional :language_code, :string, 5
    end
    add_message "google.cloud.channel.v1.ListSkusResponse" do
      repeated :skus, :message, 1, "google.cloud.channel.v1.Sku"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.channel.v1.ListOffersRequest" do
      optional :parent, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
      optional :filter, :string, 4
      optional :language_code, :string, 5
    end
    add_message "google.cloud.channel.v1.ListOffersResponse" do
      repeated :offers, :message, 1, "google.cloud.channel.v1.Offer"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.channel.v1.ListPurchasableSkusRequest" do
      optional :customer, :string, 1
      optional :page_size, :int32, 4
      optional :page_token, :string, 5
      optional :language_code, :string, 6
      oneof :purchase_option do
        optional :create_entitlement_purchase, :message, 2, "google.cloud.channel.v1.ListPurchasableSkusRequest.CreateEntitlementPurchase"
        optional :change_offer_purchase, :message, 3, "google.cloud.channel.v1.ListPurchasableSkusRequest.ChangeOfferPurchase"
      end
    end
    add_message "google.cloud.channel.v1.ListPurchasableSkusRequest.CreateEntitlementPurchase" do
      optional :product, :string, 1
    end
    add_message "google.cloud.channel.v1.ListPurchasableSkusRequest.ChangeOfferPurchase" do
      optional :entitlement, :string, 1
      optional :change_type, :enum, 2, "google.cloud.channel.v1.ListPurchasableSkusRequest.ChangeOfferPurchase.ChangeType"
    end
    add_enum "google.cloud.channel.v1.ListPurchasableSkusRequest.ChangeOfferPurchase.ChangeType" do
      value :CHANGE_TYPE_UNSPECIFIED, 0
      value :UPGRADE, 1
      value :DOWNGRADE, 2
    end
    add_message "google.cloud.channel.v1.ListPurchasableSkusResponse" do
      repeated :purchasable_skus, :message, 1, "google.cloud.channel.v1.PurchasableSku"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.channel.v1.PurchasableSku" do
      optional :sku, :message, 1, "google.cloud.channel.v1.Sku"
    end
    add_message "google.cloud.channel.v1.ListPurchasableOffersRequest" do
      optional :customer, :string, 1
      optional :page_size, :int32, 4
      optional :page_token, :string, 5
      optional :language_code, :string, 6
      oneof :purchase_option do
        optional :create_entitlement_purchase, :message, 2, "google.cloud.channel.v1.ListPurchasableOffersRequest.CreateEntitlementPurchase"
        optional :change_offer_purchase, :message, 3, "google.cloud.channel.v1.ListPurchasableOffersRequest.ChangeOfferPurchase"
      end
    end
    add_message "google.cloud.channel.v1.ListPurchasableOffersRequest.CreateEntitlementPurchase" do
      optional :sku, :string, 1
    end
    add_message "google.cloud.channel.v1.ListPurchasableOffersRequest.ChangeOfferPurchase" do
      optional :entitlement, :string, 1
      optional :new_sku, :string, 2
    end
    add_message "google.cloud.channel.v1.ListPurchasableOffersResponse" do
      repeated :purchasable_offers, :message, 1, "google.cloud.channel.v1.PurchasableOffer"
      optional :next_page_token, :string, 2
    end
    add_message "google.cloud.channel.v1.PurchasableOffer" do
      optional :offer, :message, 1, "google.cloud.channel.v1.Offer"
    end
    add_message "google.cloud.channel.v1.RegisterSubscriberRequest" do
      optional :account, :string, 1
      optional :service_account, :string, 2
    end
    add_message "google.cloud.channel.v1.RegisterSubscriberResponse" do
      optional :topic, :string, 1
    end
    add_message "google.cloud.channel.v1.UnregisterSubscriberRequest" do
      optional :account, :string, 1
      optional :service_account, :string, 2
    end
    add_message "google.cloud.channel.v1.UnregisterSubscriberResponse" do
      optional :topic, :string, 1
    end
    add_message "google.cloud.channel.v1.ListSubscribersRequest" do
      optional :account, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
    end
    add_message "google.cloud.channel.v1.ListSubscribersResponse" do
      optional :topic, :string, 1
      repeated :service_accounts, :string, 2
      optional :next_page_token, :string, 3
    end
  end
end

module Google
  module Cloud
    module Channel
      module V1
        CheckCloudIdentityAccountsExistRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.CheckCloudIdentityAccountsExistRequest").msgclass
        CloudIdentityCustomerAccount = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.CloudIdentityCustomerAccount").msgclass
        CheckCloudIdentityAccountsExistResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.CheckCloudIdentityAccountsExistResponse").msgclass
        ListCustomersRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListCustomersRequest").msgclass
        ListCustomersResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListCustomersResponse").msgclass
        GetCustomerRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.GetCustomerRequest").msgclass
        CreateCustomerRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.CreateCustomerRequest").msgclass
        UpdateCustomerRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.UpdateCustomerRequest").msgclass
        DeleteCustomerRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.DeleteCustomerRequest").msgclass
        ProvisionCloudIdentityRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ProvisionCloudIdentityRequest").msgclass
        ListEntitlementsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListEntitlementsRequest").msgclass
        ListEntitlementsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListEntitlementsResponse").msgclass
        ListTransferableSkusRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListTransferableSkusRequest").msgclass
        ListTransferableSkusResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListTransferableSkusResponse").msgclass
        ListTransferableOffersRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListTransferableOffersRequest").msgclass
        ListTransferableOffersResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListTransferableOffersResponse").msgclass
        TransferableOffer = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.TransferableOffer").msgclass
        GetEntitlementRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.GetEntitlementRequest").msgclass
        ListChannelPartnerLinksRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListChannelPartnerLinksRequest").msgclass
        ListChannelPartnerLinksResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListChannelPartnerLinksResponse").msgclass
        GetChannelPartnerLinkRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.GetChannelPartnerLinkRequest").msgclass
        CreateChannelPartnerLinkRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.CreateChannelPartnerLinkRequest").msgclass
        UpdateChannelPartnerLinkRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.UpdateChannelPartnerLinkRequest").msgclass
        CreateEntitlementRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.CreateEntitlementRequest").msgclass
        TransferEntitlementsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.TransferEntitlementsRequest").msgclass
        TransferEntitlementsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.TransferEntitlementsResponse").msgclass
        TransferEntitlementsToGoogleRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.TransferEntitlementsToGoogleRequest").msgclass
        ChangeParametersRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ChangeParametersRequest").msgclass
        ChangeRenewalSettingsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ChangeRenewalSettingsRequest").msgclass
        ChangeOfferRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ChangeOfferRequest").msgclass
        StartPaidServiceRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.StartPaidServiceRequest").msgclass
        CancelEntitlementRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.CancelEntitlementRequest").msgclass
        SuspendEntitlementRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.SuspendEntitlementRequest").msgclass
        ActivateEntitlementRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ActivateEntitlementRequest").msgclass
        LookupOfferRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.LookupOfferRequest").msgclass
        ListProductsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListProductsRequest").msgclass
        ListProductsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListProductsResponse").msgclass
        ListSkusRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListSkusRequest").msgclass
        ListSkusResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListSkusResponse").msgclass
        ListOffersRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListOffersRequest").msgclass
        ListOffersResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListOffersResponse").msgclass
        ListPurchasableSkusRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListPurchasableSkusRequest").msgclass
        ListPurchasableSkusRequest::CreateEntitlementPurchase = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListPurchasableSkusRequest.CreateEntitlementPurchase").msgclass
        ListPurchasableSkusRequest::ChangeOfferPurchase = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListPurchasableSkusRequest.ChangeOfferPurchase").msgclass
        ListPurchasableSkusRequest::ChangeOfferPurchase::ChangeType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListPurchasableSkusRequest.ChangeOfferPurchase.ChangeType").enummodule
        ListPurchasableSkusResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListPurchasableSkusResponse").msgclass
        PurchasableSku = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.PurchasableSku").msgclass
        ListPurchasableOffersRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListPurchasableOffersRequest").msgclass
        ListPurchasableOffersRequest::CreateEntitlementPurchase = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListPurchasableOffersRequest.CreateEntitlementPurchase").msgclass
        ListPurchasableOffersRequest::ChangeOfferPurchase = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListPurchasableOffersRequest.ChangeOfferPurchase").msgclass
        ListPurchasableOffersResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListPurchasableOffersResponse").msgclass
        PurchasableOffer = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.PurchasableOffer").msgclass
        RegisterSubscriberRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.RegisterSubscriberRequest").msgclass
        RegisterSubscriberResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.RegisterSubscriberResponse").msgclass
        UnregisterSubscriberRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.UnregisterSubscriberRequest").msgclass
        UnregisterSubscriberResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.UnregisterSubscriberResponse").msgclass
        ListSubscribersRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListSubscribersRequest").msgclass
        ListSubscribersResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.channel.v1.ListSubscribersResponse").msgclass
      end
    end
  end
end
