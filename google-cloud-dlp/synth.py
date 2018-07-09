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
import logging

logging.basicConfig(level=logging.DEBUG)

gapic = gcp.GAPICGenerator()

v2_library = gapic.ruby_library(
    'dlp', 'v2', config_path='/google/privacy/dlp/artman_dlp_v2.yaml', 
    artman_output_name='google-cloud-ruby/google-cloud-dlp'
)

s.copy(v2_library / 'lib/google/cloud/dlp')
s.copy(v2_library / 'lib/google/cloud/privacy')
s.copy(v2_library / 'test')
