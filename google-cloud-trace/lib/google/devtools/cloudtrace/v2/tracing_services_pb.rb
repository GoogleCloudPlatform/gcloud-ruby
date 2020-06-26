# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/devtools/cloudtrace/v2/tracing.proto for package 'Google::Cloud::Trace::V2'
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
require 'google/devtools/cloudtrace/v2/tracing_pb'

module Google
  module Devtools
    module Cloudtrace
    end
  end
end
module Google::Devtools::Cloudtrace::V2
  module TraceService
    # This file describes an API for collecting and viewing traces and spans
    # within a trace.  A Trace is a collection of spans corresponding to a single
    # operation or set of operations for an application. A span is an individual
    # timed event which forms a node of the trace tree. A single trace may
    # contain span(s) from multiple services.
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'google.devtools.cloudtrace.v2.TraceService'

      # Sends new spans to new or existing traces. You cannot update
      # existing spans.
      rpc :BatchWriteSpans, BatchWriteSpansRequest, Google::Protobuf::Empty
      # Creates a new span.
      rpc :CreateSpan, Span, Span
    end

    Stub = Service.rpc_stub_class
  end
end
