# Copyright 2019 Google LLC
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
import os
import re

logging.basicConfig(level=logging.DEBUG)

gapic = gcp.GAPICGenerator()

v3_library = gapic.ruby_library(
    'translate', 'v3', artman_output_name='google-cloud-ruby/google-cloud-translate',
    config_path='/google/cloud/translate/artman_translate_v3.yaml'
)

s.copy(v3_library / 'lib/google/cloud/translate/v3.rb')
s.copy(v3_library / 'lib/google/cloud/translate/v3')
s.copy(v3_library / 'test/google/cloud/translate/v3')
s.copy(v3_library / 'LICENSE')
s.copy(v3_library / '.gitignore')

# Update file paths in generated files
s.replace(
    [
        'lib/google/cloud/translate/v3.rb',
        'lib/google/cloud/translate/v3/**/*.rb',
        'test/google/cloud/translate/v3/**/*.rb'
    ],
    'Google::Cloud::Translation',
    'Google::Cloud::Translate'
)
s.replace(
    'lib/google/cloud/translate/v3/doc/**/*.rb',
    'module Translation\n',
    'module Translate\n'
)

# Support for service_address
s.replace(
    [
        'lib/google/cloud/translate/v3.rb',
        'lib/google/cloud/translate/v3/*_client.rb'
    ],
    '\n(\\s+)#(\\s+)@param exception_transformer',
    '\n\\1#\\2@param service_address [String]\n' +
        '\\1#\\2  Override for the service hostname, or `nil` to leave as the default.\n' +
        '\\1#\\2@param service_port [Integer]\n' +
        '\\1#\\2  Override for the service port, or `nil` to leave as the default.\n' +
        '\\1#\\2@param exception_transformer'
)
s.replace(
    [
        'lib/google/cloud/translate/v3.rb',
        'lib/google/cloud/translate/v3/*_client.rb'
    ],
    '\n(\\s+)metadata: nil,\n\\s+exception_transformer: nil,\n',
    '\n\\1metadata: nil,\n\\1service_address: nil,\n\\1service_port: nil,\n\\1exception_transformer: nil,\n'
)
s.replace(
    [
        'lib/google/cloud/translate/v3.rb',
        'lib/google/cloud/translate/v3/*_client.rb'
    ],
    ',\n(\\s+)lib_name: lib_name,\n\\s+lib_version: lib_version',
    ',\n\\1lib_name: lib_name,\n\\1service_address: service_address,\n\\1service_port: service_port,\n\\1lib_version: lib_version'
)
s.replace(
    'lib/google/cloud/translate/v3/*_client.rb',
    'service_path = self\\.class::SERVICE_ADDRESS',
    'service_path = service_address || self.class::SERVICE_ADDRESS'
)
s.replace(
    'lib/google/cloud/translate/v3/*_client.rb',
    'port = self\\.class::DEFAULT_SERVICE_PORT',
    'port = service_port || self.class::DEFAULT_SERVICE_PORT'
)

# Remove legacy release level from documentation
s.replace(
    'lib/google/cloud/**/*.rb',
    '\\s+\\(\\[\\w+\\]\\(https://github\\.com/(googleapis|GoogleCloudPlatform)/google-cloud-ruby#versioning\\)\\)',
    ''
)

# https://github.com/googleapis/gapic-generator/issues/2242
def escape_braces(match):
    expr = re.compile('^([^`]*(`[^`]*`[^`]*)*)([^`#\\$\\\\])\\{([\\w,]+)\\}')
    content = match.group(0)
    while True:
        content, count = expr.subn('\\1\\3\\\\\\\\{\\4}', content)
        if count == 0:
            return content
s.replace(
    [
        'lib/google/cloud/translate/v3.rb',
        'lib/google/cloud/translate/v3/*_client.rb'
    ],
    '\n(\\s+)#[^\n]*[^\n#\\$\\\\]\\{[\\w,]+\\}',
    escape_braces)

# https://github.com/googleapis/gapic-generator/issues/2243
s.replace(
    'lib/google/cloud/translate/v3/*_client.rb',
    '(\n\\s+class \\w+Client\n)(\\s+)(attr_reader :\\w+_stub)',
    '\\1\\2# @private\n\\2\\3')

# https://github.com/googleapis/gapic-generator/issues/2279
s.replace(
    'lib/google/cloud/translate/v3/**/*.rb',
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

# https://github.com/googleapis/google-cloud-ruby/issues/3058
s.replace(
    'lib/google/cloud/translate/v3/*_client.rb',
    '(require \".*credentials\"\n)\n',
    '\\1require "google/cloud/translate/version"\n\n'
)
s.replace(
    'lib/google/cloud/translate/v3/*_client.rb',
    'Gem.loaded_specs\[.*\]\.version\.version',
    'Google::Cloud::Translate::VERSION'
)

# Fix links for devsite migration
for file in ['lib/**/*.rb', '*.md']:
    s.replace(
        file,
        'https://googleapis.github.io/google-cloud-ruby/#/docs/google-cloud-logging/latest/google/cloud/logging/logger',
        'https://googleapis.dev/ruby/google-cloud-logging/latest'
    )
s.replace(
    '*.md',
    'https://googleapis.github.io/google-cloud-ruby/#/docs/.*/authentication',
    'https://googleapis.dev/ruby/google-cloud-translate/latest/file.AUTHENTICATION.html'
)
s.replace(
    'lib/**/*.rb',
    'https://googleapis.github.io/google-cloud-ruby/#/docs/.*/authentication',
    'https://googleapis.dev/ruby/google-cloud-translate/latest/file.AUTHENTICATION.html'
)
s.replace(
    'README.md',
    'github.io/google-cloud-ruby/#/docs/google-cloud-translate/latest/.*$',
    'dev/ruby/google-cloud-translate/latest'
)
