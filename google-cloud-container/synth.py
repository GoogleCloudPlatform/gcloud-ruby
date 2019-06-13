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
import re
from textwrap import dedent

logging.basicConfig(level=logging.DEBUG)

gapic = gcp.GAPICGenerator()

v1beta1_library = gapic.ruby_library(
    'container', 'v1beta1', config_path='/google/container/artman_container_v1beta1.yaml',
    artman_output_name='google-cloud-ruby/google-cloud-container'
)
s.copy(v1beta1_library / 'acceptance/google/cloud/container/v1beta1')
s.copy(v1beta1_library / 'lib/google/cloud/container/v1beta1')
s.copy(v1beta1_library / 'lib/google/container/v1beta1')
s.copy(v1beta1_library / 'lib/google/cloud/container/v1beta1.rb')
s.copy(v1beta1_library / 'test/google/cloud/container/v1beta1')

# Copy common templates
templates = gcp.CommonTemplates().ruby_library()
s.copy(templates)

v1_library = gapic.ruby_library(
    'container', 'v1', config_path='/google/container/artman_container_v1.yaml',
    artman_output_name='google-cloud-ruby/google-cloud-container'
)
s.copy(v1_library / 'acceptance')
s.copy(v1_library / 'lib')
s.copy(v1_library / 'test')
s.copy(v1_library / 'README.md')
s.copy(v1_library / 'LICENSE')
s.copy(v1_library / '.gitignore')
s.copy(v1_library / '.yardopts')
s.copy(v1_library / 'google-cloud-container.gemspec', merge=ruby.merge_gemspec)

# https://github.com/googleapis/gapic-generator/issues/2196
s.replace(
    [
      'README.md',
      'lib/google/cloud/container.rb',
      'lib/google/cloud/container/v1.rb'
    ],
    '\\[Product Documentation\\]: https://cloud\\.google\\.com/container\n',
    '[Product Documentation]: https://cloud.google.com/kubernetes-engine\n')

# https://github.com/googleapis/gapic-generator/issues/2243
s.replace(
    'lib/google/cloud/container/*/*_client.rb',
    '(\n\\s+class \\w+Client\n)(\\s+)(attr_reader :\\w+_stub)',
    '\\1\\2# @private\n\\2\\3')

# https://github.com/googleapis/gapic-generator/issues/2279
s.replace(
    'lib/**/*.rb',
    '\\A(((#[^\n]*)?\n)*# (Copyright \\d+|Generated by the protocol buffer compiler)[^\n]+\n(#[^\n]*\n)*\n)([^\n])',
    '\\1\n\\6')

# https://github.com/googleapis/gapic-generator/issues/2323
s.replace(
    [
        'lib/**/*.rb',
        'README.md'
    ],
    'https://github\\.com/GoogleCloudPlatform/google-cloud-ruby',
    'https://github.com/googleapis/google-cloud-ruby'
)
s.replace(
    [
        'lib/**/*.rb',
        'README.md'
    ],
    'https://googlecloudplatform\\.github\\.io/google-cloud-ruby',
    'https://googleapis.github.io/google-cloud-ruby'
)

# https://github.com/googleapis/gapic-generator/issues/2393
s.replace(
    'google-cloud-container.gemspec',
    'gem.add_development_dependency "rubocop".*$',
    'gem.add_development_dependency "rubocop", "~> 0.64.0"'
)

s.replace(
    'lib/google/container/**/*.rb',
    'require \'google/iam/v1/.*\n',
    ''
)

s.replace(
    'google-cloud-container.gemspec',
    '"README.md", "LICENSE"',
    '"README.md", "AUTHENTICATION.md", "LICENSE"'
)
s.replace(
    '.yardopts',
    'README.md\n',
    'README.md\nAUTHENTICATION.md\nLICENSE\n'
)

# https://github.com/googleapis/google-cloud-ruby/issues/3058
s.replace(
    'google-cloud-container.gemspec',
    '\nGem::Specification.new do',
    'require File.expand_path("../lib/google/cloud/container/version", __FILE__)\n\nGem::Specification.new do'
)
s.replace(
    'google-cloud-container.gemspec',
    '(gem.version\s+=\s+).\d+.\d+.\d.*$',
    '\\1Google::Cloud::Container::VERSION'
)
for version in ['v1', 'v1beta1']:
    s.replace(
        f'lib/google/cloud/container/{version}/cluster_manager_client.rb',
        f'(require \".*credentials\"\n)\n',
        f'\\1require "google/cloud/container/version"\n\n'
    )
    s.replace(
        f'lib/google/cloud/container/{version}/cluster_manager_client.rb',
        'Gem.loaded_specs\[.*\]\.version\.version',
        'Google::Cloud::Container::VERSION'
    )

# Exception tests have to check for both custom errors and retry wrapper errors
for version in ['v1', 'v1beta1']:
    s.replace(
        f'test/google/cloud/container/{version}/*_client_test.rb',
        'err = assert_raises Google::Gax::GaxError do',
        f'err = assert_raises Google::Gax::GaxError, CustomTestError_{version} do'
    )
