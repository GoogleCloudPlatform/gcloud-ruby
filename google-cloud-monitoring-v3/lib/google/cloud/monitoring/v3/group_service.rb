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

require "google/cloud/monitoring/v3/version"

require "google/cloud/monitoring/v3/group_service/credentials"
require "google/cloud/monitoring/v3/group_service/paths"
require "google/cloud/monitoring/v3/group_service/client"

module Google
  module Cloud
    module Monitoring
      module V3
        ##
        # The Group API lets you inspect and manage your
        # [groups](#google.monitoring.v3.Group).
        #
        # A group is a named filter that is used to identify
        # a collection of monitored resources. Groups are typically used to
        # mirror the physical and/or logical topology of the environment.
        # Because group membership is computed dynamically, monitored
        # resources that are started in the future are automatically placed
        # in matching groups. By using a group to name monitored resources in,
        # for example, an alert policy, the target of that alert policy is
        # updated automatically as monitored resources are added and removed
        # from the infrastructure.
        #
        # To load this service and instantiate a client:
        #
        #     require "google/cloud/monitoring/v3/group_service"
        #     client = ::Google::Cloud::Monitoring::V3::GroupService::Client.new
        #
        module GroupService
        end
      end
    end
  end
end

helper_path = ::File.join __dir__, "group_service", "helpers.rb"
require "google/cloud/monitoring/v3/group_service/helpers" if ::File.file? helper_path
