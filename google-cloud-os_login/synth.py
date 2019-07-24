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


logging.basicConfig(level=logging.DEBUG)

gapic = gcp.GAPICGenerator()

v1_library = gapic.ruby_library(
    'oslogin', 'v1',
    config_path='/google/cloud/oslogin/artman_oslogin_v1.yaml',
    artman_output_name='google-cloud-ruby/google-cloud-os_login'
)
s.copy(v1_library / 'lib/google/cloud/os_login.rb')
s.copy(v1_library / 'lib/google/cloud/os_login/v1')
s.copy(v1_library / 'lib/google/cloud/os_login/v1.rb')
s.copy(v1_library / 'lib/google/cloud/oslogin/v1')
s.copy(v1_library / 'lib/google/cloud/oslogin/common')
s.copy(v1_library / 'test/google/cloud/os_login/v1')
s.copy(v1_library / 'README.md')
s.copy(v1_library / 'LICENSE')
s.copy(v1_library / '.gitignore')
s.copy(v1_library / '.yardopts')
s.copy(v1_library / 'google-cloud-os_login.gemspec', merge=ruby.merge_gemspec)

# Copy common templates
templates = gcp.CommonTemplates().ruby_library()
s.copy(templates)

v1beta_library = gapic.ruby_library(
    'oslogin', 'v1beta',
    config_path='/google/cloud/oslogin/artman_oslogin_v1beta.yaml',
    artman_output_name='google-cloud-ruby/google-cloud-os_login'
)
s.copy(v1beta_library / 'lib/google/cloud/os_login/v1beta')
s.copy(v1beta_library / 'lib/google/cloud/os_login/v1beta.rb')
s.copy(v1beta_library / 'lib/google/cloud/oslogin/v1beta')
s.copy(v1beta_library / 'test/google/cloud/os_login/v1beta')

# PERMANENT: API name for oslogin
s.replace(
    [
      'README.md',
      'lib/google/cloud/os_login.rb',
      'lib/google/cloud/os_login/v1.rb',
      'lib/google/cloud/os_login/v1beta.rb'
    ],
    '/os-login\\.googleapis\\.com', '/oslogin.googleapis.com')

# Support for service_address
s.replace(
    [
        'lib/google/cloud/os_login.rb',
        'lib/google/cloud/os_login/v*.rb',
        'lib/google/cloud/os_login/v*/*_client.rb'
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
        'lib/google/cloud/os_login/v*.rb',
        'lib/google/cloud/os_login/v*/*_client.rb'
    ],
    '\n(\\s+)metadata: nil,\n\\s+exception_transformer: nil,\n',
    '\n\\1metadata: nil,\n\\1service_address: nil,\n\\1service_port: nil,\n\\1exception_transformer: nil,\n'
)
s.replace(
    [
        'lib/google/cloud/os_login/v*.rb',
        'lib/google/cloud/os_login/v*/*_client.rb'
    ],
    ',\n(\\s+)lib_name: lib_name,\n\\s+lib_version: lib_version',
    ',\n\\1lib_name: lib_name,\n\\1service_address: service_address,\n\\1service_port: service_port,\n\\1lib_version: lib_version'
)
s.replace(
    'lib/google/cloud/os_login/v*/*_client.rb',
    'service_path = self\\.class::SERVICE_ADDRESS',
    'service_path = service_address || self.class::SERVICE_ADDRESS'
)
s.replace(
    'lib/google/cloud/os_login/v*/*_client.rb',
    'port = self\\.class::DEFAULT_SERVICE_PORT',
    'port = service_port || self.class::DEFAULT_SERVICE_PORT'
)
s.replace(
    'google-cloud-os_login.gemspec',
    '\n  gem\\.add_dependency "google-gax", "~> 1\\.[\\d\\.]+"\n',
    '\n  gem.add_dependency "google-gax", "~> 1.7"\n')

# https://github.com/googleapis/gapic-generator/issues/2196
s.replace(
    [
      'README.md',
      'lib/google/cloud/os_login.rb',
      'lib/google/cloud/os_login/v1.rb',
      'lib/google/cloud/os_login/v1beta.rb'
    ],
    '\\[Product Documentation\\]: https://cloud\\.google\\.com/os-login\n',
    '[Product Documentation]: https://cloud.google.com/compute/docs/oslogin/rest/\n')

# https://github.com/googleapis/gapic-generator/issues/2242
def escape_braces(match):
    expr = re.compile('^([^`]*(`[^`]*`[^`]*)*)([^`#\\$\\\\])\\{([\\w,]+)\\}')
    content = match.group(0)
    while True:
        content, count = expr.subn('\\1\\3\\\\\\\\{\\4}', content)
        if count == 0:
            return content
s.replace(
    'lib/google/cloud/**/*.rb',
    '\n(\\s+)#[^\n]*[^\n#\\$\\\\]\\{[\\w,]+\\}',
    escape_braces)

# https://github.com/googleapis/gapic-generator/issues/2243
s.replace(
    'lib/google/cloud/os_login/*/*_client.rb',
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
    'google-cloud-os_login.gemspec',
    'gem.add_development_dependency "rubocop".*$',
    'gem.add_development_dependency "rubocop", "~> 0.64.0"'
)

s.replace(
    'google-cloud-os_login.gemspec',
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
    'google-cloud-os_login.gemspec',
    '\nGem::Specification.new do',
    'require File.expand_path("../lib/google/cloud/os_login/version", __FILE__)\n\nGem::Specification.new do'
)
s.replace(
    'google-cloud-os_login.gemspec',
    '(gem.version\s+=\s+).\d+.\d+.\d.*$',
    '\\1Google::Cloud::OsLogin::VERSION'
)
for version in ['v1', 'v1beta']:
    s.replace(
        f'lib/google/cloud/os_login/{version}/*_client.rb',
        f'(require \".*credentials\"\n)\n',
        f'\\1require "google/cloud/os_login/version"\n\n'
    )
    s.replace(
        f'lib/google/cloud/os_login/{version}/*_client.rb',
        'Gem.loaded_specs\[.*\]\.version\.version',
        'Google::Cloud::OsLogin::VERSION'
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
    'https://googleapis.dev/ruby/google-cloud-os_login/latest/file.AUTHENTICATION.html'
)
s.replace(
    'lib/**/*.rb',
    'https://googleapis.github.io/google-cloud-ruby/#/docs/.*/authentication',
    'https://googleapis.dev/ruby/google-cloud-os_login/latest/file.AUTHENTICATION.html'
)
s.replace(
    'README.md',
    'github.io/google-cloud-ruby/#/docs/google-cloud-os_login/latest/.*$',
    'dev/ruby/google-cloud-os_login/latest'
)
