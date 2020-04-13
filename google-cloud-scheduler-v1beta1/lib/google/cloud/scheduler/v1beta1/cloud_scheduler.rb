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

require "gapic/common"
require "gapic/config"
require "gapic/config/method"

require "google/cloud/scheduler/v1beta1/version"

require "google/cloud/scheduler/v1beta1/cloud_scheduler/credentials"
require "google/cloud/scheduler/v1beta1/cloud_scheduler/paths"
require "google/cloud/scheduler/v1beta1/cloud_scheduler/client"

module Google
  module Cloud
    module Scheduler
      module V1beta1
        ##
        # The Cloud Scheduler API allows external entities to reliably
        # schedule asynchronous jobs.
        #
        # To load this service and instantiate a client:
        #
        #     require "google/cloud/scheduler/v1beta1/cloud_scheduler"
        #     client = Google::Cloud::Scheduler::V1beta1::CloudScheduler::Client.new
        #
        module CloudScheduler
        end
      end
    end
  end
end

helper_path = ::File.join __dir__, "cloud_scheduler", "helpers.rb"
require "google/cloud/scheduler/v1beta1/cloud_scheduler/helpers" if ::File.file? helper_path
