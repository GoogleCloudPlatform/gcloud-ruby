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

require "helper"

require "gapic/grpc/service_stub"

require "google/cloud/webrisk/v1beta1/webrisk_pb"
require "google/cloud/webrisk/v1beta1/webrisk_services_pb"
require "google/cloud/web_risk/v1beta1/web_risk_service"

class ::Google::Cloud::WebRisk::V1beta1::WebRiskService::ClientTest < Minitest::Test
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

  def test_compute_threat_list_diff
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::WebRisk::V1beta1::ComputeThreatListDiffResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    threat_type = :THREAT_TYPE_UNSPECIFIED
    version_token = "hello world"
    constraints = {}

    compute_threat_list_diff_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :compute_threat_list_diff, name
      assert_kind_of ::Google::Cloud::WebRisk::V1beta1::ComputeThreatListDiffRequest, request
      assert_equal :THREAT_TYPE_UNSPECIFIED, request.threat_type
      assert_equal "hello world", request.version_token
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::WebRisk::V1beta1::ComputeThreatListDiffRequest::Constraints), request.constraints
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, compute_threat_list_diff_client_stub do
      # Create client
      client = ::Google::Cloud::WebRisk::V1beta1::WebRiskService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.compute_threat_list_diff({ threat_type: threat_type, version_token: version_token, constraints: constraints }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.compute_threat_list_diff threat_type: threat_type, version_token: version_token, constraints: constraints do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.compute_threat_list_diff ::Google::Cloud::WebRisk::V1beta1::ComputeThreatListDiffRequest.new(threat_type: threat_type, version_token: version_token, constraints: constraints) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.compute_threat_list_diff({ threat_type: threat_type, version_token: version_token, constraints: constraints }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.compute_threat_list_diff ::Google::Cloud::WebRisk::V1beta1::ComputeThreatListDiffRequest.new(threat_type: threat_type, version_token: version_token, constraints: constraints), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, compute_threat_list_diff_client_stub.call_rpc_count
    end
  end

  def test_search_uris
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::WebRisk::V1beta1::SearchUrisResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    uri = "hello world"
    threat_types = [:THREAT_TYPE_UNSPECIFIED]

    search_uris_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :search_uris, name
      assert_kind_of ::Google::Cloud::WebRisk::V1beta1::SearchUrisRequest, request
      assert_equal "hello world", request.uri
      assert_equal [:THREAT_TYPE_UNSPECIFIED], request.threat_types
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, search_uris_client_stub do
      # Create client
      client = ::Google::Cloud::WebRisk::V1beta1::WebRiskService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.search_uris({ uri: uri, threat_types: threat_types }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.search_uris uri: uri, threat_types: threat_types do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.search_uris ::Google::Cloud::WebRisk::V1beta1::SearchUrisRequest.new(uri: uri, threat_types: threat_types) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.search_uris({ uri: uri, threat_types: threat_types }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.search_uris ::Google::Cloud::WebRisk::V1beta1::SearchUrisRequest.new(uri: uri, threat_types: threat_types), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, search_uris_client_stub.call_rpc_count
    end
  end

  def test_search_hashes
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::WebRisk::V1beta1::SearchHashesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    hash_prefix = "hello world"
    threat_types = [:THREAT_TYPE_UNSPECIFIED]

    search_hashes_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :search_hashes, name
      assert_kind_of ::Google::Cloud::WebRisk::V1beta1::SearchHashesRequest, request
      assert_equal "hello world", request.hash_prefix
      assert_equal [:THREAT_TYPE_UNSPECIFIED], request.threat_types
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, search_hashes_client_stub do
      # Create client
      client = ::Google::Cloud::WebRisk::V1beta1::WebRiskService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.search_hashes({ hash_prefix: hash_prefix, threat_types: threat_types }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.search_hashes hash_prefix: hash_prefix, threat_types: threat_types do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.search_hashes ::Google::Cloud::WebRisk::V1beta1::SearchHashesRequest.new(hash_prefix: hash_prefix, threat_types: threat_types) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.search_hashes({ hash_prefix: hash_prefix, threat_types: threat_types }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.search_hashes ::Google::Cloud::WebRisk::V1beta1::SearchHashesRequest.new(hash_prefix: hash_prefix, threat_types: threat_types), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, search_hashes_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::WebRisk::V1beta1::WebRiskService::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Cloud::WebRisk::V1beta1::WebRiskService::Client::Configuration, config
  end
end
