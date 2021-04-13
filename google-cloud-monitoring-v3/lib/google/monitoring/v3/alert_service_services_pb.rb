# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/monitoring/v3/alert_service.proto for package 'Google.Cloud.Monitoring.V3'
# Original file comments:
# Copyright 2020 Google LLC
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

require 'grpc'
require 'google/monitoring/v3/alert_service_pb'

module Google
  module Cloud
    module Monitoring
      module V3
        module AlertPolicyService
          # The AlertPolicyService API is used to manage (list, create, delete,
          # edit) alert policies in Stackdriver Monitoring. An alerting policy is
          # a description of the conditions under which some aspect of your
          # system is considered to be "unhealthy" and the ways to notify
          # people or services about this state. In addition to using this API, alert
          # policies can also be managed through
          # [Stackdriver Monitoring](https://cloud.google.com/monitoring/docs/),
          # which can be reached by clicking the "Monitoring" tab in
          # [Cloud Console](https://console.cloud.google.com/).
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.monitoring.v3.AlertPolicyService'

            # Lists the existing alerting policies for the workspace.
            rpc :ListAlertPolicies, ::Google::Cloud::Monitoring::V3::ListAlertPoliciesRequest, ::Google::Cloud::Monitoring::V3::ListAlertPoliciesResponse
            # Gets a single alerting policy.
            rpc :GetAlertPolicy, ::Google::Cloud::Monitoring::V3::GetAlertPolicyRequest, ::Google::Cloud::Monitoring::V3::AlertPolicy
            # Creates a new alerting policy.
            rpc :CreateAlertPolicy, ::Google::Cloud::Monitoring::V3::CreateAlertPolicyRequest, ::Google::Cloud::Monitoring::V3::AlertPolicy
            # Deletes an alerting policy.
            rpc :DeleteAlertPolicy, ::Google::Cloud::Monitoring::V3::DeleteAlertPolicyRequest, ::Google::Protobuf::Empty
            # Updates an alerting policy. You can either replace the entire policy with
            # a new one or replace only certain fields in the current alerting policy by
            # specifying the fields to be updated via `updateMask`. Returns the
            # updated alerting policy.
            rpc :UpdateAlertPolicy, ::Google::Cloud::Monitoring::V3::UpdateAlertPolicyRequest, ::Google::Cloud::Monitoring::V3::AlertPolicy
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
