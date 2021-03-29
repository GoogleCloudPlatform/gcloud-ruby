# frozen_string_literal: true

# Copyright 2021 Google LLC
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

require "google/cloud/metastore/v1/metastore_pb"
require "google/cloud/metastore/v1/metastore_services_pb"
require "google/cloud/metastore/v1/dataproc_metastore"

class ::Google::Cloud::Metastore::V1::DataprocMetastore::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_rpc_count, :requests

    def initialize response, operation, &block
      @response = response
      @operation = operation
      @block = block
      @call_rpc_count = 0
      @requests = []
    end

    def call_rpc *args, **kwargs
      @call_rpc_count += 1

      @requests << @block&.call(*args, **kwargs)

      yield @response, @operation if block_given?

      @response
    end
  end

  def test_list_services
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Metastore::V1::ListServicesResponse.new
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
      assert_kind_of ::Google::Cloud::Metastore::V1::ListServicesRequest, request
      assert_equal "hello world", request["parent"]
      assert_equal 42, request["page_size"]
      assert_equal "hello world", request["page_token"]
      assert_equal "hello world", request["filter"]
      assert_equal "hello world", request["order_by"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_services_client_stub do
      # Create client
      client = ::Google::Cloud::Metastore::V1::DataprocMetastore::Client.new do |config|
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
      client.list_services ::Google::Cloud::Metastore::V1::ListServicesRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by) do |response, operation|
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
      client.list_services(::Google::Cloud::Metastore::V1::ListServicesRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by), grpc_options) do |response, operation|
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
    grpc_response = ::Google::Cloud::Metastore::V1::Service.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_service_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_service, name
      assert_kind_of ::Google::Cloud::Metastore::V1::GetServiceRequest, request
      assert_equal "hello world", request["name"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_service_client_stub do
      # Create client
      client = ::Google::Cloud::Metastore::V1::DataprocMetastore::Client.new do |config|
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
      client.get_service ::Google::Cloud::Metastore::V1::GetServiceRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_service({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_service(::Google::Cloud::Metastore::V1::GetServiceRequest.new(name: name), grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_service_client_stub.call_rpc_count
    end
  end

  def test_create_service
    # Create GRPC objects.
    grpc_response = ::Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    service_id = "hello world"
    service = {}
    request_id = "hello world"

    create_service_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_service, name
      assert_kind_of ::Google::Cloud::Metastore::V1::CreateServiceRequest, request
      assert_equal "hello world", request["parent"]
      assert_equal "hello world", request["service_id"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Metastore::V1::Service), request["service"]
      assert_equal "hello world", request["request_id"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_service_client_stub do
      # Create client
      client = ::Google::Cloud::Metastore::V1::DataprocMetastore::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_service({ parent: parent, service_id: service_id, service: service, request_id: request_id }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_service parent: parent, service_id: service_id, service: service, request_id: request_id do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_service ::Google::Cloud::Metastore::V1::CreateServiceRequest.new(parent: parent, service_id: service_id, service: service, request_id: request_id) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_service({ parent: parent, service_id: service_id, service: service, request_id: request_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_service(::Google::Cloud::Metastore::V1::CreateServiceRequest.new(parent: parent, service_id: service_id, service: service, request_id: request_id), grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_service_client_stub.call_rpc_count
    end
  end

  def test_update_service
    # Create GRPC objects.
    grpc_response = ::Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    update_mask = {}
    service = {}
    request_id = "hello world"

    update_service_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_service, name
      assert_kind_of ::Google::Cloud::Metastore::V1::UpdateServiceRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::FieldMask), request["update_mask"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Metastore::V1::Service), request["service"]
      assert_equal "hello world", request["request_id"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_service_client_stub do
      # Create client
      client = ::Google::Cloud::Metastore::V1::DataprocMetastore::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_service({ update_mask: update_mask, service: service, request_id: request_id }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_service update_mask: update_mask, service: service, request_id: request_id do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_service ::Google::Cloud::Metastore::V1::UpdateServiceRequest.new(update_mask: update_mask, service: service, request_id: request_id) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_service({ update_mask: update_mask, service: service, request_id: request_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_service(::Google::Cloud::Metastore::V1::UpdateServiceRequest.new(update_mask: update_mask, service: service, request_id: request_id), grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_service_client_stub.call_rpc_count
    end
  end

  def test_delete_service
    # Create GRPC objects.
    grpc_response = ::Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    request_id = "hello world"

    delete_service_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_service, name
      assert_kind_of ::Google::Cloud::Metastore::V1::DeleteServiceRequest, request
      assert_equal "hello world", request["name"]
      assert_equal "hello world", request["request_id"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_service_client_stub do
      # Create client
      client = ::Google::Cloud::Metastore::V1::DataprocMetastore::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_service({ name: name, request_id: request_id }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_service name: name, request_id: request_id do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_service ::Google::Cloud::Metastore::V1::DeleteServiceRequest.new(name: name, request_id: request_id) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_service({ name: name, request_id: request_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_service(::Google::Cloud::Metastore::V1::DeleteServiceRequest.new(name: name, request_id: request_id), grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_service_client_stub.call_rpc_count
    end
  end

  def test_list_metadata_imports
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Metastore::V1::ListMetadataImportsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_size = 42
    page_token = "hello world"
    filter = "hello world"
    order_by = "hello world"

    list_metadata_imports_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_metadata_imports, name
      assert_kind_of ::Google::Cloud::Metastore::V1::ListMetadataImportsRequest, request
      assert_equal "hello world", request["parent"]
      assert_equal 42, request["page_size"]
      assert_equal "hello world", request["page_token"]
      assert_equal "hello world", request["filter"]
      assert_equal "hello world", request["order_by"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_metadata_imports_client_stub do
      # Create client
      client = ::Google::Cloud::Metastore::V1::DataprocMetastore::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_metadata_imports({ parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_metadata_imports parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_metadata_imports ::Google::Cloud::Metastore::V1::ListMetadataImportsRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_metadata_imports({ parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_metadata_imports(::Google::Cloud::Metastore::V1::ListMetadataImportsRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter, order_by: order_by), grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_metadata_imports_client_stub.call_rpc_count
    end
  end

  def test_get_metadata_import
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Metastore::V1::MetadataImport.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_metadata_import_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_metadata_import, name
      assert_kind_of ::Google::Cloud::Metastore::V1::GetMetadataImportRequest, request
      assert_equal "hello world", request["name"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_metadata_import_client_stub do
      # Create client
      client = ::Google::Cloud::Metastore::V1::DataprocMetastore::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_metadata_import({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_metadata_import name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_metadata_import ::Google::Cloud::Metastore::V1::GetMetadataImportRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_metadata_import({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_metadata_import(::Google::Cloud::Metastore::V1::GetMetadataImportRequest.new(name: name), grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_metadata_import_client_stub.call_rpc_count
    end
  end

  def test_create_metadata_import
    # Create GRPC objects.
    grpc_response = ::Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    metadata_import_id = "hello world"
    metadata_import = {}
    request_id = "hello world"

    create_metadata_import_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_metadata_import, name
      assert_kind_of ::Google::Cloud::Metastore::V1::CreateMetadataImportRequest, request
      assert_equal "hello world", request["parent"]
      assert_equal "hello world", request["metadata_import_id"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Metastore::V1::MetadataImport), request["metadata_import"]
      assert_equal "hello world", request["request_id"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_metadata_import_client_stub do
      # Create client
      client = ::Google::Cloud::Metastore::V1::DataprocMetastore::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_metadata_import({ parent: parent, metadata_import_id: metadata_import_id, metadata_import: metadata_import, request_id: request_id }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_metadata_import parent: parent, metadata_import_id: metadata_import_id, metadata_import: metadata_import, request_id: request_id do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_metadata_import ::Google::Cloud::Metastore::V1::CreateMetadataImportRequest.new(parent: parent, metadata_import_id: metadata_import_id, metadata_import: metadata_import, request_id: request_id) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_metadata_import({ parent: parent, metadata_import_id: metadata_import_id, metadata_import: metadata_import, request_id: request_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_metadata_import(::Google::Cloud::Metastore::V1::CreateMetadataImportRequest.new(parent: parent, metadata_import_id: metadata_import_id, metadata_import: metadata_import, request_id: request_id), grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_metadata_import_client_stub.call_rpc_count
    end
  end

  def test_update_metadata_import
    # Create GRPC objects.
    grpc_response = ::Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    update_mask = {}
    metadata_import = {}
    request_id = "hello world"

    update_metadata_import_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_metadata_import, name
      assert_kind_of ::Google::Cloud::Metastore::V1::UpdateMetadataImportRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::FieldMask), request["update_mask"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Metastore::V1::MetadataImport), request["metadata_import"]
      assert_equal "hello world", request["request_id"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_metadata_import_client_stub do
      # Create client
      client = ::Google::Cloud::Metastore::V1::DataprocMetastore::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_metadata_import({ update_mask: update_mask, metadata_import: metadata_import, request_id: request_id }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_metadata_import update_mask: update_mask, metadata_import: metadata_import, request_id: request_id do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_metadata_import ::Google::Cloud::Metastore::V1::UpdateMetadataImportRequest.new(update_mask: update_mask, metadata_import: metadata_import, request_id: request_id) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_metadata_import({ update_mask: update_mask, metadata_import: metadata_import, request_id: request_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_metadata_import(::Google::Cloud::Metastore::V1::UpdateMetadataImportRequest.new(update_mask: update_mask, metadata_import: metadata_import, request_id: request_id), grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_metadata_import_client_stub.call_rpc_count
    end
  end

  def test_export_metadata
    # Create GRPC objects.
    grpc_response = ::Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    destination_gcs_folder = "hello world"
    service = "hello world"
    request_id = "hello world"
    database_dump_type = :TYPE_UNSPECIFIED

    export_metadata_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :export_metadata, name
      assert_kind_of ::Google::Cloud::Metastore::V1::ExportMetadataRequest, request
      assert_equal "hello world", request["destination_gcs_folder"]
      assert_equal :destination_gcs_folder, request.destination
      assert_equal "hello world", request["service"]
      assert_equal "hello world", request["request_id"]
      assert_equal :TYPE_UNSPECIFIED, request["database_dump_type"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, export_metadata_client_stub do
      # Create client
      client = ::Google::Cloud::Metastore::V1::DataprocMetastore::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.export_metadata({ destination_gcs_folder: destination_gcs_folder, service: service, request_id: request_id, database_dump_type: database_dump_type }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.export_metadata destination_gcs_folder: destination_gcs_folder, service: service, request_id: request_id, database_dump_type: database_dump_type do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.export_metadata ::Google::Cloud::Metastore::V1::ExportMetadataRequest.new(destination_gcs_folder: destination_gcs_folder, service: service, request_id: request_id, database_dump_type: database_dump_type) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.export_metadata({ destination_gcs_folder: destination_gcs_folder, service: service, request_id: request_id, database_dump_type: database_dump_type }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.export_metadata(::Google::Cloud::Metastore::V1::ExportMetadataRequest.new(destination_gcs_folder: destination_gcs_folder, service: service, request_id: request_id, database_dump_type: database_dump_type), grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, export_metadata_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Metastore::V1::DataprocMetastore::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Cloud::Metastore::V1::DataprocMetastore::Client::Configuration, config
  end

  def test_operations_client
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Metastore::V1::DataprocMetastore::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    assert_kind_of ::Google::Cloud::Metastore::V1::DataprocMetastore::Operations, client.operations_client
  end
end
