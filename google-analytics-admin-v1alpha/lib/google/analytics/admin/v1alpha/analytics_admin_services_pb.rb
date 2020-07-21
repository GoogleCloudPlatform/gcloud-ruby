# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/analytics/admin/v1alpha/analytics_admin.proto for package 'google.analytics.admin.v1alpha'
# Original file comments:
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'grpc'
require 'google/analytics/admin/v1alpha/analytics_admin_pb'

module Google
  module Analytics
    module Admin
      module V1alpha
        module AnalyticsAdminService
          # Service Interface for the Analytics Admin API (App+Web).
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.analytics.admin.v1alpha.AnalyticsAdminService'

            # Lookup for a single Account.
            # Throws "Target not found" if no such account found, or if caller does not
            # have permissions to access it.
            rpc :GetAccount, GetAccountRequest, Account
            # Returns all accounts accessible by the caller.
            #
            # Note that these accounts might not currently have App+Web properties.
            # Soft-deleted (ie: "trashed") accounts are excluded by default.
            # Returns an empty list if no relevant accounts are found.
            rpc :ListAccounts, ListAccountsRequest, ListAccountsResponse
            # Marks target Account as soft-deleted (ie: "trashed") and returns it.
            #
            # This API does not have a method to restore soft-deleted accounts.
            # However, they can be restored using the Trash Can UI.
            #
            # If the accounts are not restored before the expiration time, the account
            # and all child resources (eg: Properties, GoogleAdsLinks, Streams,
            # UserLinks) will be permanently purged.
            # https://support.google.com/analytics/answer/6154772
            #
            # Returns an error if the target is not found.
            rpc :DeleteAccount, DeleteAccountRequest, Google::Protobuf::Empty
            # Updates an account.
            rpc :UpdateAccount, UpdateAccountRequest, Account
            # Requests a ticket for creating an account.
            rpc :ProvisionAccountTicket, ProvisionAccountTicketRequest, ProvisionAccountTicketResponse
            # Lookup for a single "App+Web" Property.
            #
            # Throws "Target not found" if no such property found, if property is not
            # of the type "App+Web", or if caller does not have permissions to access it.
            rpc :GetProperty, GetPropertyRequest, Property
            # Returns child Properties under the specified parent Account.
            #
            # Only "App+Web" properties will be returned.
            # Properties will be excluded if the caller does not have access.
            # Soft-deleted (ie: "trashed") properties are excluded by default.
            # Returns an empty list if no relevant properties are found.
            rpc :ListProperties, ListPropertiesRequest, ListPropertiesResponse
            # Creates an "App+Web" property with the specified location and attributes.
            rpc :CreateProperty, CreatePropertyRequest, Property
            # Marks target Property as soft-deleted (ie: "trashed") and returns it.
            #
            # This API does not have a method to restore soft-deleted properties.
            # However, they can be restored using the Trash Can UI.
            #
            # If the properties are not restored before the expiration time, the Property
            # and all child resources (eg: GoogleAdsLinks, Streams, UserLinks)
            # will be permanently purged.
            # https://support.google.com/analytics/answer/6154772
            #
            # Returns an error if the target is not found, or is not an App+Web Property.
            rpc :DeleteProperty, DeletePropertyRequest, Google::Protobuf::Empty
            # Updates a property.
            rpc :UpdateProperty, UpdatePropertyRequest, Property
            # Gets information about a user's link to an account or property.
            rpc :GetUserLink, GetUserLinkRequest, UserLink
            # Gets information about multiple users' links to an account or property.
            rpc :BatchGetUserLinks, BatchGetUserLinksRequest, BatchGetUserLinksResponse
            # Lists all user links on an account or property.
            rpc :ListUserLinks, ListUserLinksRequest, ListUserLinksResponse
            # Lists all user links on an account or property, including implicit ones
            # that come from effective permissions granted by groups or organization
            # admin roles.
            #
            # If a returned user link does not have direct permissions, they cannot
            # be removed from the account or property directly with the DeleteUserLink
            # command. They have to be removed from the group/etc that gives them
            # permissions, which is currently only usable/discoverable in the GA or GMP
            # UIs.
            rpc :AuditUserLinks, AuditUserLinksRequest, AuditUserLinksResponse
            # Creates a user link on an account or property.
            #
            # If the user with the specified email already has permissions on the
            # account or property, then the user's existing permissions will be unioned
            # with the permissions specified in the new UserLink.
            rpc :CreateUserLink, CreateUserLinkRequest, UserLink
            # Creates information about multiple users' links to an account or property.
            #
            # This method is transactional. If any UserLink cannot be created, none of
            # the UserLinks will be created.
            rpc :BatchCreateUserLinks, BatchCreateUserLinksRequest, BatchCreateUserLinksResponse
            # Updates a user link on an account or property.
            rpc :UpdateUserLink, UpdateUserLinkRequest, UserLink
            # Updates information about multiple users' links to an account or property.
            rpc :BatchUpdateUserLinks, BatchUpdateUserLinksRequest, BatchUpdateUserLinksResponse
            # Deletes a user link on an account or property.
            rpc :DeleteUserLink, DeleteUserLinkRequest, Google::Protobuf::Empty
            # Deletes information about multiple users' links to an account or property.
            rpc :BatchDeleteUserLinks, BatchDeleteUserLinksRequest, Google::Protobuf::Empty
            # Lookup for a single WebDataStream
            #
            # Throws "Target not found" if no such web data stream found, or if the
            # caller does not have permissions to access it.
            rpc :GetWebDataStream, GetWebDataStreamRequest, WebDataStream
            # Deletes a web stream on a property.
            rpc :DeleteWebDataStream, DeleteWebDataStreamRequest, Google::Protobuf::Empty
            # Updates a web stream on a property.
            rpc :UpdateWebDataStream, UpdateWebDataStreamRequest, WebDataStream
            # Creates a web stream with the specified location and attributes.
            rpc :CreateWebDataStream, CreateWebDataStreamRequest, WebDataStream
            # Returns child web data streams under the specified parent property.
            #
            # Web data streams will be excluded if the caller does not have access.
            # Returns an empty list if no relevant web data streams are found.
            rpc :ListWebDataStreams, ListWebDataStreamsRequest, ListWebDataStreamsResponse
            # Lookup for a single IosAppDataStream
            #
            # Throws "Target not found" if no such iOS app data stream found, or if the
            # caller does not have permissions to access it.
            rpc :GetIosAppDataStream, GetIosAppDataStreamRequest, IosAppDataStream
            # Deletes an iOS app stream on a property.
            rpc :DeleteIosAppDataStream, DeleteIosAppDataStreamRequest, Google::Protobuf::Empty
            # Updates an iOS app stream on a property.
            rpc :UpdateIosAppDataStream, UpdateIosAppDataStreamRequest, IosAppDataStream
            # Creates an iOS app data stream with the specified location and attributes.
            rpc :CreateIosAppDataStream, CreateIosAppDataStreamRequest, IosAppDataStream
            # Returns child iOS app data streams under the specified parent property.
            #
            # iOS app data streams will be excluded if the caller does not have access.
            # Returns an empty list if no relevant iOS app data streams are found.
            rpc :ListIosAppDataStreams, ListIosAppDataStreamsRequest, ListIosAppDataStreamsResponse
            # Lookup for a single AndroidAppDataStream
            #
            # Throws "Target not found" if no such android app data stream found, or if
            # the caller does not have permissions to access it.
            rpc :GetAndroidAppDataStream, GetAndroidAppDataStreamRequest, AndroidAppDataStream
            # Deletes an android app stream on a property.
            rpc :DeleteAndroidAppDataStream, DeleteAndroidAppDataStreamRequest, Google::Protobuf::Empty
            # Updates an android app stream on a property.
            rpc :UpdateAndroidAppDataStream, UpdateAndroidAppDataStreamRequest, AndroidAppDataStream
            # Creates an android app stream with the specified location and attributes.
            rpc :CreateAndroidAppDataStream, CreateAndroidAppDataStreamRequest, AndroidAppDataStream
            # Returns child android app streams under the specified parent property.
            #
            # Android app streams will be excluded if the caller does not have access.
            # Returns an empty list if no relevant android app streams are found.
            rpc :ListAndroidAppDataStreams, ListAndroidAppDataStreamsRequest, ListAndroidAppDataStreamsResponse
            # Returns the singleton enhanced measurement settings for this web stream.
            # Note that the stream must enable enhanced measurement for these settings to
            # take effect.
            rpc :GetEnhancedMeasurementSettings, GetEnhancedMeasurementSettingsRequest, EnhancedMeasurementSettings
            # Updates the singleton enhanced measurement settings for this web stream.
            # Note that the stream must enable enhanced measurement for these settings to
            # take effect.
            rpc :UpdateEnhancedMeasurementSettings, UpdateEnhancedMeasurementSettingsRequest, EnhancedMeasurementSettings
            # Creates a FirebaseLink.
            #
            # Properties can have at most one FirebaseLink.
            rpc :CreateFirebaseLink, CreateFirebaseLinkRequest, FirebaseLink
            # Updates a FirebaseLink on a property
            rpc :UpdateFirebaseLink, UpdateFirebaseLinkRequest, FirebaseLink
            # Deletes a FirebaseLink on a property
            rpc :DeleteFirebaseLink, DeleteFirebaseLinkRequest, Google::Protobuf::Empty
            # Lists FirebaseLinks on a property.
            # Properties can have at most one FirebaseLink.
            rpc :ListFirebaseLinks, ListFirebaseLinksRequest, ListFirebaseLinksResponse
            # Returns the Site Tag for the specified web stream.
            # Site Tags are immutable singletons.
            rpc :GetGlobalSiteTag, GetGlobalSiteTagRequest, GlobalSiteTag
            # Creates a GoogleAdsLink.
            rpc :CreateGoogleAdsLink, CreateGoogleAdsLinkRequest, GoogleAdsLink
            # Updates a GoogleAdsLink on a property
            rpc :UpdateGoogleAdsLink, UpdateGoogleAdsLinkRequest, GoogleAdsLink
            # Deletes a GoogleAdsLink on a property
            rpc :DeleteGoogleAdsLink, DeleteGoogleAdsLinkRequest, Google::Protobuf::Empty
            # Lists GoogleAdsLinks on a property.
            rpc :ListGoogleAdsLinks, ListGoogleAdsLinksRequest, ListGoogleAdsLinksResponse
            # Get data sharing settings on an account.
            # Data sharing settings are singletons.
            rpc :GetDataSharingSettings, GetDataSharingSettingsRequest, DataSharingSettings
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
