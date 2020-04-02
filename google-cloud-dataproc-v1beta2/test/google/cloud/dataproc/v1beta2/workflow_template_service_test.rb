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

require "google/cloud/dataproc/v1beta2/workflow_templates_pb"
require "google/cloud/dataproc/v1beta2/workflow_templates_services_pb"
require "google/cloud/dataproc/v1beta2/workflow_template_service"

class Google::Cloud::Dataproc::V1beta2::WorkflowTemplateService::ClientTest < Minitest::Test
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

  def test_create_workflow_template
    # Create GRPC objects.
    grpc_response = Google::Cloud::Dataproc::V1beta2::WorkflowTemplate.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    template = {}

    create_workflow_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_workflow_template, name
      assert_kind_of Google::Cloud::Dataproc::V1beta2::CreateWorkflowTemplateRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Dataproc::V1beta2::WorkflowTemplate), request.template
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_workflow_template_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1beta2::WorkflowTemplateService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_workflow_template({ parent: parent, template: template }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_workflow_template parent: parent, template: template do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_workflow_template Google::Cloud::Dataproc::V1beta2::CreateWorkflowTemplateRequest.new(parent: parent, template: template) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_workflow_template({ parent: parent, template: template }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_workflow_template Google::Cloud::Dataproc::V1beta2::CreateWorkflowTemplateRequest.new(parent: parent, template: template), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_workflow_template_client_stub.call_rpc_count
    end
  end

  def test_get_workflow_template
    # Create GRPC objects.
    grpc_response = Google::Cloud::Dataproc::V1beta2::WorkflowTemplate.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    version = 42

    get_workflow_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_workflow_template, name
      assert_kind_of Google::Cloud::Dataproc::V1beta2::GetWorkflowTemplateRequest, request
      assert_equal "hello world", request.name
      assert_equal 42, request.version
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_workflow_template_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1beta2::WorkflowTemplateService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_workflow_template({ name: name, version: version }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_workflow_template name: name, version: version do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_workflow_template Google::Cloud::Dataproc::V1beta2::GetWorkflowTemplateRequest.new(name: name, version: version) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_workflow_template({ name: name, version: version }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_workflow_template Google::Cloud::Dataproc::V1beta2::GetWorkflowTemplateRequest.new(name: name, version: version), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_workflow_template_client_stub.call_rpc_count
    end
  end

  def test_instantiate_workflow_template
    # Create GRPC objects.
    grpc_response = Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    version = 42
    instance_id = "hello world"
    request_id = "hello world"
    parameters = {}

    instantiate_workflow_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :instantiate_workflow_template, name
      assert_kind_of Google::Cloud::Dataproc::V1beta2::InstantiateWorkflowTemplateRequest, request
      assert_equal "hello world", request.name
      assert_equal 42, request.version
      assert_equal "hello world", request.instance_id
      assert_equal "hello world", request.request_id
      assert_equal({}, request.parameters.to_h)
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, instantiate_workflow_template_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1beta2::WorkflowTemplateService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.instantiate_workflow_template({ name: name, version: version, instance_id: instance_id, request_id: request_id, parameters: parameters }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.instantiate_workflow_template name: name, version: version, instance_id: instance_id, request_id: request_id, parameters: parameters do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.instantiate_workflow_template Google::Cloud::Dataproc::V1beta2::InstantiateWorkflowTemplateRequest.new(name: name, version: version, instance_id: instance_id, request_id: request_id, parameters: parameters) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.instantiate_workflow_template({ name: name, version: version, instance_id: instance_id, request_id: request_id, parameters: parameters }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.instantiate_workflow_template Google::Cloud::Dataproc::V1beta2::InstantiateWorkflowTemplateRequest.new(name: name, version: version, instance_id: instance_id, request_id: request_id, parameters: parameters), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, instantiate_workflow_template_client_stub.call_rpc_count
    end
  end

  def test_instantiate_inline_workflow_template
    # Create GRPC objects.
    grpc_response = Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    template = {}
    instance_id = "hello world"
    request_id = "hello world"

    instantiate_inline_workflow_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :instantiate_inline_workflow_template, name
      assert_kind_of Google::Cloud::Dataproc::V1beta2::InstantiateInlineWorkflowTemplateRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Dataproc::V1beta2::WorkflowTemplate), request.template
      assert_equal "hello world", request.instance_id
      assert_equal "hello world", request.request_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, instantiate_inline_workflow_template_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1beta2::WorkflowTemplateService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.instantiate_inline_workflow_template({ parent: parent, template: template, instance_id: instance_id, request_id: request_id }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.instantiate_inline_workflow_template parent: parent, template: template, instance_id: instance_id, request_id: request_id do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.instantiate_inline_workflow_template Google::Cloud::Dataproc::V1beta2::InstantiateInlineWorkflowTemplateRequest.new(parent: parent, template: template, instance_id: instance_id, request_id: request_id) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.instantiate_inline_workflow_template({ parent: parent, template: template, instance_id: instance_id, request_id: request_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.instantiate_inline_workflow_template Google::Cloud::Dataproc::V1beta2::InstantiateInlineWorkflowTemplateRequest.new(parent: parent, template: template, instance_id: instance_id, request_id: request_id), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, instantiate_inline_workflow_template_client_stub.call_rpc_count
    end
  end

  def test_update_workflow_template
    # Create GRPC objects.
    grpc_response = Google::Cloud::Dataproc::V1beta2::WorkflowTemplate.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    template = {}

    update_workflow_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_workflow_template, name
      assert_kind_of Google::Cloud::Dataproc::V1beta2::UpdateWorkflowTemplateRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Dataproc::V1beta2::WorkflowTemplate), request.template
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_workflow_template_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1beta2::WorkflowTemplateService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_workflow_template({ template: template }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_workflow_template template: template do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_workflow_template Google::Cloud::Dataproc::V1beta2::UpdateWorkflowTemplateRequest.new(template: template) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_workflow_template({ template: template }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_workflow_template Google::Cloud::Dataproc::V1beta2::UpdateWorkflowTemplateRequest.new(template: template), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_workflow_template_client_stub.call_rpc_count
    end
  end

  def test_list_workflow_templates
    # Create GRPC objects.
    grpc_response = Google::Cloud::Dataproc::V1beta2::ListWorkflowTemplatesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    list_workflow_templates_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_workflow_templates, name
      assert_kind_of Google::Cloud::Dataproc::V1beta2::ListWorkflowTemplatesRequest, request
      assert_equal "hello world", request.parent
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_workflow_templates_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1beta2::WorkflowTemplateService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_workflow_templates({ parent: parent, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_workflow_templates parent: parent, page_size: page_size, page_token: page_token do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_workflow_templates Google::Cloud::Dataproc::V1beta2::ListWorkflowTemplatesRequest.new(parent: parent, page_size: page_size, page_token: page_token) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_workflow_templates({ parent: parent, page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_workflow_templates Google::Cloud::Dataproc::V1beta2::ListWorkflowTemplatesRequest.new(parent: parent, page_size: page_size, page_token: page_token), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_workflow_templates_client_stub.call_rpc_count
    end
  end

  def test_delete_workflow_template
    # Create GRPC objects.
    grpc_response = Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    version = 42

    delete_workflow_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_workflow_template, name
      assert_kind_of Google::Cloud::Dataproc::V1beta2::DeleteWorkflowTemplateRequest, request
      assert_equal "hello world", request.name
      assert_equal 42, request.version
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_workflow_template_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1beta2::WorkflowTemplateService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_workflow_template({ name: name, version: version }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_workflow_template name: name, version: version do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_workflow_template Google::Cloud::Dataproc::V1beta2::DeleteWorkflowTemplateRequest.new(name: name, version: version) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_workflow_template({ name: name, version: version }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_workflow_template Google::Cloud::Dataproc::V1beta2::DeleteWorkflowTemplateRequest.new(name: name, version: version), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_workflow_template_client_stub.call_rpc_count
    end
  end
end
