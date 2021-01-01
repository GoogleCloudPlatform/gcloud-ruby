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

require "google/devtools/cloudtrace/v1/trace_pb"
require "google/devtools/cloudtrace/v1/trace_services_pb"
require "google/cloud/trace/v1/trace_service"

class ::Google::Cloud::Trace::V1::TraceService::ClientTest < Minitest::Test
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

  def test_list_traces
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Trace::V1::ListTracesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    view = :VIEW_TYPE_UNSPECIFIED
    page_size = 42
    page_token = "hello world"
    start_time = {}
    end_time = {}
    filter = "hello world"
    order_by = "hello world"

    list_traces_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_traces, name
      assert_kind_of ::Google::Cloud::Trace::V1::ListTracesRequest, request
      assert_equal "hello world", request["project_id"]
      assert_equal :VIEW_TYPE_UNSPECIFIED, request["view"]
      assert_equal 42, request["page_size"]
      assert_equal "hello world", request["page_token"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::Timestamp), request["start_time"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::Timestamp), request["end_time"]
      assert_equal "hello world", request["filter"]
      assert_equal "hello world", request["order_by"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_traces_client_stub do
      # Create client
      client = ::Google::Cloud::Trace::V1::TraceService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_traces({ project_id: project_id, view: view, page_size: page_size, page_token: page_token, start_time: start_time, end_time: end_time, filter: filter, order_by: order_by }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_traces project_id: project_id, view: view, page_size: page_size, page_token: page_token, start_time: start_time, end_time: end_time, filter: filter, order_by: order_by do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_traces ::Google::Cloud::Trace::V1::ListTracesRequest.new(project_id: project_id, view: view, page_size: page_size, page_token: page_token, start_time: start_time, end_time: end_time, filter: filter, order_by: order_by) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_traces({ project_id: project_id, view: view, page_size: page_size, page_token: page_token, start_time: start_time, end_time: end_time, filter: filter, order_by: order_by }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_traces ::Google::Cloud::Trace::V1::ListTracesRequest.new(project_id: project_id, view: view, page_size: page_size, page_token: page_token, start_time: start_time, end_time: end_time, filter: filter, order_by: order_by), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_traces_client_stub.call_rpc_count
    end
  end

  def test_get_trace
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Trace::V1::Trace.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    trace_id = "hello world"

    get_trace_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_trace, name
      assert_kind_of ::Google::Cloud::Trace::V1::GetTraceRequest, request
      assert_equal "hello world", request["project_id"]
      assert_equal "hello world", request["trace_id"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_trace_client_stub do
      # Create client
      client = ::Google::Cloud::Trace::V1::TraceService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_trace({ project_id: project_id, trace_id: trace_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_trace project_id: project_id, trace_id: trace_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_trace ::Google::Cloud::Trace::V1::GetTraceRequest.new(project_id: project_id, trace_id: trace_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_trace({ project_id: project_id, trace_id: trace_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_trace ::Google::Cloud::Trace::V1::GetTraceRequest.new(project_id: project_id, trace_id: trace_id), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_trace_client_stub.call_rpc_count
    end
  end

  def test_patch_traces
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    traces = {}

    patch_traces_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :patch_traces, name
      assert_kind_of ::Google::Cloud::Trace::V1::PatchTracesRequest, request
      assert_equal "hello world", request["project_id"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Trace::V1::Traces), request["traces"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, patch_traces_client_stub do
      # Create client
      client = ::Google::Cloud::Trace::V1::TraceService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.patch_traces({ project_id: project_id, traces: traces }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.patch_traces project_id: project_id, traces: traces do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.patch_traces ::Google::Cloud::Trace::V1::PatchTracesRequest.new(project_id: project_id, traces: traces) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.patch_traces({ project_id: project_id, traces: traces }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.patch_traces ::Google::Cloud::Trace::V1::PatchTracesRequest.new(project_id: project_id, traces: traces), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, patch_traces_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Trace::V1::TraceService::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Cloud::Trace::V1::TraceService::Client::Configuration, config
  end
end
