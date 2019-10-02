# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/monitoring/v3/uptime_service.proto for package 'google.monitoring.v3'
# Original file comments:
# Copyright 2019 Google LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#


require 'grpc'
require 'google/monitoring/v3/uptime_service_pb'

module Google
  module Monitoring
    module V3
      module UptimeCheckService
        # The UptimeCheckService API is used to manage (list, create, delete, edit)
        # Uptime check configurations in the Stackdriver Monitoring product. An Uptime
        # check is a piece of configuration that determines which resources and
        # services to monitor for availability. These configurations can also be
        # configured interactively by navigating to the [Cloud Console]
        # (http://console.cloud.google.com), selecting the appropriate project,
        # clicking on "Monitoring" on the left-hand side to navigate to Stackdriver,
        # and then clicking on "Uptime".
        class Service

          include GRPC::GenericService

          self.marshal_class_method = :encode
          self.unmarshal_class_method = :decode
          self.service_name = 'google.monitoring.v3.UptimeCheckService'

          # Lists the existing valid Uptime check configurations for the project
          # (leaving out any invalid configurations).
          rpc :ListUptimeCheckConfigs, ListUptimeCheckConfigsRequest, ListUptimeCheckConfigsResponse
          # Gets a single Uptime check configuration.
          rpc :GetUptimeCheckConfig, GetUptimeCheckConfigRequest, UptimeCheckConfig
          # Creates a new Uptime check configuration.
          rpc :CreateUptimeCheckConfig, CreateUptimeCheckConfigRequest, UptimeCheckConfig
          # Updates an Uptime check configuration. You can either replace the entire
          # configuration with a new one or replace only certain fields in the current
          # configuration by specifying the fields to be updated via `updateMask`.
          # Returns the updated configuration.
          rpc :UpdateUptimeCheckConfig, UpdateUptimeCheckConfigRequest, UptimeCheckConfig
          # Deletes an Uptime check configuration. Note that this method will fail
          # if the Uptime check configuration is referenced by an alert policy or
          # other dependent configs that would be rendered invalid by the deletion.
          rpc :DeleteUptimeCheckConfig, DeleteUptimeCheckConfigRequest, Google::Protobuf::Empty
          # Returns the list of IP addresses that checkers run from
          rpc :ListUptimeCheckIps, ListUptimeCheckIpsRequest, ListUptimeCheckIpsResponse
        end

        Stub = Service.rpc_stub_class
      end
    end
  end
end
