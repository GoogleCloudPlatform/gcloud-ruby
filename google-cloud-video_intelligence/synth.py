# Copyright 2018 Google LLC
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
    "videointelligence", "v1",
    generator_args={
        "ruby-cloud-gem-name": "google-cloud-video_intelligence",
        "ruby-cloud-title": "Cloud Video Intelligence",
        "ruby-cloud-description": "Detects objects, explicit content, and scene changes in videos. It also specifies the region for annotation and transcribes speech to text. Supports both asynchronous API and streaming API.",
        "ruby-cloud-env-prefix": "VIDEO_INTELLIGENCE",
        "ruby-cloud-wrapper-of": "v1:0.0;v1beta2:0.0;v1p1beta1:0.0;v1p2beta1:0.0",
        "ruby-cloud-product-url": "https://cloud.google.com/video-intelligence",
        "ruby-cloud-api-id": "videointelligence.googleapis.com",
        "ruby-cloud-api-shortname": "videointelligence",
        "ruby-cloud-migration-version": "3.0",
    }
)

s.copy(library, merge=ruby.global_merge)
