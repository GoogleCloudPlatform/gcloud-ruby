# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/videointelligence/v1beta2/video_intelligence.proto for package 'Google::Cloud::VideoIntelligence::V1beta2'
# Original file comments:
# Copyright 2017 Google Inc.
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
require 'google/cloud/videointelligence/v1beta2/video_intelligence_pb'

module Google
  module Cloud
    module VideoIntelligence
    end
    Videointelligence = VideoIntelligence unless const_defined? :Videointelligence
  end
end
module Google::Cloud::VideoIntelligence::V1beta2
  module VideoIntelligenceService
    # Service that implements Google Cloud Video Intelligence API.
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'google.cloud.videointelligence.v1beta2.VideoIntelligenceService'

      # Performs asynchronous video annotation. Progress and results can be
      # retrieved through the `google.longrunning.Operations` interface.
      # `Operation.metadata` contains `AnnotateVideoProgress` (progress).
      # `Operation.response` contains `AnnotateVideoResponse` (results).
      rpc :AnnotateVideo, AnnotateVideoRequest, Google::Longrunning::Operation
    end

    Stub = Service.rpc_stub_class
  end
end
