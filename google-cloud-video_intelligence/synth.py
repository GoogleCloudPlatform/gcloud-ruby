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
import re

logging.basicConfig(level=logging.DEBUG)

gapic = gcp.GAPICGenerator()

v1_library = gapic.ruby_library(
    'videointelligence', 'v1',
    artman_output_name='google-cloud-ruby/google-cloud-video_intelligence'
)
s.copy(v1_library / 'acceptance')
s.copy(v1_library / 'lib/google/cloud/video_intelligence/v1')
s.copy(v1_library / 'lib/google/cloud/video_intelligence/v1.rb')
s.copy(v1_library / 'lib/google/cloud/videointelligence/v1')
s.copy(v1_library / 'test/google/cloud/video_intelligence/v1')

# https://github.com/googleapis/gapic-generator/issues/2182
s.replace(
    'lib/google/cloud/video_intelligence/v1/credentials.rb',
    'VIDEO_INTELLIGENCE_KEYFILE\\n(\s+)VIDEO_INTELLIGENCE_CREDENTIALS\n',
    'VIDEO_INTELLIGENCE_CREDENTIALS\\n\\1VIDEO_INTELLIGENCE_KEYFILE\n')
s.replace(
    'lib/google/cloud/video_intelligence/v1/credentials.rb',
    'VIDEO_INTELLIGENCE_KEYFILE_JSON\\n(\s+)VIDEO_INTELLIGENCE_CREDENTIALS_JSON\n',
    'VIDEO_INTELLIGENCE_CREDENTIALS_JSON\\n\\1VIDEO_INTELLIGENCE_KEYFILE_JSON\n')

# https://github.com/googleapis/gapic-generator/issues/2117
s.replace(
    'test/google/cloud/video_intelligence/v1/video_intelligence_service_client_test.rb',
    'CustomTestError([^_])', 'CustomTestError_v1\\1')
s.replace(
    'test/google/cloud/video_intelligence/v1/video_intelligence_service_client_test.rb',
    'MockGrpcClientStub([^_])', 'MockGrpcClientStub_v1\\1')
s.replace(
    'test/google/cloud/video_intelligence/v1/video_intelligence_service_client_test.rb',
    'MockVideoIntelligenceServiceCredentials([^_])',
    'MockVideoIntelligenceServiceCredentials_v1\\1')

# https://github.com/googleapis/gapic-generator/issues/2185
s.replace(
    'acceptance/google/cloud/video_intelligence/v1/video_intelligence_service_smoke_test.rb',
    'describe "VideoIntelligenceServiceSmokeTest"',
    'describe "VideoIntelligenceServiceSmokeTest V1"')
s.replace(
    'acceptance/google/cloud/video_intelligence/v1/video_intelligence_service_smoke_test.rb',
    'video_intelligence_service_client = Google::Cloud::VideoIntelligence\\.new\n',
    'video_intelligence_service_client = Google::Cloud::VideoIntelligence.new version: :v1\n')

# Copy base module from the v1 library so v1 is the default
s.copy(v1_library / 'lib/google/cloud/video_intelligence.rb')

# https://github.com/googleapis/gapic-generator/issues/2174
s.replace(
    'lib/google/cloud/video_intelligence.rb',
    'File\.join\(dir, "\.rb"\)',
    'dir + ".rb"')

# Copy other base files from v1
s.copy(v1_library / 'README.md')
s.copy(v1_library / 'LICENSE')
s.copy(v1_library / '.gitignore')
s.copy(v1_library / '.rubocop.yml')
s.copy(v1_library / '.yardopts')

# https://github.com/googleapis/gapic-generator/issues/2194
s.replace(
    '.yardopts',
    '\n--markup markdown\n\n',
    '\n--markup markdown\n--markup-provider redcarpet\n\n')

# https://github.com/googleapis/gapic-generator/issues/2195
s.replace(
    'README.md',
    '\\(https://console\\.cloud\\.google\\.com/apis/api/video-intelligence\\)',
    '(https://console.cloud.google.com/apis/library/videointelligence.googleapis.com)')

# Temporary until we get Ruby-specific tools into synthtool
def merge_gemspec(src, dest, path):
    regex = re.compile(r'^\s+gem.version\s*=\s*"[\d\.]+"$', flags=re.MULTILINE)
    match = regex.search(dest)
    if match:
        src = regex.sub(match.group(0), src, count=1)
    regex = re.compile(r'^\s+gem.homepage\s*=\s*"[^"]+"$', flags=re.MULTILINE)
    match = regex.search(dest)
    if match:
        src = regex.sub(match.group(0), src, count=1)
    return src

s.copy(v1_library / 'google-cloud-video_intelligence.gemspec', merge=merge_gemspec)

