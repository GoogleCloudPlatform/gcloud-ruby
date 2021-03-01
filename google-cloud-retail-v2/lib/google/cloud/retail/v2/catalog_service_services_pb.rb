# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/retail/v2/catalog_service.proto for package 'Google.Cloud.Retail.V2'
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
require 'google/cloud/retail/v2/catalog_service_pb'

module Google
  module Cloud
    module Retail
      module V2
        module CatalogService
          # Service for managing catalog configuration.
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.cloud.retail.v2.CatalogService'

            # Lists all the [Catalog][google.cloud.retail.v2.Catalog]s associated with
            # the project.
            rpc :ListCatalogs, ::Google::Cloud::Retail::V2::ListCatalogsRequest, ::Google::Cloud::Retail::V2::ListCatalogsResponse
            # Updates the [Catalog][google.cloud.retail.v2.Catalog]s.
            rpc :UpdateCatalog, ::Google::Cloud::Retail::V2::UpdateCatalogRequest, ::Google::Cloud::Retail::V2::Catalog
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
