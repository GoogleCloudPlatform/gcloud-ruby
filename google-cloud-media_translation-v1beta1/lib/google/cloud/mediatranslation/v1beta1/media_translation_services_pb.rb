# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/mediatranslation/v1beta1/media_translation.proto for package 'Google.Cloud.MediaTranslation.V1beta1'
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
require 'google/cloud/mediatranslation/v1beta1/media_translation_pb'

module Google
  module Cloud
    module MediaTranslation
      module V1beta1
        module SpeechTranslationService
          # Provides translation from/to media types.
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.cloud.mediatranslation.v1beta1.SpeechTranslationService'

            # Performs bidirectional streaming speech translation: receive results while
            # sending audio. This method is only available via the gRPC API (not REST).
            rpc :StreamingTranslateSpeech, stream(::Google::Cloud::MediaTranslation::V1beta1::StreamingTranslateSpeechRequest), stream(::Google::Cloud::MediaTranslation::V1beta1::StreamingTranslateSpeechResponse)
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