# https://github.com/googleapis/gapic-generator/issues/2194
s.replace(
    'google-cloud-video_intelligence.gemspec',
    '\n  gem\\.add_development_dependency "minitest", "~> ([\\d\\.]+)"\n  gem\\.add_development_dependency "rubocop"',
    '\n  gem.add_development_dependency "minitest", "~> \\1"\n  gem.add_development_dependency "redcarpet", "~> 3.0"\n  gem.add_development_dependency "rubocop"')
s.replace(
    'google-cloud-video_intelligence.gemspec',
    '\n  gem\\.add_development_dependency "simplecov", "~> ([\\d\\.]+)"\nend',
    '\n  gem.add_development_dependency "simplecov", "~> \\1"\n  gem.add_development_dependency "yard", "~> 0.9"\nend')

v1beta1_library = gapic.ruby_library(
    'videointelligence', 'v1beta1',
    artman_output_name='google-cloud-ruby/google-cloud-video_intelligence'
)
s.copy(v1beta1_library / 'lib/google/cloud/video_intelligence/v1beta1')
s.copy(v1beta1_library / 'lib/google/cloud/video_intelligence/v1beta1.rb')
s.copy(v1beta1_library / 'lib/google/cloud/videointelligence/v1beta1')
s.copy(v1beta1_library / 'test/google/cloud/video_intelligence/v1beta1')

# https://github.com/googleapis/gapic-generator/issues/2182
s.replace(
    'lib/google/cloud/video_intelligence/v1beta1/credentials.rb',
    'VIDEO_INTELLIGENCE_KEYFILE\\n(\s+)VIDEO_INTELLIGENCE_CREDENTIALS\n',
    'VIDEO_INTELLIGENCE_CREDENTIALS\\n\\1VIDEO_INTELLIGENCE_KEYFILE\n')
s.replace(
    'lib/google/cloud/video_intelligence/v1beta1/credentials.rb',
    'VIDEO_INTELLIGENCE_KEYFILE_JSON\\n(\s+)VIDEO_INTELLIGENCE_CREDENTIALS_JSON\n',
    'VIDEO_INTELLIGENCE_CREDENTIALS_JSON\\n\\1VIDEO_INTELLIGENCE_KEYFILE_JSON\n')

# https://github.com/googleapis/gapic-generator/issues/2117
s.replace(
    'test/google/cloud/video_intelligence/v1beta1/video_intelligence_service_client_test.rb',
    'CustomTestError([^_])', 'CustomTestError_v1beta1\\1')
s.replace(
    'test/google/cloud/video_intelligence/v1beta1/video_intelligence_service_client_test.rb',
    'MockGrpcClientStub([^_])', 'MockGrpcClientStub_v1beta1\\1')
s.replace(
    'test/google/cloud/video_intelligence/v1beta1/video_intelligence_service_client_test.rb',
    'MockVideoIntelligenceServiceCredentials([^_])',
    'MockVideoIntelligenceServiceCredentials_v1beta1\\1')

v1beta2_library = gapic.ruby_library(
    'videointelligence', 'v1beta2',
    artman_output_name='google-cloud-ruby/google-cloud-video_intelligence'
)
s.copy(v1beta2_library / 'lib/google/cloud/video_intelligence/v1beta2')
s.copy(v1beta2_library / 'lib/google/cloud/video_intelligence/v1beta2.rb')
s.copy(v1beta2_library / 'lib/google/cloud/videointelligence/v1beta2')
s.copy(v1beta2_library / 'test/google/cloud/video_intelligence/v1beta2')

# https://github.com/googleapis/gapic-generator/issues/2182
s.replace(
    'lib/google/cloud/video_intelligence/v1beta2/credentials.rb',
    'VIDEO_INTELLIGENCE_KEYFILE\\n(\s+)VIDEO_INTELLIGENCE_CREDENTIALS\n',
    'VIDEO_INTELLIGENCE_CREDENTIALS\\n\\1VIDEO_INTELLIGENCE_KEYFILE\n')
s.replace(
    'lib/google/cloud/video_intelligence/v1beta2/credentials.rb',
    'VIDEO_INTELLIGENCE_KEYFILE_JSON\\n(\s+)VIDEO_INTELLIGENCE_CREDENTIALS_JSON\n',
    'VIDEO_INTELLIGENCE_CREDENTIALS_JSON\\n\\1VIDEO_INTELLIGENCE_KEYFILE_JSON\n')

# https://github.com/googleapis/gapic-generator/issues/2117
s.replace(
    'test/google/cloud/video_intelligence/v1beta2/video_intelligence_service_client_test.rb',
    'CustomTestError([^_])', 'CustomTestError_v1beta2\\1')
s.replace(
    'test/google/cloud/video_intelligence/v1beta2/video_intelligence_service_client_test.rb',
    'MockGrpcClientStub([^_])', 'MockGrpcClientStub_v1beta2\\1')
s.replace(
    'test/google/cloud/video_intelligence/v1beta2/video_intelligence_service_client_test.rb',
    'MockVideoIntelligenceServiceCredentials([^_])',
    'MockVideoIntelligenceServiceCredentials_v1beta2\\1')
