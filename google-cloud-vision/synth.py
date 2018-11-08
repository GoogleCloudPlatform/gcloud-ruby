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
from textwrap import dedent
from os import listdir
from os.path import isfile, join

logging.basicConfig(level=logging.DEBUG)

gapic = gcp.GAPICGenerator()

v1_library = gapic.ruby_library(
    'vision', 'v1', artman_output_name='google-cloud-ruby/google-cloud-vision'
)

s.copy(v1_library / 'lib')
s.copy(v1_library / 'acceptance')
s.copy(v1_library / 'test')
s.copy(v1_library / 'README.md')
s.copy(v1_library / 'LICENSE')
s.copy(v1_library / '.gitignore')
s.copy(v1_library / '.yardopts')
s.copy(v1_library / 'google-cloud-vision.gemspec', merge=ruby.merge_gemspec)

for version in ['v1p1beta1', 'v1p2beta1', 'v1p3beta1']:
    version_library = gapic.ruby_library(
        'vision', version,
        artman_output_name='google-cloud-ruby/google-cloud-vision'
    )
    s.copy(version_library / f'lib/google/cloud/vision/{version}')
    s.copy(version_library / f'lib/google/cloud/vision/{version}.rb')
    s.copy(version_library / f'acceptance/google/cloud/vision/{version}')
    s.copy(version_library / f'test/google/cloud/vision/{version}')

    # s.replace(
    #     [
    #         f'acceptance/google/cloud/vision/{version}/*.rb',
    #         f'lib/google/cloud/vision/{version}.rb',
    #         f'lib/google/cloud/vision/{version}/*.rb',
    #         f'test/google/cloud/vision/{version}/*.rb'
    #     ],
    #     'Google::Cloud::Vision.new',
    #     'Google::Cloud::Vision::ImageAnnotator.new'
    # )

# PERMANENT: Add migration guide to docs
s.replace(
    'lib/google/cloud/vision.rb',
    '# ### Preview',
    dedent("""\
      # ### Migration Guide
          #
          # The 0.32.0 release introduced breaking changes relative to the previous
          # release, 0.31.0. For more details and instructions to migrate your code,
          # please visit the [migration
          # guide](https://cloud.google.com/vision/docs/ruby-client-migration).
          #
          # ### Preview"""))

# PERMANENT: Add migration guide to readme
s.replace(
    'README.md',
    '### Preview\n',
    dedent("""\
      ### Migration Guide

      The 0.32.0 release introduced breaking changes relative to the previous release,
      0.31.0. For more details and instructions to migrate your code, please visit the
      [migration
      guide](https://cloud.google.com/vision/docs/ruby-client-migration).

      ### Preview\n"""))

# PERMANENT: Add post-install message
s.replace(
    'google-cloud-vision.gemspec',
    'gem.platform(\s+)= Gem::Platform::RUBY',
    dedent("""\
      gem.post_install_message =
          "The 0.32.0 release introduced breaking changes relative to the "\\
          "previous release, 0.31.0. For more details and instructions to migrate "\\
          "your code, please visit the migration guide: "\\
          "https://cloud.google.com/vision/docs/ruby-client-migration."

        gem.platform\\1= Gem::Platform::RUBY"""))

for version in ['v1', 'v1p1beta1', 'v1p2beta1', 'v1p3beta1']:

    # https://github.com/googleapis/gapic-generator/issues/2232
    s.replace(
        [
            f'lib/google/cloud/vision/{version}/image_annotator_client.rb',
            f'lib/google/cloud/vision/{version}/product_search_client.rb'
        ],
        '\n\n(\\s+)class OperationsClient < Google::Longrunning::OperationsClient',
        '\n\n\\1# @private\n\\1class OperationsClient < Google::Longrunning::OperationsClient')

    # https://github.com/googleapis/gapic-generator/issues/2243
    s.replace(
        f'lib/google/cloud/vision/{version}/*_client.rb',
        '(\n\\s+class \\w+Client\n)(\\s+)(attr_reader :\\w+_stub)',
        '\\1\\2# @private\n\\2\\3')

# https://github.com/googleapis/gapic-generator/issues/2279
s.replace(
    'lib/**/*.rb',
    '\\A(((#[^\n]*)?\n)*# (Copyright \\d+|Generated by the protocol buffer compiler)[^\n]+\n(#[^\n]*\n)*\n)([^\n])',
    '\\1\n\\6')

# https://github.com/googleapis/gapic-generator/issues/2323
s.replace(
    ['lib/**/*.rb', 'README.md'],
    'https://github\\.com/GoogleCloudPlatform/google-cloud-ruby',
    'https://github.com/googleapis/google-cloud-ruby'
)
s.replace(
    ['lib/**/*.rb', 'README.md'],
    'https://googlecloudplatform\\.github\\.io/google-cloud-ruby',
    'https://googleapis.github.io/google-cloud-ruby'
)
s.replace(
    'google-cloud-vision.gemspec',
    'gem.add_development_dependency "rubocop".*$',
    'gem.add_development_dependency "rubocop", "~> 0.59.2"'
)
# Adds LICENSE to .yardopts
s.replace(
    '.yardopts',
    'README.md',
    '\n'.join(['README.md', 'LICENSE'])
)
