# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/memcache/v1/cloud_memcache.proto for package 'google.cloud.memcache.v1'
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
require 'google/cloud/memcache/v1/cloud_memcache_pb'

module Google
  module Cloud
    module Memcache
      module V1
        module CloudMemcache
          # Configures and manages Cloud Memorystore for Memcached instances.
          #
          #
          # The `memcache.googleapis.com` service implements the Google Cloud Memorystore
          # for Memcached API and defines the following resource model for managing
          # Memorystore Memcached (also called Memcached below) instances:
          # * The service works with a collection of cloud projects, named: `/projects/*`
          # * Each project has a collection of available locations, named: `/locations/*`
          # * Each location has a collection of Memcached instances, named:
          # `/instances/*`
          # * As such, Memcached instances are resources of the form:
          #   `/projects/{project_id}/locations/{location_id}/instances/{instance_id}`
          #
          # Note that location_id must be a GCP `region`; for example:
          # * `projects/my-memcached-project/locations/us-central1/instances/my-memcached`
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.cloud.memcache.v1.CloudMemcache'

            # Lists Instances in a given location.
            rpc :ListInstances, ::Google::Cloud::Memcache::V1::ListInstancesRequest, ::Google::Cloud::Memcache::V1::ListInstancesResponse
            # Gets details of a single Instance.
            rpc :GetInstance, ::Google::Cloud::Memcache::V1::GetInstanceRequest, ::Google::Cloud::Memcache::V1::Instance
            # Creates a new Instance in a given location.
            rpc :CreateInstance, ::Google::Cloud::Memcache::V1::CreateInstanceRequest, ::Google::Longrunning::Operation
            # Updates an existing Instance in a given project and location.
            rpc :UpdateInstance, ::Google::Cloud::Memcache::V1::UpdateInstanceRequest, ::Google::Longrunning::Operation
            # Updates the defined Memcached Parameters for an existing Instance.
            # This method only stages the parameters, it must be followed by
            # ApplyParameters to apply the parameters to nodes of the Memcached Instance.
            rpc :UpdateParameters, ::Google::Cloud::Memcache::V1::UpdateParametersRequest, ::Google::Longrunning::Operation
            # Deletes a single Instance.
            rpc :DeleteInstance, ::Google::Cloud::Memcache::V1::DeleteInstanceRequest, ::Google::Longrunning::Operation
            # ApplyParameters will restart the set of specified nodes in order to update
            # them to the current set of parameters for the Memcached Instance.
            rpc :ApplyParameters, ::Google::Cloud::Memcache::V1::ApplyParametersRequest, ::Google::Longrunning::Operation
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
