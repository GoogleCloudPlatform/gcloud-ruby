# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/dataflow/v1beta3/messages.proto for package 'Google.Cloud.Dataflow.V1beta3'
# Original file comments:
# Copyright 2021 Google LLC
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
require 'google/dataflow/v1beta3/messages_pb'

module Google
  module Cloud
    module Dataflow
      module V1beta3
        module MessagesV1Beta3
          # The Dataflow Messages API is used for monitoring the progress of
          # Dataflow jobs.
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.dataflow.v1beta3.MessagesV1Beta3'

            # Request the job status.
            #
            # To request the status of a job, we recommend using
            # `projects.locations.jobs.messages.list` with a [regional endpoint]
            # (https://cloud.google.com/dataflow/docs/concepts/regional-endpoints). Using
            # `projects.jobs.messages.list` is not recommended, as you can only request
            # the status of jobs that are running in `us-central1`.
            rpc :ListJobMessages, ::Google::Cloud::Dataflow::V1beta3::ListJobMessagesRequest, ::Google::Cloud::Dataflow::V1beta3::ListJobMessagesResponse
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
