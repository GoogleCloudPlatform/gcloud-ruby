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

require "google/cloud/assured_workloads/v1beta1/assured_workloads_service"

class ::Google::Cloud::AssuredWorkloads::V1beta1::AssuredWorkloadsService::ClientPathsTest < Minitest::Test
  def test_location_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::AssuredWorkloads::V1beta1::AssuredWorkloadsService::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.location_path organization: "value0", location: "value1"
      assert_equal "organizations/value0/locations/value1", path
    end
  end

  def test_workload_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::AssuredWorkloads::V1beta1::AssuredWorkloadsService::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.workload_path organization: "value0", location: "value1", workload: "value2"
      assert_equal "organizations/value0/locations/value1/workloads/value2", path
    end
  end
end
