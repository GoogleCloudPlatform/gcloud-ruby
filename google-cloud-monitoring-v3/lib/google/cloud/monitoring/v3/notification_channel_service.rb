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

require "google/cloud/monitoring/v3/version"

require "google/cloud/monitoring/v3/notification_channel_service/credentials"
require "google/cloud/monitoring/v3/notification_channel_service/paths"
require "google/cloud/monitoring/v3/notification_channel_service/client"

module Google
  module Cloud
    module Monitoring
      module V3
        ##
        # The Notification Channel API provides access to configuration that
        # controls how messages related to incidents are sent.
        #
        # To load this service and instantiate a client:
        #
        #     require "google/cloud/monitoring/v3/notification_channel_service"
        #     client = Google::Cloud::Monitoring::V3::NotificationChannelService::Client.new
        #
        module NotificationChannelService
        end
      end
    end
  end
end

helper_path = ::File.join __dir__, "notification_channel_service", "helpers.rb"
require "google/cloud/monitoring/v3/notification_channel_service/helpers" if ::File.file? helper_path
