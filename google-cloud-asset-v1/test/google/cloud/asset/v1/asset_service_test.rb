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

require "google/cloud/asset/v1/asset_service_pb"
require "google/cloud/asset/v1/asset_service_services_pb"
require "google/cloud/asset/v1/asset_service"

class ::Google::Cloud::Asset::V1::AssetService::ClientTest < Minitest::Test
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

  def test_export_assets
    # Create GRPC objects.
    grpc_response = ::Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    read_time = {}
    asset_types = ["hello world"]
    content_type = :CONTENT_TYPE_UNSPECIFIED
    output_config = {}

    export_assets_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :export_assets, name
      assert_kind_of ::Google::Cloud::Asset::V1::ExportAssetsRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::Timestamp), request.read_time
      assert_equal ["hello world"], request.asset_types
      assert_equal :CONTENT_TYPE_UNSPECIFIED, request.content_type
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Asset::V1::OutputConfig), request.output_config
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, export_assets_client_stub do
      # Create client
      client = ::Google::Cloud::Asset::V1::AssetService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.export_assets({ parent: parent, read_time: read_time, asset_types: asset_types, content_type: content_type, output_config: output_config }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.export_assets parent: parent, read_time: read_time, asset_types: asset_types, content_type: content_type, output_config: output_config do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.export_assets ::Google::Cloud::Asset::V1::ExportAssetsRequest.new(parent: parent, read_time: read_time, asset_types: asset_types, content_type: content_type, output_config: output_config) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.export_assets({ parent: parent, read_time: read_time, asset_types: asset_types, content_type: content_type, output_config: output_config }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.export_assets ::Google::Cloud::Asset::V1::ExportAssetsRequest.new(parent: parent, read_time: read_time, asset_types: asset_types, content_type: content_type, output_config: output_config), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, export_assets_client_stub.call_rpc_count
    end
  end

  def test_batch_get_assets_history
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Asset::V1::BatchGetAssetsHistoryResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    asset_names = ["hello world"]
    content_type = :CONTENT_TYPE_UNSPECIFIED
    read_time_window = {}

    batch_get_assets_history_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :batch_get_assets_history, name
      assert_kind_of ::Google::Cloud::Asset::V1::BatchGetAssetsHistoryRequest, request
      assert_equal "hello world", request.parent
      assert_equal ["hello world"], request.asset_names
      assert_equal :CONTENT_TYPE_UNSPECIFIED, request.content_type
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Asset::V1::TimeWindow), request.read_time_window
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, batch_get_assets_history_client_stub do
      # Create client
      client = ::Google::Cloud::Asset::V1::AssetService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.batch_get_assets_history({ parent: parent, asset_names: asset_names, content_type: content_type, read_time_window: read_time_window }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.batch_get_assets_history parent: parent, asset_names: asset_names, content_type: content_type, read_time_window: read_time_window do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.batch_get_assets_history ::Google::Cloud::Asset::V1::BatchGetAssetsHistoryRequest.new(parent: parent, asset_names: asset_names, content_type: content_type, read_time_window: read_time_window) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.batch_get_assets_history({ parent: parent, asset_names: asset_names, content_type: content_type, read_time_window: read_time_window }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.batch_get_assets_history ::Google::Cloud::Asset::V1::BatchGetAssetsHistoryRequest.new(parent: parent, asset_names: asset_names, content_type: content_type, read_time_window: read_time_window), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, batch_get_assets_history_client_stub.call_rpc_count
    end
  end

  def test_create_feed
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Asset::V1::Feed.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    feed_id = "hello world"
    feed = {}

    create_feed_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_feed, name
      assert_kind_of ::Google::Cloud::Asset::V1::CreateFeedRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.feed_id
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Asset::V1::Feed), request.feed
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_feed_client_stub do
      # Create client
      client = ::Google::Cloud::Asset::V1::AssetService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_feed({ parent: parent, feed_id: feed_id, feed: feed }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_feed parent: parent, feed_id: feed_id, feed: feed do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_feed ::Google::Cloud::Asset::V1::CreateFeedRequest.new(parent: parent, feed_id: feed_id, feed: feed) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_feed({ parent: parent, feed_id: feed_id, feed: feed }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_feed ::Google::Cloud::Asset::V1::CreateFeedRequest.new(parent: parent, feed_id: feed_id, feed: feed), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_feed_client_stub.call_rpc_count
    end
  end

  def test_get_feed
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Asset::V1::Feed.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_feed_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_feed, name
      assert_kind_of ::Google::Cloud::Asset::V1::GetFeedRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_feed_client_stub do
      # Create client
      client = ::Google::Cloud::Asset::V1::AssetService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_feed({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_feed name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_feed ::Google::Cloud::Asset::V1::GetFeedRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_feed({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_feed ::Google::Cloud::Asset::V1::GetFeedRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_feed_client_stub.call_rpc_count
    end
  end

  def test_list_feeds
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Asset::V1::ListFeedsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"

    list_feeds_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_feeds, name
      assert_kind_of ::Google::Cloud::Asset::V1::ListFeedsRequest, request
      assert_equal "hello world", request.parent
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_feeds_client_stub do
      # Create client
      client = ::Google::Cloud::Asset::V1::AssetService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_feeds({ parent: parent }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_feeds parent: parent do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_feeds ::Google::Cloud::Asset::V1::ListFeedsRequest.new(parent: parent) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_feeds({ parent: parent }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_feeds ::Google::Cloud::Asset::V1::ListFeedsRequest.new(parent: parent), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_feeds_client_stub.call_rpc_count
    end
  end

  def test_update_feed
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Asset::V1::Feed.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    feed = {}
    update_mask = {}

    update_feed_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_feed, name
      assert_kind_of ::Google::Cloud::Asset::V1::UpdateFeedRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Asset::V1::Feed), request.feed
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_feed_client_stub do
      # Create client
      client = ::Google::Cloud::Asset::V1::AssetService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_feed({ feed: feed, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_feed feed: feed, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_feed ::Google::Cloud::Asset::V1::UpdateFeedRequest.new(feed: feed, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_feed({ feed: feed, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_feed ::Google::Cloud::Asset::V1::UpdateFeedRequest.new(feed: feed, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_feed_client_stub.call_rpc_count
    end
  end

  def test_delete_feed
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_feed_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_feed, name
      assert_kind_of ::Google::Cloud::Asset::V1::DeleteFeedRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_feed_client_stub do
      # Create client
      client = ::Google::Cloud::Asset::V1::AssetService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_feed({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_feed name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_feed ::Google::Cloud::Asset::V1::DeleteFeedRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_feed({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_feed ::Google::Cloud::Asset::V1::DeleteFeedRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_feed_client_stub.call_rpc_count
    end
  end

  def test_search_all_resources
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Asset::V1::SearchAllResourcesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    scope = "hello world"
    query = "hello world"
    asset_types = ["hello world"]
    page_size = 42
    page_token = "hello world"
    order_by = "hello world"

    search_all_resources_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :search_all_resources, name
      assert_kind_of ::Google::Cloud::Asset::V1::SearchAllResourcesRequest, request
      assert_equal "hello world", request.scope
      assert_equal "hello world", request.query
      assert_equal ["hello world"], request.asset_types
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      assert_equal "hello world", request.order_by
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, search_all_resources_client_stub do
      # Create client
      client = ::Google::Cloud::Asset::V1::AssetService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.search_all_resources({ scope: scope, query: query, asset_types: asset_types, page_size: page_size, page_token: page_token, order_by: order_by }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.search_all_resources scope: scope, query: query, asset_types: asset_types, page_size: page_size, page_token: page_token, order_by: order_by do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.search_all_resources ::Google::Cloud::Asset::V1::SearchAllResourcesRequest.new(scope: scope, query: query, asset_types: asset_types, page_size: page_size, page_token: page_token, order_by: order_by) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.search_all_resources({ scope: scope, query: query, asset_types: asset_types, page_size: page_size, page_token: page_token, order_by: order_by }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.search_all_resources ::Google::Cloud::Asset::V1::SearchAllResourcesRequest.new(scope: scope, query: query, asset_types: asset_types, page_size: page_size, page_token: page_token, order_by: order_by), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, search_all_resources_client_stub.call_rpc_count
    end
  end

  def test_search_all_iam_policies
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Asset::V1::SearchAllIamPoliciesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    scope = "hello world"
    query = "hello world"
    page_size = 42
    page_token = "hello world"

    search_all_iam_policies_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :search_all_iam_policies, name
      assert_kind_of ::Google::Cloud::Asset::V1::SearchAllIamPoliciesRequest, request
      assert_equal "hello world", request.scope
      assert_equal "hello world", request.query
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, search_all_iam_policies_client_stub do
      # Create client
      client = ::Google::Cloud::Asset::V1::AssetService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.search_all_iam_policies({ scope: scope, query: query, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.search_all_iam_policies scope: scope, query: query, page_size: page_size, page_token: page_token do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.search_all_iam_policies ::Google::Cloud::Asset::V1::SearchAllIamPoliciesRequest.new(scope: scope, query: query, page_size: page_size, page_token: page_token) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.search_all_iam_policies({ scope: scope, query: query, page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.search_all_iam_policies ::Google::Cloud::Asset::V1::SearchAllIamPoliciesRequest.new(scope: scope, query: query, page_size: page_size, page_token: page_token), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, search_all_iam_policies_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Asset::V1::AssetService::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Cloud::Asset::V1::AssetService::Client::Configuration, config
  end

  def test_operations_client
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Asset::V1::AssetService::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    assert_kind_of ::Google::Cloud::Asset::V1::AssetService::Operations, client.operations_client
  end
end
