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

require "google/dataflow/v1beta3/messages_pb"
require "google/dataflow/v1beta3/messages_services_pb"
require "google/cloud/dataflow/v1beta3/messages_v1_beta3"

class ::Google::Cloud::Dataflow::V1beta3::MessagesV1Beta3::ClientTest < Minitest::Test
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

  def test_list_job_messages
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dataflow::V1beta3::ListJobMessagesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    job_id = "hello world"
    minimum_importance = :JOB_MESSAGE_IMPORTANCE_UNKNOWN
    page_size = 42
    page_token = "hello world"
    start_time = {}
    end_time = {}
    location = "hello world"

    list_job_messages_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_job_messages, name
      assert_kind_of ::Google::Cloud::Dataflow::V1beta3::ListJobMessagesRequest, request
      assert_equal "hello world", request["project_id"]
      assert_equal "hello world", request["job_id"]
      assert_equal :JOB_MESSAGE_IMPORTANCE_UNKNOWN, request["minimum_importance"]
      assert_equal 42, request["page_size"]
      assert_equal "hello world", request["page_token"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::Timestamp), request["start_time"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::Timestamp), request["end_time"]
      assert_equal "hello world", request["location"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_job_messages_client_stub do
      # Create client
      client = ::Google::Cloud::Dataflow::V1beta3::MessagesV1Beta3::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_job_messages({ project_id: project_id, job_id: job_id, minimum_importance: minimum_importance, page_size: page_size, page_token: page_token, start_time: start_time, end_time: end_time, location: location }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_job_messages project_id: project_id, job_id: job_id, minimum_importance: minimum_importance, page_size: page_size, page_token: page_token, start_time: start_time, end_time: end_time, location: location do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_job_messages ::Google::Cloud::Dataflow::V1beta3::ListJobMessagesRequest.new(project_id: project_id, job_id: job_id, minimum_importance: minimum_importance, page_size: page_size, page_token: page_token, start_time: start_time, end_time: end_time, location: location) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_job_messages({ project_id: project_id, job_id: job_id, minimum_importance: minimum_importance, page_size: page_size, page_token: page_token, start_time: start_time, end_time: end_time, location: location }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_job_messages(::Google::Cloud::Dataflow::V1beta3::ListJobMessagesRequest.new(project_id: project_id, job_id: job_id, minimum_importance: minimum_importance, page_size: page_size, page_token: page_token, start_time: start_time, end_time: end_time, location: location), grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_job_messages_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Dataflow::V1beta3::MessagesV1Beta3::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Cloud::Dataflow::V1beta3::MessagesV1Beta3::Client::Configuration, config
  end
end
