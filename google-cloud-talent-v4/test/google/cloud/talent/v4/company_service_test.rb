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

require "google/cloud/talent/v4/company_service_pb"
require "google/cloud/talent/v4/company_service_services_pb"
require "google/cloud/talent/v4/company_service"

class ::Google::Cloud::Talent::V4::CompanyService::ClientTest < Minitest::Test
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

  def test_create_company
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Talent::V4::Company.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    company = {}

    create_company_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_company, name
      assert_kind_of ::Google::Cloud::Talent::V4::CreateCompanyRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Talent::V4::Company), request.company
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_company_client_stub do
      # Create client
      client = ::Google::Cloud::Talent::V4::CompanyService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_company({ parent: parent, company: company }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_company parent: parent, company: company do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_company ::Google::Cloud::Talent::V4::CreateCompanyRequest.new(parent: parent, company: company) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_company({ parent: parent, company: company }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_company ::Google::Cloud::Talent::V4::CreateCompanyRequest.new(parent: parent, company: company), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_company_client_stub.call_rpc_count
    end
  end

  def test_get_company
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Talent::V4::Company.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_company_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_company, name
      assert_kind_of ::Google::Cloud::Talent::V4::GetCompanyRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_company_client_stub do
      # Create client
      client = ::Google::Cloud::Talent::V4::CompanyService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_company({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_company name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_company ::Google::Cloud::Talent::V4::GetCompanyRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_company({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_company ::Google::Cloud::Talent::V4::GetCompanyRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_company_client_stub.call_rpc_count
    end
  end

  def test_update_company
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Talent::V4::Company.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    company = {}
    update_mask = {}

    update_company_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_company, name
      assert_kind_of ::Google::Cloud::Talent::V4::UpdateCompanyRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Talent::V4::Company), request.company
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_company_client_stub do
      # Create client
      client = ::Google::Cloud::Talent::V4::CompanyService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_company({ company: company, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_company company: company, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_company ::Google::Cloud::Talent::V4::UpdateCompanyRequest.new(company: company, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_company({ company: company, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_company ::Google::Cloud::Talent::V4::UpdateCompanyRequest.new(company: company, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_company_client_stub.call_rpc_count
    end
  end

  def test_delete_company
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_company_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_company, name
      assert_kind_of ::Google::Cloud::Talent::V4::DeleteCompanyRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_company_client_stub do
      # Create client
      client = ::Google::Cloud::Talent::V4::CompanyService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_company({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_company name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_company ::Google::Cloud::Talent::V4::DeleteCompanyRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_company({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_company ::Google::Cloud::Talent::V4::DeleteCompanyRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_company_client_stub.call_rpc_count
    end
  end

  def test_list_companies
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Talent::V4::ListCompaniesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_token = "hello world"
    page_size = 42
    require_open_jobs = true

    list_companies_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_companies, name
      assert_kind_of ::Google::Cloud::Talent::V4::ListCompaniesRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.page_token
      assert_equal 42, request.page_size
      assert_equal true, request.require_open_jobs
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_companies_client_stub do
      # Create client
      client = ::Google::Cloud::Talent::V4::CompanyService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_companies({ parent: parent, page_token: page_token, page_size: page_size, require_open_jobs: require_open_jobs }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_companies parent: parent, page_token: page_token, page_size: page_size, require_open_jobs: require_open_jobs do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_companies ::Google::Cloud::Talent::V4::ListCompaniesRequest.new(parent: parent, page_token: page_token, page_size: page_size, require_open_jobs: require_open_jobs) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_companies({ parent: parent, page_token: page_token, page_size: page_size, require_open_jobs: require_open_jobs }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_companies ::Google::Cloud::Talent::V4::ListCompaniesRequest.new(parent: parent, page_token: page_token, page_size: page_size, require_open_jobs: require_open_jobs), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_companies_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Talent::V4::CompanyService::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Cloud::Talent::V4::CompanyService::Client::Configuration, config
  end
end
