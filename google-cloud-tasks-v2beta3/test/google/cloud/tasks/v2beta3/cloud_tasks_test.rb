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

require "helper"

require "gapic/grpc/service_stub"

require "google/cloud/tasks/v2beta3/cloudtasks_pb"
require "google/cloud/tasks/v2beta3/cloudtasks_services_pb"
require "google/cloud/tasks/v2beta3/cloud_tasks"

class ::Google::Cloud::Tasks::V2beta3::CloudTasks::ClientTest < Minitest::Test
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

  def test_list_queues
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Tasks::V2beta3::ListQueuesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    filter = "hello world"
    page_size = 42
    page_token = "hello world"

    list_queues_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_queues, name
      assert_kind_of ::Google::Cloud::Tasks::V2beta3::ListQueuesRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.filter
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_queues_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_queues({ parent: parent, filter: filter, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_queues parent: parent, filter: filter, page_size: page_size, page_token: page_token do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_queues ::Google::Cloud::Tasks::V2beta3::ListQueuesRequest.new(parent: parent, filter: filter, page_size: page_size, page_token: page_token) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_queues({ parent: parent, filter: filter, page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_queues ::Google::Cloud::Tasks::V2beta3::ListQueuesRequest.new(parent: parent, filter: filter, page_size: page_size, page_token: page_token), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_queues_client_stub.call_rpc_count
    end
  end

  def test_get_queue
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Tasks::V2beta3::Queue.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_queue_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_queue, name
      assert_kind_of ::Google::Cloud::Tasks::V2beta3::GetQueueRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_queue_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_queue({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_queue name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_queue ::Google::Cloud::Tasks::V2beta3::GetQueueRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_queue({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_queue ::Google::Cloud::Tasks::V2beta3::GetQueueRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_queue_client_stub.call_rpc_count
    end
  end

  def test_create_queue
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Tasks::V2beta3::Queue.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    queue = {}

    create_queue_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_queue, name
      assert_kind_of ::Google::Cloud::Tasks::V2beta3::CreateQueueRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Tasks::V2beta3::Queue), request.queue
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_queue_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_queue({ parent: parent, queue: queue }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_queue parent: parent, queue: queue do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_queue ::Google::Cloud::Tasks::V2beta3::CreateQueueRequest.new(parent: parent, queue: queue) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_queue({ parent: parent, queue: queue }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_queue ::Google::Cloud::Tasks::V2beta3::CreateQueueRequest.new(parent: parent, queue: queue), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_queue_client_stub.call_rpc_count
    end
  end

  def test_update_queue
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Tasks::V2beta3::Queue.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    queue = {}
    update_mask = {}

    update_queue_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_queue, name
      assert_kind_of ::Google::Cloud::Tasks::V2beta3::UpdateQueueRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Tasks::V2beta3::Queue), request.queue
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_queue_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_queue({ queue: queue, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_queue queue: queue, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_queue ::Google::Cloud::Tasks::V2beta3::UpdateQueueRequest.new(queue: queue, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_queue({ queue: queue, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_queue ::Google::Cloud::Tasks::V2beta3::UpdateQueueRequest.new(queue: queue, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_queue_client_stub.call_rpc_count
    end
  end

  def test_delete_queue
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_queue_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_queue, name
      assert_kind_of ::Google::Cloud::Tasks::V2beta3::DeleteQueueRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_queue_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_queue({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_queue name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_queue ::Google::Cloud::Tasks::V2beta3::DeleteQueueRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_queue({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_queue ::Google::Cloud::Tasks::V2beta3::DeleteQueueRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_queue_client_stub.call_rpc_count
    end
  end

  def test_purge_queue
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Tasks::V2beta3::Queue.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    purge_queue_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :purge_queue, name
      assert_kind_of ::Google::Cloud::Tasks::V2beta3::PurgeQueueRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, purge_queue_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.purge_queue({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.purge_queue name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.purge_queue ::Google::Cloud::Tasks::V2beta3::PurgeQueueRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.purge_queue({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.purge_queue ::Google::Cloud::Tasks::V2beta3::PurgeQueueRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, purge_queue_client_stub.call_rpc_count
    end
  end

  def test_pause_queue
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Tasks::V2beta3::Queue.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    pause_queue_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :pause_queue, name
      assert_kind_of ::Google::Cloud::Tasks::V2beta3::PauseQueueRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, pause_queue_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.pause_queue({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.pause_queue name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.pause_queue ::Google::Cloud::Tasks::V2beta3::PauseQueueRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.pause_queue({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.pause_queue ::Google::Cloud::Tasks::V2beta3::PauseQueueRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, pause_queue_client_stub.call_rpc_count
    end
  end

  def test_resume_queue
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Tasks::V2beta3::Queue.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    resume_queue_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :resume_queue, name
      assert_kind_of ::Google::Cloud::Tasks::V2beta3::ResumeQueueRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, resume_queue_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.resume_queue({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.resume_queue name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.resume_queue ::Google::Cloud::Tasks::V2beta3::ResumeQueueRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.resume_queue({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.resume_queue ::Google::Cloud::Tasks::V2beta3::ResumeQueueRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, resume_queue_client_stub.call_rpc_count
    end
  end

  def test_get_iam_policy
    # Create GRPC objects.
    grpc_response = ::Google::Iam::V1::Policy.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    resource = "hello world"
    options = {}

    get_iam_policy_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_iam_policy, name
      assert_kind_of ::Google::Iam::V1::GetIamPolicyRequest, request
      assert_equal "hello world", request.resource
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Iam::V1::GetPolicyOptions), request.options
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_iam_policy_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_iam_policy({ resource: resource, options: options }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_iam_policy resource: resource, options: options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_iam_policy ::Google::Iam::V1::GetIamPolicyRequest.new(resource: resource, options: options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_iam_policy({ resource: resource, options: options }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_iam_policy ::Google::Iam::V1::GetIamPolicyRequest.new(resource: resource, options: options), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_iam_policy_client_stub.call_rpc_count
    end
  end

  def test_set_iam_policy
    # Create GRPC objects.
    grpc_response = ::Google::Iam::V1::Policy.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    resource = "hello world"
    policy = {}

    set_iam_policy_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :set_iam_policy, name
      assert_kind_of ::Google::Iam::V1::SetIamPolicyRequest, request
      assert_equal "hello world", request.resource
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Iam::V1::Policy), request.policy
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, set_iam_policy_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.set_iam_policy({ resource: resource, policy: policy }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.set_iam_policy resource: resource, policy: policy do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.set_iam_policy ::Google::Iam::V1::SetIamPolicyRequest.new(resource: resource, policy: policy) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.set_iam_policy({ resource: resource, policy: policy }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.set_iam_policy ::Google::Iam::V1::SetIamPolicyRequest.new(resource: resource, policy: policy), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, set_iam_policy_client_stub.call_rpc_count
    end
  end

  def test_test_iam_permissions
    # Create GRPC objects.
    grpc_response = ::Google::Iam::V1::TestIamPermissionsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    resource = "hello world"
    permissions = ["hello world"]

    test_iam_permissions_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :test_iam_permissions, name
      assert_kind_of ::Google::Iam::V1::TestIamPermissionsRequest, request
      assert_equal "hello world", request.resource
      assert_equal ["hello world"], request.permissions
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, test_iam_permissions_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.test_iam_permissions({ resource: resource, permissions: permissions }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.test_iam_permissions resource: resource, permissions: permissions do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.test_iam_permissions ::Google::Iam::V1::TestIamPermissionsRequest.new(resource: resource, permissions: permissions) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.test_iam_permissions({ resource: resource, permissions: permissions }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.test_iam_permissions ::Google::Iam::V1::TestIamPermissionsRequest.new(resource: resource, permissions: permissions), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, test_iam_permissions_client_stub.call_rpc_count
    end
  end

  def test_list_tasks
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Tasks::V2beta3::ListTasksResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    response_view = :VIEW_UNSPECIFIED
    page_size = 42
    page_token = "hello world"

    list_tasks_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_tasks, name
      assert_kind_of ::Google::Cloud::Tasks::V2beta3::ListTasksRequest, request
      assert_equal "hello world", request.parent
      assert_equal :VIEW_UNSPECIFIED, request.response_view
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_tasks_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_tasks({ parent: parent, response_view: response_view, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_tasks parent: parent, response_view: response_view, page_size: page_size, page_token: page_token do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_tasks ::Google::Cloud::Tasks::V2beta3::ListTasksRequest.new(parent: parent, response_view: response_view, page_size: page_size, page_token: page_token) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_tasks({ parent: parent, response_view: response_view, page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_tasks ::Google::Cloud::Tasks::V2beta3::ListTasksRequest.new(parent: parent, response_view: response_view, page_size: page_size, page_token: page_token), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_tasks_client_stub.call_rpc_count
    end
  end

  def test_get_task
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Tasks::V2beta3::Task.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    response_view = :VIEW_UNSPECIFIED

    get_task_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_task, name
      assert_kind_of ::Google::Cloud::Tasks::V2beta3::GetTaskRequest, request
      assert_equal "hello world", request.name
      assert_equal :VIEW_UNSPECIFIED, request.response_view
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_task_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_task({ name: name, response_view: response_view }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_task name: name, response_view: response_view do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_task ::Google::Cloud::Tasks::V2beta3::GetTaskRequest.new(name: name, response_view: response_view) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_task({ name: name, response_view: response_view }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_task ::Google::Cloud::Tasks::V2beta3::GetTaskRequest.new(name: name, response_view: response_view), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_task_client_stub.call_rpc_count
    end
  end

  def test_create_task
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Tasks::V2beta3::Task.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    task = {}
    response_view = :VIEW_UNSPECIFIED

    create_task_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_task, name
      assert_kind_of ::Google::Cloud::Tasks::V2beta3::CreateTaskRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Tasks::V2beta3::Task), request.task
      assert_equal :VIEW_UNSPECIFIED, request.response_view
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_task_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_task({ parent: parent, task: task, response_view: response_view }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_task parent: parent, task: task, response_view: response_view do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_task ::Google::Cloud::Tasks::V2beta3::CreateTaskRequest.new(parent: parent, task: task, response_view: response_view) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_task({ parent: parent, task: task, response_view: response_view }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_task ::Google::Cloud::Tasks::V2beta3::CreateTaskRequest.new(parent: parent, task: task, response_view: response_view), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_task_client_stub.call_rpc_count
    end
  end

  def test_delete_task
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_task_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_task, name
      assert_kind_of ::Google::Cloud::Tasks::V2beta3::DeleteTaskRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_task_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_task({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_task name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_task ::Google::Cloud::Tasks::V2beta3::DeleteTaskRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_task({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_task ::Google::Cloud::Tasks::V2beta3::DeleteTaskRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_task_client_stub.call_rpc_count
    end
  end

  def test_run_task
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Tasks::V2beta3::Task.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    response_view = :VIEW_UNSPECIFIED

    run_task_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :run_task, name
      assert_kind_of ::Google::Cloud::Tasks::V2beta3::RunTaskRequest, request
      assert_equal "hello world", request.name
      assert_equal :VIEW_UNSPECIFIED, request.response_view
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, run_task_client_stub do
      # Create client
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.run_task({ name: name, response_view: response_view }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.run_task name: name, response_view: response_view do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.run_task ::Google::Cloud::Tasks::V2beta3::RunTaskRequest.new(name: name, response_view: response_view) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.run_task({ name: name, response_view: response_view }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.run_task ::Google::Cloud::Tasks::V2beta3::RunTaskRequest.new(name: name, response_view: response_view), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, run_task_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Cloud::Tasks::V2beta3::CloudTasks::Client::Configuration, config
  end
end
