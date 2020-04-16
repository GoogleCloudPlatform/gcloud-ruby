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

require "google/cloud/container/v1/version"

require "google/cloud/container/v1/cluster_manager/credentials"
require "google/cloud/container/v1/cluster_manager/client"

module Google
  module Cloud
    module Container
      module V1
        ##
        # Google Kubernetes Engine Cluster Manager v1
        #
        # To load this service and instantiate a client:
        #
        #     require "google/cloud/container/v1/cluster_manager"
        #     client = Google::Cloud::Container::V1::ClusterManager::Client.new
        #
        module ClusterManager
        end
      end
    end
  end
end

helper_path = ::File.join __dir__, "cluster_manager", "helpers.rb"
require "google/cloud/container/v1/cluster_manager/helpers" if ::File.file? helper_path
