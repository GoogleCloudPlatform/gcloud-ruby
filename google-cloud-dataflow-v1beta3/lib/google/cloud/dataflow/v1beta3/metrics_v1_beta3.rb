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

require "gapic/common"
require "gapic/config"
require "gapic/config/method"

require "google/cloud/dataflow/v1beta3/version"

require "google/cloud/dataflow/v1beta3/metrics_v1_beta3/credentials"
require "google/cloud/dataflow/v1beta3/metrics_v1_beta3/client"

module Google
  module Cloud
    module Dataflow
      module V1beta3
        ##
        # The Dataflow Metrics API lets you monitor the progress of Dataflow
        # jobs.
        #
        # To load this service and instantiate a client:
        #
        #     require "google/cloud/dataflow/v1beta3/metrics_v1_beta3"
        #     client = ::Google::Cloud::Dataflow::V1beta3::MetricsV1Beta3::Client.new
        #
        module MetricsV1Beta3
        end
      end
    end
  end
end

helper_path = ::File.join __dir__, "metrics_v1_beta3", "helpers.rb"
require "google/cloud/dataflow/v1beta3/metrics_v1_beta3/helpers" if ::File.file? helper_path
