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

require "google/cloud/servicedirectory/v1beta1/registration_service_pb"
require "google/cloud/servicedirectory/v1beta1/registration_service_services_pb"
require "google/cloud/service_directory/v1beta1/registration_service"

class Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::ClientTest < Minitest::Test
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

  def test_create_namespace
    # Create GRPC objects.
    grpc_response = Google::Cloud::ServiceDirectory::V1beta1::Namespace.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    namespace_id = "hello world"
    namespace = {}

    create_namespace_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_namespace, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::CreateNamespaceRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.namespace_id
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::ServiceDirectory::V1beta1::Namespace), request.namespace
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_namespace_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_namespace({ parent: parent, namespace_id: namespace_id, namespace: namespace }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_namespace parent: parent, namespace_id: namespace_id, namespace: namespace do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_namespace Google::Cloud::ServiceDirectory::V1beta1::CreateNamespaceRequest.new(parent: parent, namespace_id: namespace_id, namespace: namespace) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_namespace({ parent: parent, namespace_id: namespace_id, namespace: namespace }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_namespace Google::Cloud::ServiceDirectory::V1beta1::CreateNamespaceRequest.new(parent: parent, namespace_id: namespace_id, namespace: namespace), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_namespace_client_stub.call_rpc_count
    end
  end

  def test_list_namespaces
    # Create GRPC objects.
    grpc_response = Google::Cloud::ServiceDirectory::V1beta1::ListNamespacesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_size = 42
    page_token = "hello world"
    filter = "hello world"
    order_by = "hello world"

    list_namespaces_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_namespaces, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::ListNamespacesRequest, request
      assert_equal "hello world", request.parent
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      assert_equal "hello world", request.filter
      assert_equal "hello world", request.order_by
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_namespaces_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_namespaces({ parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_namespaces parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_namespaces Google::Cloud::ServiceDirectory::V1beta1::ListNamespacesRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_namespaces({ parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_namespaces Google::Cloud::ServiceDirectory::V1beta1::ListNamespacesRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_namespaces_client_stub.call_rpc_count
    end
  end

  def test_get_namespace
    # Create GRPC objects.
    grpc_response = Google::Cloud::ServiceDirectory::V1beta1::Namespace.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_namespace_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_namespace, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::GetNamespaceRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_namespace_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_namespace({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_namespace name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_namespace Google::Cloud::ServiceDirectory::V1beta1::GetNamespaceRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_namespace({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_namespace Google::Cloud::ServiceDirectory::V1beta1::GetNamespaceRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_namespace_client_stub.call_rpc_count
    end
  end

  def test_update_namespace
    # Create GRPC objects.
    grpc_response = Google::Cloud::ServiceDirectory::V1beta1::Namespace.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    namespace = {}
    update_mask = {}

    update_namespace_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_namespace, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::UpdateNamespaceRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::ServiceDirectory::V1beta1::Namespace), request.namespace
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_namespace_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_namespace({ namespace: namespace, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_namespace namespace: namespace, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_namespace Google::Cloud::ServiceDirectory::V1beta1::UpdateNamespaceRequest.new(namespace: namespace, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_namespace({ namespace: namespace, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_namespace Google::Cloud::ServiceDirectory::V1beta1::UpdateNamespaceRequest.new(namespace: namespace, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_namespace_client_stub.call_rpc_count
    end
  end

  def test_delete_namespace
    # Create GRPC objects.
    grpc_response = Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_namespace_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_namespace, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::DeleteNamespaceRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_namespace_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_namespace({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_namespace name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_namespace Google::Cloud::ServiceDirectory::V1beta1::DeleteNamespaceRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_namespace({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_namespace Google::Cloud::ServiceDirectory::V1beta1::DeleteNamespaceRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_namespace_client_stub.call_rpc_count
    end
  end

  def test_create_service
    # Create GRPC objects.
    grpc_response = Google::Cloud::ServiceDirectory::V1beta1::Service.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    service_id = "hello world"
    service = {}

    create_service_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_service, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::CreateServiceRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.service_id
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::ServiceDirectory::V1beta1::Service), request.service
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_service_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_service({ parent: parent, service_id: service_id, service: service }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_service parent: parent, service_id: service_id, service: service do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_service Google::Cloud::ServiceDirectory::V1beta1::CreateServiceRequest.new(parent: parent, service_id: service_id, service: service) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_service({ parent: parent, service_id: service_id, service: service }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_service Google::Cloud::ServiceDirectory::V1beta1::CreateServiceRequest.new(parent: parent, service_id: service_id, service: service), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_service_client_stub.call_rpc_count
    end
  end

  def test_list_services
    # Create GRPC objects.
    grpc_response = Google::Cloud::ServiceDirectory::V1beta1::ListServicesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_size = 42
    page_token = "hello world"
    filter = "hello world"
    order_by = "hello world"

    list_services_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_services, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::ListServicesRequest, request
      assert_equal "hello world", request.parent
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      assert_equal "hello world", request.filter
      assert_equal "hello world", request.order_by
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_services_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_services({ parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_services parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_services Google::Cloud::ServiceDirectory::V1beta1::ListServicesRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_services({ parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_services Google::Cloud::ServiceDirectory::V1beta1::ListServicesRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_services_client_stub.call_rpc_count
    end
  end

  def test_get_service
    # Create GRPC objects.
    grpc_response = Google::Cloud::ServiceDirectory::V1beta1::Service.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_service_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_service, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::GetServiceRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_service_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_service({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_service name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_service Google::Cloud::ServiceDirectory::V1beta1::GetServiceRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_service({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_service Google::Cloud::ServiceDirectory::V1beta1::GetServiceRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_service_client_stub.call_rpc_count
    end
  end

  def test_update_service
    # Create GRPC objects.
    grpc_response = Google::Cloud::ServiceDirectory::V1beta1::Service.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    service = {}
    update_mask = {}

    update_service_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_service, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::UpdateServiceRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::ServiceDirectory::V1beta1::Service), request.service
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_service_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_service({ service: service, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_service service: service, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_service Google::Cloud::ServiceDirectory::V1beta1::UpdateServiceRequest.new(service: service, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_service({ service: service, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_service Google::Cloud::ServiceDirectory::V1beta1::UpdateServiceRequest.new(service: service, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_service_client_stub.call_rpc_count
    end
  end

  def test_delete_service
    # Create GRPC objects.
    grpc_response = Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_service_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_service, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::DeleteServiceRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_service_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_service({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_service name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_service Google::Cloud::ServiceDirectory::V1beta1::DeleteServiceRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_service({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_service Google::Cloud::ServiceDirectory::V1beta1::DeleteServiceRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_service_client_stub.call_rpc_count
    end
  end

  def test_create_endpoint
    # Create GRPC objects.
    grpc_response = Google::Cloud::ServiceDirectory::V1beta1::Endpoint.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    endpoint_id = "hello world"
    endpoint = {}

    create_endpoint_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_endpoint, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::CreateEndpointRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.endpoint_id
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::ServiceDirectory::V1beta1::Endpoint), request.endpoint
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_endpoint_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_endpoint({ parent: parent, endpoint_id: endpoint_id, endpoint: endpoint }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_endpoint parent: parent, endpoint_id: endpoint_id, endpoint: endpoint do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_endpoint Google::Cloud::ServiceDirectory::V1beta1::CreateEndpointRequest.new(parent: parent, endpoint_id: endpoint_id, endpoint: endpoint) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_endpoint({ parent: parent, endpoint_id: endpoint_id, endpoint: endpoint }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_endpoint Google::Cloud::ServiceDirectory::V1beta1::CreateEndpointRequest.new(parent: parent, endpoint_id: endpoint_id, endpoint: endpoint), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_endpoint_client_stub.call_rpc_count
    end
  end

  def test_list_endpoints
    # Create GRPC objects.
    grpc_response = Google::Cloud::ServiceDirectory::V1beta1::ListEndpointsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_size = 42
    page_token = "hello world"
    filter = "hello world"
    order_by = "hello world"

    list_endpoints_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_endpoints, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::ListEndpointsRequest, request
      assert_equal "hello world", request.parent
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      assert_equal "hello world", request.filter
      assert_equal "hello world", request.order_by
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_endpoints_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_endpoints({ parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_endpoints parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_endpoints Google::Cloud::ServiceDirectory::V1beta1::ListEndpointsRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_endpoints({ parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_endpoints Google::Cloud::ServiceDirectory::V1beta1::ListEndpointsRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_endpoints_client_stub.call_rpc_count
    end
  end

  def test_get_endpoint
    # Create GRPC objects.
    grpc_response = Google::Cloud::ServiceDirectory::V1beta1::Endpoint.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_endpoint_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_endpoint, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::GetEndpointRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_endpoint_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_endpoint({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_endpoint name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_endpoint Google::Cloud::ServiceDirectory::V1beta1::GetEndpointRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_endpoint({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_endpoint Google::Cloud::ServiceDirectory::V1beta1::GetEndpointRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_endpoint_client_stub.call_rpc_count
    end
  end

  def test_update_endpoint
    # Create GRPC objects.
    grpc_response = Google::Cloud::ServiceDirectory::V1beta1::Endpoint.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    endpoint = {}
    update_mask = {}

    update_endpoint_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_endpoint, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::UpdateEndpointRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::ServiceDirectory::V1beta1::Endpoint), request.endpoint
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_endpoint_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_endpoint({ endpoint: endpoint, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_endpoint endpoint: endpoint, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_endpoint Google::Cloud::ServiceDirectory::V1beta1::UpdateEndpointRequest.new(endpoint: endpoint, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_endpoint({ endpoint: endpoint, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_endpoint Google::Cloud::ServiceDirectory::V1beta1::UpdateEndpointRequest.new(endpoint: endpoint, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_endpoint_client_stub.call_rpc_count
    end
  end

  def test_delete_endpoint
    # Create GRPC objects.
    grpc_response = Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_endpoint_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_endpoint, name
      assert_kind_of Google::Cloud::ServiceDirectory::V1beta1::DeleteEndpointRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_endpoint_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_endpoint({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_endpoint name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_endpoint Google::Cloud::ServiceDirectory::V1beta1::DeleteEndpointRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_endpoint({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_endpoint Google::Cloud::ServiceDirectory::V1beta1::DeleteEndpointRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_endpoint_client_stub.call_rpc_count
    end
  end

  def test_get_iam_policy
    # Create GRPC objects.
    grpc_response = Google::Iam::V1::Policy.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    resource = "hello world"

    get_iam_policy_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_iam_policy, name
      assert_kind_of Google::Iam::V1::GetIamPolicyRequest, request
      assert_equal "hello world", request.resource
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_iam_policy_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_iam_policy({ resource: resource }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_iam_policy resource: resource do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_iam_policy Google::Iam::V1::GetIamPolicyRequest.new(resource: resource) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_iam_policy({ resource: resource }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_iam_policy Google::Iam::V1::GetIamPolicyRequest.new(resource: resource), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_iam_policy_client_stub.call_rpc_count
    end
  end

  def test_set_iam_policy
    # Create GRPC objects.
    grpc_response = Google::Iam::V1::Policy.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    resource = "hello world"
    policy = {}

    set_iam_policy_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :set_iam_policy, name
      assert_kind_of Google::Iam::V1::SetIamPolicyRequest, request
      assert_equal "hello world", request.resource
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Iam::V1::Policy), request.policy
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, set_iam_policy_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
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
      client.set_iam_policy Google::Iam::V1::SetIamPolicyRequest.new(resource: resource, policy: policy) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.set_iam_policy({ resource: resource, policy: policy }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.set_iam_policy Google::Iam::V1::SetIamPolicyRequest.new(resource: resource, policy: policy), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, set_iam_policy_client_stub.call_rpc_count
    end
  end

  def test_test_iam_permissions
    # Create GRPC objects.
    grpc_response = Google::Iam::V1::TestIamPermissionsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    resource = "hello world"
    permissions = ["hello world"]

    test_iam_permissions_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :test_iam_permissions, name
      assert_kind_of Google::Iam::V1::TestIamPermissionsRequest, request
      assert_equal "hello world", request.resource
      assert_equal ["hello world"], request.permissions
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, test_iam_permissions_client_stub do
      # Create client
      client = Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client.new do |config|
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
      client.test_iam_permissions Google::Iam::V1::TestIamPermissionsRequest.new(resource: resource, permissions: permissions) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.test_iam_permissions({ resource: resource, permissions: permissions }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.test_iam_permissions Google::Iam::V1::TestIamPermissionsRequest.new(resource: resource, permissions: permissions), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, test_iam_permissions_client_stub.call_rpc_count
    end
  end
end
