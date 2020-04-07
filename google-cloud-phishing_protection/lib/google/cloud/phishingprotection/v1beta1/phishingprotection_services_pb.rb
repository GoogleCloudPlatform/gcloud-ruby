# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/phishingprotection/v1beta1/phishingprotection.proto for package 'Google::Cloud::PhishingProtection::V1beta1'
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
require 'google/cloud/phishingprotection/v1beta1/phishingprotection_pb'

module Google
  module Cloud
    module PhishingProtection
    end
    Phishingprotection = PhishingProtection unless const_defined? :Phishingprotection
  end
end
module Google::Cloud::PhishingProtection::V1beta1
  module PhishingProtection
    # Service to report phishing URIs.
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'google.cloud.phishingprotection.v1beta1.PhishingProtection'

      # Reports a URI suspected of containing phishing content to be reviewed. Once
      # the report review is complete, its result can be found in the Cloud
      # Security Command Center findings dashboard for Phishing Protection. If the
      # result verifies the existence of malicious phishing content, the site will
      # be added the to [Google's Social Engineering
      # lists](https://support.google.com/webmasters/answer/6350487/) in order to
      # protect users that could get exposed to this threat in the future.
      rpc :ReportPhishing, ReportPhishingRequest, ReportPhishingResponse
    end

    Stub = Service.rpc_stub_class
  end
end
