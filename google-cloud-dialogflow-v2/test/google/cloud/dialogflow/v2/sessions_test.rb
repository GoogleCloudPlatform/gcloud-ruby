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

require "google/cloud/dialogflow/v2/session_pb"
require "google/cloud/dialogflow/v2/session_services_pb"
require "google/cloud/dialogflow/v2/sessions"

class ::Google::Cloud::Dialogflow::V2::Sessions::ClientTest < Minitest::Test
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

  def test_detect_intent
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dialogflow::V2::DetectIntentResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    session = "hello world"
    query_params = {}
    query_input = {}
    output_audio_config = {}
    output_audio_config_mask = {}
    input_audio = "hello world"

    detect_intent_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :detect_intent, name
      assert_kind_of ::Google::Cloud::Dialogflow::V2::DetectIntentRequest, request
      assert_equal "hello world", request.session
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dialogflow::V2::QueryParameters), request.query_params
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dialogflow::V2::QueryInput), request.query_input
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dialogflow::V2::OutputAudioConfig), request.output_audio_config
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::FieldMask), request.output_audio_config_mask
      assert_equal "hello world", request.input_audio
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, detect_intent_client_stub do
      # Create client
      client = ::Google::Cloud::Dialogflow::V2::Sessions::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.detect_intent({ session: session, query_params: query_params, query_input: query_input, output_audio_config: output_audio_config, output_audio_config_mask: output_audio_config_mask, input_audio: input_audio }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.detect_intent session: session, query_params: query_params, query_input: query_input, output_audio_config: output_audio_config, output_audio_config_mask: output_audio_config_mask, input_audio: input_audio do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.detect_intent ::Google::Cloud::Dialogflow::V2::DetectIntentRequest.new(session: session, query_params: query_params, query_input: query_input, output_audio_config: output_audio_config, output_audio_config_mask: output_audio_config_mask, input_audio: input_audio) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.detect_intent({ session: session, query_params: query_params, query_input: query_input, output_audio_config: output_audio_config, output_audio_config_mask: output_audio_config_mask, input_audio: input_audio }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.detect_intent ::Google::Cloud::Dialogflow::V2::DetectIntentRequest.new(session: session, query_params: query_params, query_input: query_input, output_audio_config: output_audio_config, output_audio_config_mask: output_audio_config_mask, input_audio: input_audio), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, detect_intent_client_stub.call_rpc_count
    end
  end

  def test_streaming_detect_intent
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dialogflow::V2::StreamingDetectIntentResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a bidi streaming method.
    session = "hello world"
    query_params = {}
    query_input = {}
    single_utterance = true
    output_audio_config = {}
    output_audio_config_mask = {}
    input_audio = "hello world"

    streaming_detect_intent_client_stub = ClientStub.new [grpc_response].to_enum, grpc_operation do |name, request, options:|
      assert_equal :streaming_detect_intent, name
      assert_kind_of Enumerable, request
      refute_nil options
      request
    end

    Gapic::ServiceStub.stub :new, streaming_detect_intent_client_stub do
      # Create client
      client = ::Google::Cloud::Dialogflow::V2::Sessions::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use enumerable object with hash and protobuf object.
      request_hash = { session: session, query_params: query_params, query_input: query_input, single_utterance: single_utterance, output_audio_config: output_audio_config, output_audio_config_mask: output_audio_config_mask, input_audio: input_audio }
      request_proto = ::Google::Cloud::Dialogflow::V2::StreamingDetectIntentRequest.new session: session, query_params: query_params, query_input: query_input, single_utterance: single_utterance, output_audio_config: output_audio_config, output_audio_config_mask: output_audio_config_mask, input_audio: input_audio
      enum_input = [request_hash, request_proto].to_enum
      client.streaming_detect_intent enum_input do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Cloud::Dialogflow::V2::StreamingDetectIntentResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use stream input object (from gapic-common).
      request_hash = { session: session, query_params: query_params, query_input: query_input, single_utterance: single_utterance, output_audio_config: output_audio_config, output_audio_config_mask: output_audio_config_mask, input_audio: input_audio }
      request_proto = ::Google::Cloud::Dialogflow::V2::StreamingDetectIntentRequest.new session: session, query_params: query_params, query_input: query_input, single_utterance: single_utterance, output_audio_config: output_audio_config, output_audio_config_mask: output_audio_config_mask, input_audio: input_audio
      stream_input = Gapic::StreamInput.new
      client.streaming_detect_intent stream_input do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Cloud::Dialogflow::V2::StreamingDetectIntentResponse, r
        end
        assert_equal grpc_operation, operation
      end
      stream_input << request_hash
      stream_input << request_proto
      stream_input.close

      # Use enumerable object with hash and protobuf object with options.
      request_hash = { session: session, query_params: query_params, query_input: query_input, single_utterance: single_utterance, output_audio_config: output_audio_config, output_audio_config_mask: output_audio_config_mask, input_audio: input_audio }
      request_proto = ::Google::Cloud::Dialogflow::V2::StreamingDetectIntentRequest.new session: session, query_params: query_params, query_input: query_input, single_utterance: single_utterance, output_audio_config: output_audio_config, output_audio_config_mask: output_audio_config_mask, input_audio: input_audio
      enum_input = [request_hash, request_proto].to_enum
      client.streaming_detect_intent enum_input, grpc_options do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Cloud::Dialogflow::V2::StreamingDetectIntentResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use stream input object (from gapic-common) with options.
      request_hash = { session: session, query_params: query_params, query_input: query_input, single_utterance: single_utterance, output_audio_config: output_audio_config, output_audio_config_mask: output_audio_config_mask, input_audio: input_audio }
      request_proto = ::Google::Cloud::Dialogflow::V2::StreamingDetectIntentRequest.new session: session, query_params: query_params, query_input: query_input, single_utterance: single_utterance, output_audio_config: output_audio_config, output_audio_config_mask: output_audio_config_mask, input_audio: input_audio
      stream_input = Gapic::StreamInput.new
      client.streaming_detect_intent stream_input, grpc_options do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Cloud::Dialogflow::V2::StreamingDetectIntentResponse, r
        end
        assert_equal grpc_operation, operation
      end
      stream_input << request_hash
      stream_input << request_proto
      stream_input.close

      # Verify method calls
      assert_equal 4, streaming_detect_intent_client_stub.call_rpc_count
      streaming_detect_intent_client_stub.requests.each do |request|
        request.to_a.each do |r|
          assert_kind_of ::Google::Cloud::Dialogflow::V2::StreamingDetectIntentRequest, r
          assert_equal "hello world", r.session
          assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dialogflow::V2::QueryParameters), r.query_params
          assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dialogflow::V2::QueryInput), r.query_input
          assert_equal true, r.single_utterance
          assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dialogflow::V2::OutputAudioConfig), r.output_audio_config
          assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::FieldMask), r.output_audio_config_mask
          assert_equal "hello world", r.input_audio
        end
      end
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Dialogflow::V2::Sessions::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Cloud::Dialogflow::V2::Sessions::Client::Configuration, config
  end
end
