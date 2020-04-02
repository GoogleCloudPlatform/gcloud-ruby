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

require "google/cloud/dataproc/v1/jobs_pb"
require "google/cloud/dataproc/v1/jobs_services_pb"
require "google/cloud/dataproc/v1/job_controller"

class Google::Cloud::Dataproc::V1::JobController::ClientTest < Minitest::Test
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

  def test_submit_job
    # Create GRPC objects.
    grpc_response = Google::Cloud::Dataproc::V1::Job.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    region = "hello world"
    job = {}
    request_id = "hello world"

    submit_job_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :submit_job, name
      assert_kind_of Google::Cloud::Dataproc::V1::SubmitJobRequest, request
      assert_equal "hello world", request.project_id
      assert_equal "hello world", request.region
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Dataproc::V1::Job), request.job
      assert_equal "hello world", request.request_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, submit_job_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1::JobController::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.submit_job({ project_id: project_id, region: region, job: job, request_id: request_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.submit_job project_id: project_id, region: region, job: job, request_id: request_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.submit_job Google::Cloud::Dataproc::V1::SubmitJobRequest.new(project_id: project_id, region: region, job: job, request_id: request_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.submit_job({ project_id: project_id, region: region, job: job, request_id: request_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.submit_job Google::Cloud::Dataproc::V1::SubmitJobRequest.new(project_id: project_id, region: region, job: job, request_id: request_id), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, submit_job_client_stub.call_rpc_count
    end
  end

  def test_get_job
    # Create GRPC objects.
    grpc_response = Google::Cloud::Dataproc::V1::Job.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    region = "hello world"
    job_id = "hello world"

    get_job_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_job, name
      assert_kind_of Google::Cloud::Dataproc::V1::GetJobRequest, request
      assert_equal "hello world", request.project_id
      assert_equal "hello world", request.region
      assert_equal "hello world", request.job_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_job_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1::JobController::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_job({ project_id: project_id, region: region, job_id: job_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_job project_id: project_id, region: region, job_id: job_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_job Google::Cloud::Dataproc::V1::GetJobRequest.new(project_id: project_id, region: region, job_id: job_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_job({ project_id: project_id, region: region, job_id: job_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_job Google::Cloud::Dataproc::V1::GetJobRequest.new(project_id: project_id, region: region, job_id: job_id), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_job_client_stub.call_rpc_count
    end
  end

  def test_list_jobs
    # Create GRPC objects.
    grpc_response = Google::Cloud::Dataproc::V1::ListJobsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    region = "hello world"
    page_size = 42
    page_token = "hello world"
    cluster_name = "hello world"
    job_state_matcher = :ALL
    filter = "hello world"

    list_jobs_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_jobs, name
      assert_kind_of Google::Cloud::Dataproc::V1::ListJobsRequest, request
      assert_equal "hello world", request.project_id
      assert_equal "hello world", request.region
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      assert_equal "hello world", request.cluster_name
      assert_equal :ALL, request.job_state_matcher
      assert_equal "hello world", request.filter
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_jobs_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1::JobController::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_jobs({ project_id: project_id, region: region, page_size: page_size, page_token: page_token, cluster_name: cluster_name, job_state_matcher: job_state_matcher, filter: filter }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_jobs project_id: project_id, region: region, page_size: page_size, page_token: page_token, cluster_name: cluster_name, job_state_matcher: job_state_matcher, filter: filter do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_jobs Google::Cloud::Dataproc::V1::ListJobsRequest.new(project_id: project_id, region: region, page_size: page_size, page_token: page_token, cluster_name: cluster_name, job_state_matcher: job_state_matcher, filter: filter) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_jobs({ project_id: project_id, region: region, page_size: page_size, page_token: page_token, cluster_name: cluster_name, job_state_matcher: job_state_matcher, filter: filter }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_jobs Google::Cloud::Dataproc::V1::ListJobsRequest.new(project_id: project_id, region: region, page_size: page_size, page_token: page_token, cluster_name: cluster_name, job_state_matcher: job_state_matcher, filter: filter), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_jobs_client_stub.call_rpc_count
    end
  end

  def test_update_job
    # Create GRPC objects.
    grpc_response = Google::Cloud::Dataproc::V1::Job.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    region = "hello world"
    job_id = "hello world"
    job = {}
    update_mask = {}

    update_job_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_job, name
      assert_kind_of Google::Cloud::Dataproc::V1::UpdateJobRequest, request
      assert_equal "hello world", request.project_id
      assert_equal "hello world", request.region
      assert_equal "hello world", request.job_id
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Dataproc::V1::Job), request.job
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_job_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1::JobController::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_job({ project_id: project_id, region: region, job_id: job_id, job: job, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_job project_id: project_id, region: region, job_id: job_id, job: job, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_job Google::Cloud::Dataproc::V1::UpdateJobRequest.new(project_id: project_id, region: region, job_id: job_id, job: job, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_job({ project_id: project_id, region: region, job_id: job_id, job: job, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_job Google::Cloud::Dataproc::V1::UpdateJobRequest.new(project_id: project_id, region: region, job_id: job_id, job: job, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_job_client_stub.call_rpc_count
    end
  end

  def test_cancel_job
    # Create GRPC objects.
    grpc_response = Google::Cloud::Dataproc::V1::Job.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    region = "hello world"
    job_id = "hello world"

    cancel_job_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :cancel_job, name
      assert_kind_of Google::Cloud::Dataproc::V1::CancelJobRequest, request
      assert_equal "hello world", request.project_id
      assert_equal "hello world", request.region
      assert_equal "hello world", request.job_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, cancel_job_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1::JobController::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.cancel_job({ project_id: project_id, region: region, job_id: job_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.cancel_job project_id: project_id, region: region, job_id: job_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.cancel_job Google::Cloud::Dataproc::V1::CancelJobRequest.new(project_id: project_id, region: region, job_id: job_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.cancel_job({ project_id: project_id, region: region, job_id: job_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.cancel_job Google::Cloud::Dataproc::V1::CancelJobRequest.new(project_id: project_id, region: region, job_id: job_id), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, cancel_job_client_stub.call_rpc_count
    end
  end

  def test_delete_job
    # Create GRPC objects.
    grpc_response = Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    project_id = "hello world"
    region = "hello world"
    job_id = "hello world"

    delete_job_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_job, name
      assert_kind_of Google::Cloud::Dataproc::V1::DeleteJobRequest, request
      assert_equal "hello world", request.project_id
      assert_equal "hello world", request.region
      assert_equal "hello world", request.job_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_job_client_stub do
      # Create client
      client = Google::Cloud::Dataproc::V1::JobController::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_job({ project_id: project_id, region: region, job_id: job_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_job project_id: project_id, region: region, job_id: job_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_job Google::Cloud::Dataproc::V1::DeleteJobRequest.new(project_id: project_id, region: region, job_id: job_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_job({ project_id: project_id, region: region, job_id: job_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_job Google::Cloud::Dataproc::V1::DeleteJobRequest.new(project_id: project_id, region: region, job_id: job_id), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_job_client_stub.call_rpc_count
    end
  end
end
