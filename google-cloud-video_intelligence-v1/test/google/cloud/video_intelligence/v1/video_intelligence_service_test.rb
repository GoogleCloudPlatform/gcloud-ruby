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

require "google/cloud/videointelligence/v1/video_intelligence_pb"
require "google/cloud/videointelligence/v1/video_intelligence_services_pb"
require "google/cloud/video_intelligence/v1/video_intelligence_service"

class Google::Cloud::VideoIntelligence::V1::VideoIntelligenceService::ClientTest < Minitest::Test
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

  def test_annotate_video
    # Create GRPC objects.
    grpc_response = Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    input_uri = "hello world"
    input_content = "hello world"
    features = [:FEATURE_UNSPECIFIED]
    video_context = {}
    output_uri = "hello world"
    location_id = "hello world"

    annotate_video_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :annotate_video, name
      assert_kind_of Google::Cloud::VideoIntelligence::V1::AnnotateVideoRequest, request
      assert_equal "hello world", request.input_uri
      assert_equal "hello world", request.input_content
      assert_equal [:FEATURE_UNSPECIFIED], request.features
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::VideoIntelligence::V1::VideoContext), request.video_context
      assert_equal "hello world", request.output_uri
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, annotate_video_client_stub do
      # Create client
      client = Google::Cloud::VideoIntelligence::V1::VideoIntelligenceService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.annotate_video({ input_uri: input_uri, input_content: input_content, features: features, video_context: video_context, output_uri: output_uri, location_id: location_id }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.annotate_video input_uri: input_uri, input_content: input_content, features: features, video_context: video_context, output_uri: output_uri, location_id: location_id do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.annotate_video Google::Cloud::VideoIntelligence::V1::AnnotateVideoRequest.new(input_uri: input_uri, input_content: input_content, features: features, video_context: video_context, output_uri: output_uri, location_id: location_id) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.annotate_video({ input_uri: input_uri, input_content: input_content, features: features, video_context: video_context, output_uri: output_uri, location_id: location_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.annotate_video Google::Cloud::VideoIntelligence::V1::AnnotateVideoRequest.new(input_uri: input_uri, input_content: input_content, features: features, video_context: video_context, output_uri: output_uri, location_id: location_id), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, annotate_video_client_stub.call_rpc_count
    end
  end
end
