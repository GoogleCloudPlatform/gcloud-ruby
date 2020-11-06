# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/documentai/v1beta3/document_processor_service.proto for package 'Google.Cloud.DocumentAI.V1beta3'
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
require 'google/cloud/documentai/v1beta3/document_processor_service_pb'

module Google
  module Cloud
    module DocumentAI
      module V1beta3
        module DocumentProcessorService
          # Service to call Cloud DocumentAI to process documents according to the
          # processor's definition. Processors are built using state-of-the-art Google
          # AI such as natural language, computer vision, and translation to extract
          # structured information from unstructured or semi-structured documents.
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.cloud.documentai.v1beta3.DocumentProcessorService'

            # Processes a single document.
            rpc :ProcessDocument, ::Google::Cloud::DocumentAI::V1beta3::ProcessRequest, ::Google::Cloud::DocumentAI::V1beta3::ProcessResponse
            # LRO endpoint to batch process many documents. The output is written
            # to Cloud Storage as JSON in the [Document] format.
            rpc :BatchProcessDocuments, ::Google::Cloud::DocumentAI::V1beta3::BatchProcessRequest, ::Google::Longrunning::Operation
            # Send a document for Human Review. The input document should be processed by
            # the specified processor.
            rpc :ReviewDocument, ::Google::Cloud::DocumentAI::V1beta3::ReviewDocumentRequest, ::Google::Longrunning::Operation
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
