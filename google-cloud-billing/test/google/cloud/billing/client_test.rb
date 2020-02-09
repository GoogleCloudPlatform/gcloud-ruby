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

require "helper"
require "google/cloud/billing"
require "gapic/common"
require "gapic/grpc"

describe Google::Cloud::Billing do
  let(:grpc_channel) { GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure }

  it "constructs a billing service client with the default version" do
    Gapic::ServiceStub.stub :new, :stub do
      client = Google::Cloud::Billing.cloud_billing_service do |config|
        config.credentials = grpc_channel
      end
      client.must_be_kind_of Google::Cloud::Billing::V1::CloudBilling::Client
    end
  end

  it "constructs a catalog service client with the default version" do
    Gapic::ServiceStub.stub :new, :stub do
      client = Google::Cloud::Billing.cloud_catalog_service do |config|
        config.credentials = grpc_channel
      end
      client.must_be_kind_of Google::Cloud::Billing::V1::CloudCatalog::Client
    end
  end
end
