# frozen_string_literal: true

# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

require "gapic/common"
require "gapic/config"
require "gapic/config/method"

require "google/cloud/managed_identities/v1/version"

require "google/cloud/managed_identities/v1/managed_identities_service/credentials"
require "google/cloud/managed_identities/v1/managed_identities_service/paths"
require "google/cloud/managed_identities/v1/managed_identities_service/operations"
require "google/cloud/managed_identities/v1/managed_identities_service/client"

module Google
  module Cloud
    module ManagedIdentities
      module V1
        ##
        # ## API Overview
        #
        # The `managedidentites.googleapis.com` service implements the Google Cloud
        # Managed Identites API for identity services
        # (e.g. Microsoft Active Directory).
        #
        # The Managed Identities service provides methods to manage
        # (create/read/update/delete) domains, reset managed identities admin password,
        # add/remove domain controllers in GCP regions and add/remove VPC peering.
        #
        # ## Data Model
        #
        # The Managed Identities service exposes the following resources:
        #
        # * Locations as global, named as follows:
        #   `projects/{project_id}/locations/global`.
        #
        # * Domains, named as follows:
        #   `/projects/{project_id}/locations/global/domain/{domain_name}`.
        #
        # The `{domain_name}` refers to fully qualified domain name in the customer
        # project e.g. mydomain.myorganization.com, with the following restrictions:
        #
        #  * Must contain only lowercase letters, numbers, periods and hyphens.
        #  * Must start with a letter.
        #  * Must contain between 2-64 characters.
        #  * Must end with a number or a letter.
        #  * Must not start with period.
        #  * First segement length (mydomain form example above) shouldn't exceed
        #    15 chars.
        #  * The last segment cannot be fully numeric.
        #  * Must be unique within the customer project.
        #
        # To load this service and instantiate a client:
        #
        #     require "google/cloud/managed_identities/v1/managed_identities_service"
        #     client = ::Google::Cloud::ManagedIdentities::V1::ManagedIdentitiesService::Client.new
        #
        module ManagedIdentitiesService
        end
      end
    end
  end
end

helper_path = ::File.join __dir__, "managed_identities_service", "helpers.rb"
require "google/cloud/managed_identities/v1/managed_identities_service/helpers" if ::File.file? helper_path
