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

require "minitest/autorun"

require "gapic/grpc/service_stub"

require "google/cloud/recommender/v1/recommender_service_pb"
require "google/cloud/recommender/v1/recommender_service_services_pb"
require "google/cloud/recommender/v1/recommender"

class Google::Cloud::Recommender::V1::Recommender::ClientTest < Minitest::Test
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

  def test_list_recommendations
    # Create GRPC objects.
    grpc_response = Google::Cloud::Recommender::V1::ListRecommendationsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_size = 42
    page_token = "hello world"
    filter = "hello world"

    list_recommendations_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_recommendations, name
      assert_kind_of Google::Cloud::Recommender::V1::ListRecommendationsRequest, request
      assert_equal "hello world", request.parent
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      assert_equal "hello world", request.filter
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_recommendations_client_stub do
      # Create client
      client = Google::Cloud::Recommender::V1::Recommender::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_recommendations({ parent: parent, page_size: page_size, page_token: page_token, filter: filter }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_recommendations parent: parent, page_size: page_size, page_token: page_token, filter: filter do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_recommendations Google::Cloud::Recommender::V1::ListRecommendationsRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_recommendations({ parent: parent, page_size: page_size, page_token: page_token, filter: filter }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_recommendations Google::Cloud::Recommender::V1::ListRecommendationsRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_recommendations_client_stub.call_rpc_count
    end
  end

  def test_get_recommendation
    # Create GRPC objects.
    grpc_response = Google::Cloud::Recommender::V1::Recommendation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_recommendation_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_recommendation, name
      assert_kind_of Google::Cloud::Recommender::V1::GetRecommendationRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_recommendation_client_stub do
      # Create client
      client = Google::Cloud::Recommender::V1::Recommender::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_recommendation({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_recommendation name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_recommendation Google::Cloud::Recommender::V1::GetRecommendationRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_recommendation({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_recommendation Google::Cloud::Recommender::V1::GetRecommendationRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_recommendation_client_stub.call_rpc_count
    end
  end

  def test_mark_recommendation_claimed
    # Create GRPC objects.
    grpc_response = Google::Cloud::Recommender::V1::Recommendation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    state_metadata = [{}]
    etag = "hello world"

    mark_recommendation_claimed_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :mark_recommendation_claimed, name
      assert_kind_of Google::Cloud::Recommender::V1::MarkRecommendationClaimedRequest, request
      assert_equal "hello world", request.name
      assert_kind_of Google::Cloud::Recommender::V1::MarkRecommendationClaimedRequest::StateMetadataEntry, request.state_metadata.first
      assert_equal "hello world", request.etag
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, mark_recommendation_claimed_client_stub do
      # Create client
      client = Google::Cloud::Recommender::V1::Recommender::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.mark_recommendation_claimed({ name: name, state_metadata: state_metadata, etag: etag }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.mark_recommendation_claimed name: name, state_metadata: state_metadata, etag: etag do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.mark_recommendation_claimed Google::Cloud::Recommender::V1::MarkRecommendationClaimedRequest.new(name: name, state_metadata: state_metadata, etag: etag) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.mark_recommendation_claimed({ name: name, state_metadata: state_metadata, etag: etag }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.mark_recommendation_claimed Google::Cloud::Recommender::V1::MarkRecommendationClaimedRequest.new(name: name, state_metadata: state_metadata, etag: etag), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, mark_recommendation_claimed_client_stub.call_rpc_count
    end
  end

  def test_mark_recommendation_succeeded
    # Create GRPC objects.
    grpc_response = Google::Cloud::Recommender::V1::Recommendation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    state_metadata = [{}]
    etag = "hello world"

    mark_recommendation_succeeded_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :mark_recommendation_succeeded, name
      assert_kind_of Google::Cloud::Recommender::V1::MarkRecommendationSucceededRequest, request
      assert_equal "hello world", request.name
      assert_kind_of Google::Cloud::Recommender::V1::MarkRecommendationSucceededRequest::StateMetadataEntry, request.state_metadata.first
      assert_equal "hello world", request.etag
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, mark_recommendation_succeeded_client_stub do
      # Create client
      client = Google::Cloud::Recommender::V1::Recommender::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.mark_recommendation_succeeded({ name: name, state_metadata: state_metadata, etag: etag }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.mark_recommendation_succeeded name: name, state_metadata: state_metadata, etag: etag do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.mark_recommendation_succeeded Google::Cloud::Recommender::V1::MarkRecommendationSucceededRequest.new(name: name, state_metadata: state_metadata, etag: etag) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.mark_recommendation_succeeded({ name: name, state_metadata: state_metadata, etag: etag }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.mark_recommendation_succeeded Google::Cloud::Recommender::V1::MarkRecommendationSucceededRequest.new(name: name, state_metadata: state_metadata, etag: etag), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, mark_recommendation_succeeded_client_stub.call_rpc_count
    end
  end

  def test_mark_recommendation_failed
    # Create GRPC objects.
    grpc_response = Google::Cloud::Recommender::V1::Recommendation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    state_metadata = [{}]
    etag = "hello world"

    mark_recommendation_failed_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :mark_recommendation_failed, name
      assert_kind_of Google::Cloud::Recommender::V1::MarkRecommendationFailedRequest, request
      assert_equal "hello world", request.name
      assert_kind_of Google::Cloud::Recommender::V1::MarkRecommendationFailedRequest::StateMetadataEntry, request.state_metadata.first
      assert_equal "hello world", request.etag
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, mark_recommendation_failed_client_stub do
      # Create client
      client = Google::Cloud::Recommender::V1::Recommender::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.mark_recommendation_failed({ name: name, state_metadata: state_metadata, etag: etag }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.mark_recommendation_failed name: name, state_metadata: state_metadata, etag: etag do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.mark_recommendation_failed Google::Cloud::Recommender::V1::MarkRecommendationFailedRequest.new(name: name, state_metadata: state_metadata, etag: etag) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.mark_recommendation_failed({ name: name, state_metadata: state_metadata, etag: etag }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.mark_recommendation_failed Google::Cloud::Recommender::V1::MarkRecommendationFailedRequest.new(name: name, state_metadata: state_metadata, etag: etag), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, mark_recommendation_failed_client_stub.call_rpc_count
    end
  end
end
