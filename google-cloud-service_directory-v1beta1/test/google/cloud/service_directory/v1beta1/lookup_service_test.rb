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

require "simplecov"
require "minitest/autorun"

require "gapic/grpc/service_stub"

require "google/cloud/servicedirectory/v1beta1/lookup_service_pb"
require "google/cloud/servicedirectory/v1beta1/lookup_service_services_pb"
require "google/cloud/service_directory/v1beta1/lookup_service"

class Google::Cloud::ServiceDirectory::V1beta1::LookupService::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_rpc_count, :requests

    def initialize response, operation, &block
      @response = response
      @operation = operation
      @block = block
      @call_rpc_count = 0
      @requests = []
    end

    def call_rpc *args
      @call_rpc_count += 1

      @requests << @block&.call(*args)

      yield @response, @operation if block_given?

      @response
    end
  end

  def test_resolve_service
    # Create GRPC objects.
    grpc_response = Google::Cloud::ServiceDirectory::V1beta1::ResolveServiceResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    max_endpoints = 42
    endpoint_filter = "hello world"

    resolve_service_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :resolve_service, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::ResolveServiceRequest, request
      assert_equal "hello world", request.name
      assert_equal 42, request.max_endpoints
      assert_equal "hello world", request.endpoint_filter
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, resolve_service_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::LookupService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.resolve_service({ name: name, max_endpoints: max_endpoints, endpoint_filter: endpoint_filter }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.resolve_service name: name, max_endpoints: max_endpoints, endpoint_filter: endpoint_filter do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.resolve_service Google::Cloud::ServiceDirectory::V1beta1::ResolveServiceRequest.new(name: name, max_endpoints: max_endpoints, endpoint_filter: endpoint_filter) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.resolve_service({ name: name, max_endpoints: max_endpoints, endpoint_filter: endpoint_filter }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.resolve_service Google::Cloud::ServiceDirectory::V1beta1::ResolveServiceRequest.new(name: name, max_endpoints: max_endpoints, endpoint_filter: endpoint_filter), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, resolve_service_client_stub.call_rpc_count
    end
  end
end
