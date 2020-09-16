# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/talent/v4/tenant_service.proto for package 'google.cloud.talent.v4'
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
require 'google/cloud/talent/v4/tenant_service_pb'

module Google
  module Cloud
    module Talent
      module V4
        module TenantService
          # A service that handles tenant management, including CRUD and enumeration.
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.cloud.talent.v4.TenantService'

            # Creates a new tenant entity.
            rpc :CreateTenant, Google::Cloud::Talent::V4::CreateTenantRequest, Google::Cloud::Talent::V4::Tenant
            # Retrieves specified tenant.
            rpc :GetTenant, Google::Cloud::Talent::V4::GetTenantRequest, Google::Cloud::Talent::V4::Tenant
            # Updates specified tenant.
            rpc :UpdateTenant, Google::Cloud::Talent::V4::UpdateTenantRequest, Google::Cloud::Talent::V4::Tenant
            # Deletes specified tenant.
            rpc :DeleteTenant, Google::Cloud::Talent::V4::DeleteTenantRequest, Google::Protobuf::Empty
            # Lists all tenants associated with the project.
            rpc :ListTenants, Google::Cloud::Talent::V4::ListTenantsRequest, Google::Cloud::Talent::V4::ListTenantsResponse
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
