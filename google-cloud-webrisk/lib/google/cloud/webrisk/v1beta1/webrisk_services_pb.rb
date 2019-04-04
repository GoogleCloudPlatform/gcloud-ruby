# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/webrisk/v1beta1/webrisk.proto for package 'google.cloud.webrisk.v1beta1'
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
require 'google/cloud/webrisk/v1beta1/webrisk_pb'

module Google
  module Cloud
    module Webrisk
      module V1beta1
        module WebRiskServiceV1Beta1
          # Web Risk v1beta1 API defines an interface to detect malicious URLs on your
          # website and in client applications.
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.cloud.webrisk.v1beta1.WebRiskServiceV1Beta1'

            # Gets the most recent threat list diffs.
            rpc :ComputeThreatListDiff, ComputeThreatListDiffRequest, ComputeThreatListDiffResponse
            # This method is used to check whether a URI is on a given threatList.
            rpc :SearchUris, SearchUrisRequest, SearchUrisResponse
            # Gets the full hashes that match the requested hash prefix.
            # This is used after a hash prefix is looked up in a threatList
            # and there is a match. The client side threatList only holds partial hashes
            # so the client must query this method to determine if there is a full
            # hash match of a threat.
            rpc :SearchHashes, SearchHashesRequest, SearchHashesResponse
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
