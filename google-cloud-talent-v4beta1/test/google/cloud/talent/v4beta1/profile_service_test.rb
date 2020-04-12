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

require "google/cloud/talent/v4beta1/profile_service_pb"
require "google/cloud/talent/v4beta1/profile_service_services_pb"
require "google/cloud/talent/v4beta1/profile_service"

class Google::Cloud::Talent::V4beta1::ProfileService::ClientTest < Minitest::Test
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

  def test_list_profiles
    # Create GRPC objects.
    grpc_response = Google::Cloud::Talent::V4beta1::ListProfilesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    filter = "hello world"
    page_token = "hello world"
    page_size = 42
    read_mask = {}

    list_profiles_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_profiles, name
      assert_kind_of Google::Cloud::Talent::V4beta1::ListProfilesRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.filter
      assert_equal "hello world", request.page_token
      assert_equal 42, request.page_size
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.read_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_profiles_client_stub do
      # Create client
      client = Google::Cloud::Talent::V4beta1::ProfileService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_profiles({ parent: parent, filter: filter, page_token: page_token, page_size: page_size, read_mask: read_mask }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_profiles parent: parent, filter: filter, page_token: page_token, page_size: page_size, read_mask: read_mask do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_profiles Google::Cloud::Talent::V4beta1::ListProfilesRequest.new(parent: parent, filter: filter, page_token: page_token, page_size: page_size, read_mask: read_mask) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_profiles({ parent: parent, filter: filter, page_token: page_token, page_size: page_size, read_mask: read_mask }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_profiles Google::Cloud::Talent::V4beta1::ListProfilesRequest.new(parent: parent, filter: filter, page_token: page_token, page_size: page_size, read_mask: read_mask), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_profiles_client_stub.call_rpc_count
    end
  end

  def test_create_profile
    # Create GRPC objects.
    grpc_response = Google::Cloud::Talent::V4beta1::Profile.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    profile = {}

    create_profile_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_profile, name
      assert_kind_of Google::Cloud::Talent::V4beta1::CreateProfileRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Talent::V4beta1::Profile), request.profile
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_profile_client_stub do
      # Create client
      client = Google::Cloud::Talent::V4beta1::ProfileService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_profile({ parent: parent, profile: profile }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_profile parent: parent, profile: profile do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_profile Google::Cloud::Talent::V4beta1::CreateProfileRequest.new(parent: parent, profile: profile) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_profile({ parent: parent, profile: profile }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_profile Google::Cloud::Talent::V4beta1::CreateProfileRequest.new(parent: parent, profile: profile), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_profile_client_stub.call_rpc_count
    end
  end

  def test_get_profile
    # Create GRPC objects.
    grpc_response = Google::Cloud::Talent::V4beta1::Profile.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_profile_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_profile, name
      assert_kind_of Google::Cloud::Talent::V4beta1::GetProfileRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_profile_client_stub do
      # Create client
      client = Google::Cloud::Talent::V4beta1::ProfileService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_profile({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_profile name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_profile Google::Cloud::Talent::V4beta1::GetProfileRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_profile({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_profile Google::Cloud::Talent::V4beta1::GetProfileRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_profile_client_stub.call_rpc_count
    end
  end

  def test_update_profile
    # Create GRPC objects.
    grpc_response = Google::Cloud::Talent::V4beta1::Profile.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    profile = {}
    update_mask = {}

    update_profile_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_profile, name
      assert_kind_of Google::Cloud::Talent::V4beta1::UpdateProfileRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Talent::V4beta1::Profile), request.profile
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_profile_client_stub do
      # Create client
      client = Google::Cloud::Talent::V4beta1::ProfileService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_profile({ profile: profile, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_profile profile: profile, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_profile Google::Cloud::Talent::V4beta1::UpdateProfileRequest.new(profile: profile, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_profile({ profile: profile, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_profile Google::Cloud::Talent::V4beta1::UpdateProfileRequest.new(profile: profile, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_profile_client_stub.call_rpc_count
    end
  end

  def test_delete_profile
    # Create GRPC objects.
    grpc_response = Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_profile_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_profile, name
      assert_kind_of Google::Cloud::Talent::V4beta1::DeleteProfileRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_profile_client_stub do
      # Create client
      client = Google::Cloud::Talent::V4beta1::ProfileService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_profile({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_profile name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_profile Google::Cloud::Talent::V4beta1::DeleteProfileRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_profile({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_profile Google::Cloud::Talent::V4beta1::DeleteProfileRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_profile_client_stub.call_rpc_count
    end
  end

  def test_search_profiles
    # Create GRPC objects.
    grpc_response = Google::Cloud::Talent::V4beta1::SearchProfilesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    request_metadata = {}
    profile_query = {}
    page_size = 42
    page_token = "hello world"
    offset = 42
    disable_spell_check = true
    order_by = "hello world"
    case_sensitive_sort = true
    histogram_queries = [{}]
    result_set_id = "hello world"
    strict_keywords_search = true

    search_profiles_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :search_profiles, name
      assert_kind_of Google::Cloud::Talent::V4beta1::SearchProfilesRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Talent::V4beta1::RequestMetadata), request.request_metadata
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Talent::V4beta1::ProfileQuery), request.profile_query
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      assert_equal 42, request.offset
      assert_equal true, request.disable_spell_check
      assert_equal "hello world", request.order_by
      assert_equal true, request.case_sensitive_sort
      assert_kind_of Google::Cloud::Talent::V4beta1::HistogramQuery, request.histogram_queries.first
      assert_equal "hello world", request.result_set_id
      assert_equal true, request.strict_keywords_search
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, search_profiles_client_stub do
      # Create client
      client = Google::Cloud::Talent::V4beta1::ProfileService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.search_profiles({ parent: parent, request_metadata: request_metadata, profile_query: profile_query, page_size: page_size, page_token: page_token, offset: offset, disable_spell_check: disable_spell_check, order_by: order_by, case_sensitive_sort: case_sensitive_sort, histogram_queries: histogram_queries, result_set_id: result_set_id, strict_keywords_search: strict_keywords_search }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.search_profiles parent: parent, request_metadata: request_metadata, profile_query: profile_query, page_size: page_size, page_token: page_token, offset: offset, disable_spell_check: disable_spell_check, order_by: order_by, case_sensitive_sort: case_sensitive_sort, histogram_queries: histogram_queries, result_set_id: result_set_id, strict_keywords_search: strict_keywords_search do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.search_profiles Google::Cloud::Talent::V4beta1::SearchProfilesRequest.new(parent: parent, request_metadata: request_metadata, profile_query: profile_query, page_size: page_size, page_token: page_token, offset: offset, disable_spell_check: disable_spell_check, order_by: order_by, case_sensitive_sort: case_sensitive_sort, histogram_queries: histogram_queries, result_set_id: result_set_id, strict_keywords_search: strict_keywords_search) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.search_profiles({ parent: parent, request_metadata: request_metadata, profile_query: profile_query, page_size: page_size, page_token: page_token, offset: offset, disable_spell_check: disable_spell_check, order_by: order_by, case_sensitive_sort: case_sensitive_sort, histogram_queries: histogram_queries, result_set_id: result_set_id, strict_keywords_search: strict_keywords_search }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.search_profiles Google::Cloud::Talent::V4beta1::SearchProfilesRequest.new(parent: parent, request_metadata: request_metadata, profile_query: profile_query, page_size: page_size, page_token: page_token, offset: offset, disable_spell_check: disable_spell_check, order_by: order_by, case_sensitive_sort: case_sensitive_sort, histogram_queries: histogram_queries, result_set_id: result_set_id, strict_keywords_search: strict_keywords_search), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, search_profiles_client_stub.call_rpc_count
    end
  end
end
