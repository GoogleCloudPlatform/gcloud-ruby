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

v2_library = gapic.ruby_library(
    'debugger', 'v2',
    config_path='/google/devtools/artman_clouddebugger.yaml',
    artman_output_name='google-cloud-ruby/google-cloud-debugger'
)
s.copy(v2_library / 'lib/google/cloud/debugger/v2')
s.copy(v2_library / 'lib/google/cloud/debugger/v2.rb')
s.copy(v2_library / 'lib/google/devtools')
s.copy(v2_library / 'test/google/cloud/debugger/v2')

# PERMANENT: Handwritten layer owns Debugger.new so low-level clients need to
# use Debugger::V2.new instead of Debugger.new(version: :v2). Update the
# examples and tests.
s.replace(
    [
      'lib/google/cloud/debugger/v2/controller2_client.rb',
      'lib/google/cloud/debugger/v2/debugger2_client.rb',
      'test/google/cloud/debugger/v2/controller2_client_test.rb',
      'test/google/cloud/debugger/v2/debugger2_client_test.rb'
    ],
    'require "google/cloud/debugger"',
    'require "google/cloud/debugger/v2"')
s.replace(
    [
      'lib/google/cloud/debugger/v2/controller2_client.rb',
      'test/google/cloud/debugger/v2/controller2_client_test.rb'
    ],
    'Google::Cloud::Debugger::Controller2\\.new\\(version: :v2\\)',
    'Google::Cloud::Debugger::V2::Controller2.new')
s.replace(
    [
      'lib/google/cloud/debugger/v2/debugger2_client.rb',
      'test/google/cloud/debugger/v2/debugger2_client_test.rb'
    ],
    'Google::Cloud::Debugger::Debugger2\\.new\\(version: :v2\\)',
    'Google::Cloud::Debugger::V2::Debugger2.new')

# PERMANENT: API name for clouddebugger
s.replace(
    'lib/google/cloud/debugger/v2.rb',
    '/debugger\\.googleapis\\.com', '/clouddebugger.googleapis.com')

# Support for service_address
s.replace(
    [
        'lib/google/cloud/debugger/v*.rb',
        'lib/google/cloud/debugger/v*/*_client.rb'
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
        'lib/google/cloud/debugger/v*.rb',
        'lib/google/cloud/debugger/v*/*_client.rb'
    ],
    '\n(\\s+)metadata: nil,\n\\s+exception_transformer: nil,\n',
    '\n\\1metadata: nil,\n\\1service_address: nil,\n\\1service_port: nil,\n\\1exception_transformer: nil,\n'
)
s.replace(
    [
        'lib/google/cloud/debugger/v*.rb',
        'lib/google/cloud/debugger/v*/*_client.rb'
    ],
    ',\n(\\s+)lib_name: lib_name,\n\\s+lib_version: lib_version',
    ',\n\\1lib_name: lib_name,\n\\1service_address: service_address,\n\\1service_port: service_port,\n\\1lib_version: lib_version'
)
s.replace(
    'lib/google/cloud/debugger/v*/*_client.rb',
    'service_path = self\\.class::SERVICE_ADDRESS',
    'service_path = service_address || self.class::SERVICE_ADDRESS'
)
s.replace(
    'lib/google/cloud/debugger/v*/*_client.rb',
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
    'lib/google/cloud/debugger/v2/**/*.rb',
    '\n(\\s+)#[^\n]*[^\n#\\$\\\\]\\{[\\w,]+\\}',
    escape_braces)

# https://github.com/googleapis/gapic-generator/issues/2243
s.replace(
    'lib/google/cloud/debugger/v2/*_client.rb',
    '(\n\\s+class \\w+Client\n)(\\s+)(attr_reader :\\w+_stub)',
    '\\1\\2# @private\n\\2\\3')

# https://github.com/googleapis/gapic-generator/issues/2279
s.replace(
    'lib/**/*.rb',
    '\\A(((#[^\n]*)?\n)*# (Copyright \\d+|Generated by the protocol buffer compiler)[^\n]+\n(#[^\n]*\n)*\n)([^\n])',
    '\\1\n\\6')

# https://github.com/googleapis/gapic-generator/issues/2323
s.replace(
    'lib/**/*.rb',
    'https://github\\.com/GoogleCloudPlatform/google-cloud-ruby',
    'https://github.com/googleapis/google-cloud-ruby'
)
s.replace(
    'lib/**/*.rb',
    'https://googlecloudplatform\\.github\\.io/google-cloud-ruby',
    'https://googleapis.github.io/google-cloud-ruby'
)

# https://github.com/googleapis/google-cloud-ruby/issues/3058
s.replace(
    'lib/google/cloud/debugger/v2/*_client.rb',
    '(require \".*credentials\"\n)\n',
    '\\1require "google/cloud/debugger/version"\n\n'
)
s.replace(
    'lib/google/cloud/debugger/v2/*_client.rb',
    'Gem.loaded_specs\[.*\]\.version\.version',
    'Google::Cloud::Debugger::VERSION'
)

# Fix links for devsite migration
s.replace(
    'lib/**/*.rb',
    'https://googleapis.github.io/google-cloud-ruby/#/docs/.*/authentication',
    'https://googleapis.dev/ruby/google-cloud-debugger/latest/file.AUTHENTICATION.html'
)
s.replace(
    'lib/**/*.rb',
    'https://googleapis.github.io/google-cloud-ruby/#/docs/google-cloud-logging/latest/google/cloud/logging/logger',
    'https://googleapis.dev/ruby/google-cloud-logging/latest'
)

# We recently added ruby_package proto options, but we want those to apply only
# when we move to the microgenerator. Undo their effect while the monolith is
# still in use.
s.replace(
    'lib/google/devtools/clouddebugger/v2/*_pb.rb',
    '\nmodule Google::Cloud::Debugger::V2\n',
    '\nmodule Google\n  module Devtools\n    module Clouddebugger\n    end\n  end\nend\nmodule Google::Devtools::Clouddebugger::V2\n',
)
