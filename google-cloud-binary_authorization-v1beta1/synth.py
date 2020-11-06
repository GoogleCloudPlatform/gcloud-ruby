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

"""This script is used to synthesize generated parts of this library."""

import synthtool as s
import synthtool.gcp as gcp
import synthtool.languages.ruby as ruby
import logging


logging.basicConfig(level=logging.DEBUG)

gapic = gcp.GAPICMicrogenerator()
library = gapic.ruby_library(
    "binaryauthorization", "v1beta1",
    extra_proto_files=["google/cloud/common_resources.proto"],
    generator_args={
        "ruby-cloud-gem-name": "google-cloud-binary_authorization-v1beta1",
        "ruby-cloud-title": "Binary Authorization V1beta1",
        "ruby-cloud-description": "Binary Authorization is a service on Google Cloud that provides centralized software supply-chain security for applications that run on Google Kubernetes Engine (GKE) and GKE on-prem.",
        "ruby-cloud-env-prefix": "BINARY_AUTHORIZATION",
        "ruby-cloud-grpc-service-config": "google/cloud/binaryauthorization/v1beta1/binaryauthorization_grpc_service_config.json",
        "ruby-cloud-product-url": "https://cloud.google.com/binary-authorization/",
        "ruby-cloud-api-id": "binaryauthorization.googleapis.com",
        "ruby-cloud-api-shortname": "binaryauthorization",
    }
)

s.copy(library, merge=ruby.global_merge)
