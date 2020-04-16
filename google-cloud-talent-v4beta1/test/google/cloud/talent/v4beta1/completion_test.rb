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

require "google/cloud/talent/v4beta1/completion_service_pb"
require "google/cloud/talent/v4beta1/completion_service_services_pb"
require "google/cloud/talent/v4beta1/completion"

class Google::Cloud::Talent::V4beta1::Completion::ClientTest < Minitest::Test
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

  def test_complete_query
    # Create GRPC objects.
    grpc_response = Google::Cloud::Talent::V4beta1::CompleteQueryResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    query = "hello world"
    language_codes = ["hello world"]
    page_size = 42
    company = "hello world"
    scope = :COMPLETION_SCOPE_UNSPECIFIED
    type = :COMPLETION_TYPE_UNSPECIFIED

    complete_query_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :complete_query, name
      assert_kind_of Google::Cloud::Talent::V4beta1::CompleteQueryRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.query
      assert_equal ["hello world"], request.language_codes
      assert_equal 42, request.page_size
      assert_equal "hello world", request.company
      assert_equal :COMPLETION_SCOPE_UNSPECIFIED, request.scope
      assert_equal :COMPLETION_TYPE_UNSPECIFIED, request.type
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, complete_query_client_stub do
      # Create client
      client = Google::Cloud::Talent::V4beta1::Completion::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.complete_query({ parent: parent, query: query, language_codes: language_codes, page_size: page_size, company: company, scope: scope, type: type }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.complete_query parent: parent, query: query, language_codes: language_codes, page_size: page_size, company: company, scope: scope, type: type do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.complete_query Google::Cloud::Talent::V4beta1::CompleteQueryRequest.new(parent: parent, query: query, language_codes: language_codes, page_size: page_size, company: company, scope: scope, type: type) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.complete_query({ parent: parent, query: query, language_codes: language_codes, page_size: page_size, company: company, scope: scope, type: type }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.complete_query Google::Cloud::Talent::V4beta1::CompleteQueryRequest.new(parent: parent, query: query, language_codes: language_codes, page_size: page_size, company: company, scope: scope, type: type), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, complete_query_client_stub.call_rpc_count
    end
  end
end
