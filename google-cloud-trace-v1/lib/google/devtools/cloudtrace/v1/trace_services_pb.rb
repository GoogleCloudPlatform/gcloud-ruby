# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/devtools/cloudtrace/v1/trace.proto for package 'Google.Cloud.Trace.V1'
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

require 'grpc'
require 'google/devtools/cloudtrace/v1/trace_pb'

module Google
  module Cloud
    module Trace
      module V1
        module TraceService
          # This file describes an API for collecting and viewing traces and spans
          # within a trace.  A Trace is a collection of spans corresponding to a single
          # operation or set of operations for an application. A span is an individual
          # timed event which forms a node of the trace tree. Spans for a single trace
          # may span multiple services.
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.devtools.cloudtrace.v1.TraceService'

            # Returns of a list of traces that match the specified filter conditions.
            rpc :ListTraces, Google::Cloud::Trace::V1::ListTracesRequest, Google::Cloud::Trace::V1::ListTracesResponse
            # Gets a single trace by its ID.
            rpc :GetTrace, Google::Cloud::Trace::V1::GetTraceRequest, Google::Cloud::Trace::V1::Trace
            # Sends new traces to Stackdriver Trace or updates existing traces. If the ID
            # of a trace that you send matches that of an existing trace, any fields
            # in the existing trace and its spans are overwritten by the provided values,
            # and any new fields provided are merged with the existing trace data. If the
            # ID does not match, a new trace is created.
            rpc :PatchTraces, Google::Cloud::Trace::V1::PatchTracesRequest, Google::Protobuf::Empty
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
