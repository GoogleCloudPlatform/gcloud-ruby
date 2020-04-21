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

require "google/cloud/dataproc/v1/clusters_pb"
require "google/cloud/dataproc/v1/clusters_services_pb"
require "google/cloud/dataproc/v1/cluster_controller"

class Google::Cloud::Dataproc::V1::ClusterController::ClientTest < Minitest::Test
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

  def test_create_cluster
    # Create GRPC objects.
    grpc_response = Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    region = "hello world"
    cluster = {}
    request_id = "hello world"

    create_cluster_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_cluster, name
      assert_kind_of Google::Cloud::Dataproc::V1::CreateClusterRequest, request
      assert_equal "hello world", request.project_id
      assert_equal "hello world", request.region
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Dataproc::V1::Cluster), request.cluster
      assert_equal "hello world", request.request_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_cluster_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1::ClusterController::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_cluster({ project_id: project_id, region: region, cluster: cluster, request_id: request_id }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_cluster project_id: project_id, region: region, cluster: cluster, request_id: request_id do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_cluster Google::Cloud::Dataproc::V1::CreateClusterRequest.new(project_id: project_id, region: region, cluster: cluster, request_id: request_id) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_cluster({ project_id: project_id, region: region, cluster: cluster, request_id: request_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_cluster Google::Cloud::Dataproc::V1::CreateClusterRequest.new(project_id: project_id, region: region, cluster: cluster, request_id: request_id), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_cluster_client_stub.call_rpc_count
    end
  end

  def test_update_cluster
    # Create GRPC objects.
    grpc_response = Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    region = "hello world"
    cluster_name = "hello world"
    cluster = {}
    graceful_decommission_timeout = {}
    update_mask = {}
    request_id = "hello world"

    update_cluster_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_cluster, name
      assert_kind_of Google::Cloud::Dataproc::V1::UpdateClusterRequest, request
      assert_equal "hello world", request.project_id
      assert_equal "hello world", request.region
      assert_equal "hello world", request.cluster_name
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Dataproc::V1::Cluster), request.cluster
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Duration), request.graceful_decommission_timeout
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      assert_equal "hello world", request.request_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_cluster_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1::ClusterController::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_cluster({ project_id: project_id, region: region, cluster_name: cluster_name, cluster: cluster, graceful_decommission_timeout: graceful_decommission_timeout, update_mask: update_mask, request_id: request_id }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_cluster project_id: project_id, region: region, cluster_name: cluster_name, cluster: cluster, graceful_decommission_timeout: graceful_decommission_timeout, update_mask: update_mask, request_id: request_id do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_cluster Google::Cloud::Dataproc::V1::UpdateClusterRequest.new(project_id: project_id, region: region, cluster_name: cluster_name, cluster: cluster, graceful_decommission_timeout: graceful_decommission_timeout, update_mask: update_mask, request_id: request_id) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_cluster({ project_id: project_id, region: region, cluster_name: cluster_name, cluster: cluster, graceful_decommission_timeout: graceful_decommission_timeout, update_mask: update_mask, request_id: request_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_cluster Google::Cloud::Dataproc::V1::UpdateClusterRequest.new(project_id: project_id, region: region, cluster_name: cluster_name, cluster: cluster, graceful_decommission_timeout: graceful_decommission_timeout, update_mask: update_mask, request_id: request_id), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_cluster_client_stub.call_rpc_count
    end
  end

  def test_delete_cluster
    # Create GRPC objects.
    grpc_response = Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    region = "hello world"
    cluster_name = "hello world"
    cluster_uuid = "hello world"
    request_id = "hello world"

    delete_cluster_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_cluster, name
      assert_kind_of Google::Cloud::Dataproc::V1::DeleteClusterRequest, request
      assert_equal "hello world", request.project_id
      assert_equal "hello world", request.region
      assert_equal "hello world", request.cluster_name
      assert_equal "hello world", request.cluster_uuid
      assert_equal "hello world", request.request_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_cluster_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1::ClusterController::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_cluster({ project_id: project_id, region: region, cluster_name: cluster_name, cluster_uuid: cluster_uuid, request_id: request_id }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_cluster project_id: project_id, region: region, cluster_name: cluster_name, cluster_uuid: cluster_uuid, request_id: request_id do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_cluster Google::Cloud::Dataproc::V1::DeleteClusterRequest.new(project_id: project_id, region: region, cluster_name: cluster_name, cluster_uuid: cluster_uuid, request_id: request_id) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_cluster({ project_id: project_id, region: region, cluster_name: cluster_name, cluster_uuid: cluster_uuid, request_id: request_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_cluster Google::Cloud::Dataproc::V1::DeleteClusterRequest.new(project_id: project_id, region: region, cluster_name: cluster_name, cluster_uuid: cluster_uuid, request_id: request_id), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_cluster_client_stub.call_rpc_count
    end
  end

  def test_get_cluster
    # Create GRPC objects.
    grpc_response = Google::Cloud::Dataproc::V1::Cluster.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    region = "hello world"
    cluster_name = "hello world"

    get_cluster_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_cluster, name
      assert_kind_of Google::Cloud::Dataproc::V1::GetClusterRequest, request
      assert_equal "hello world", request.project_id
      assert_equal "hello world", request.region
      assert_equal "hello world", request.cluster_name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_cluster_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1::ClusterController::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_cluster({ project_id: project_id, region: region, cluster_name: cluster_name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_cluster project_id: project_id, region: region, cluster_name: cluster_name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_cluster Google::Cloud::Dataproc::V1::GetClusterRequest.new(project_id: project_id, region: region, cluster_name: cluster_name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_cluster({ project_id: project_id, region: region, cluster_name: cluster_name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_cluster Google::Cloud::Dataproc::V1::GetClusterRequest.new(project_id: project_id, region: region, cluster_name: cluster_name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_cluster_client_stub.call_rpc_count
    end
  end

  def test_list_clusters
    # Create GRPC objects.
    grpc_response = Google::Cloud::Dataproc::V1::ListClustersResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    region = "hello world"
    filter = "hello world"
    page_size = 42
    page_token = "hello world"

    list_clusters_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_clusters, name
      assert_kind_of Google::Cloud::Dataproc::V1::ListClustersRequest, request
      assert_equal "hello world", request.project_id
      assert_equal "hello world", request.region
      assert_equal "hello world", request.filter
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_clusters_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1::ClusterController::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_clusters({ project_id: project_id, region: region, filter: filter, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_clusters project_id: project_id, region: region, filter: filter, page_size: page_size, page_token: page_token do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_clusters Google::Cloud::Dataproc::V1::ListClustersRequest.new(project_id: project_id, region: region, filter: filter, page_size: page_size, page_token: page_token) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_clusters({ project_id: project_id, region: region, filter: filter, page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_clusters Google::Cloud::Dataproc::V1::ListClustersRequest.new(project_id: project_id, region: region, filter: filter, page_size: page_size, page_token: page_token), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_clusters_client_stub.call_rpc_count
    end
  end

  def test_diagnose_cluster
    # Create GRPC objects.
    grpc_response = Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    region = "hello world"
    cluster_name = "hello world"

    diagnose_cluster_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :diagnose_cluster, name
      assert_kind_of Google::Cloud::Dataproc::V1::DiagnoseClusterRequest, request
      assert_equal "hello world", request.project_id
      assert_equal "hello world", request.region
      assert_equal "hello world", request.cluster_name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, diagnose_cluster_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1::ClusterController::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.diagnose_cluster({ project_id: project_id, region: region, cluster_name: cluster_name }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.diagnose_cluster project_id: project_id, region: region, cluster_name: cluster_name do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.diagnose_cluster Google::Cloud::Dataproc::V1::DiagnoseClusterRequest.new(project_id: project_id, region: region, cluster_name: cluster_name) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.diagnose_cluster({ project_id: project_id, region: region, cluster_name: cluster_name }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.diagnose_cluster Google::Cloud::Dataproc::V1::DiagnoseClusterRequest.new(project_id: project_id, region: region, cluster_name: cluster_name), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, diagnose_cluster_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = Google::Cloud::Dataproc::V1::ClusterController::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of Google::Cloud::Dataproc::V1::ClusterController::Client::Configuration, config
  end

  def test_operations_client
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = nil
    Gapic::ServiceStub.stub :new, nil do
      client = Google::Cloud::Dataproc::V1::ClusterController::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    assert_kind_of Google::Cloud::Dataproc::V1::ClusterController::Operations, client.operations_client
  end
end
