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
    "webrisk", "v1beta1",
    extra_proto_files=["google/cloud/common_resources.proto"],
    generator_args={
        "ruby-cloud-gem-name": "google-cloud-web_risk-v1beta1",
        "ruby-cloud-title": "Web Risk V1beta1",
        "ruby-cloud-description": "Web Risk is an enterprise security product that lets your client applications check URLs against Google's constantly updated lists of unsafe web resources.",
        "ruby-cloud-env-prefix": "WEBRISK",
        "ruby-cloud-grpc-service-config": "google/cloud/webrisk/v1beta1/webrisk_grpc_service_config.json",
        "ruby-cloud-path-override": "web_risk_service_v1_beta1=web_risk_service",
        "ruby-cloud-namespace-override": "WebRiskServiceV1Beta1=WebRiskService",
    }
)

s.copy(library, merge=ruby.global_merge)
