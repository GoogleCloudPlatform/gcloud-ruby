# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/talent/v4beta1/event_service.proto for package 'google.cloud.talent.v4beta1'
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
require 'google/cloud/talent/v4beta1/event_service_pb'

module Google
  module Cloud
    module Talent
      module V4beta1
        module EventService
          # A service handles client event report.
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.cloud.talent.v4beta1.EventService'

            # Report events issued when end user interacts with customer's application
            # that uses Cloud Talent Solution. You may inspect the created events in
            # [self service
            # tools](https://console.cloud.google.com/talent-solution/overview).
            # [Learn
            # more](https://cloud.google.com/talent-solution/docs/management-tools)
            # about self service tools.
            rpc :CreateClientEvent, CreateClientEventRequest, ClientEvent
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
