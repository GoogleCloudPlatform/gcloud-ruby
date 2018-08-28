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

v1_library = gapic.ruby_library(
    'bigquery/datatransfer', 'v1',
    artman_output_name='google-cloud-ruby/google-cloud-bigquerydatatransfer',
    config_path='artman_bigquerydatatransfer.yaml'
)
s.copy(v1_library / 'acceptance')
s.copy(v1_library / 'lib')
s.copy(v1_library / 'test')
s.copy(v1_library / 'Rakefile')
s.copy(v1_library / 'README.md')
s.copy(v1_library / 'LICENSE')
s.copy(v1_library / '.gitignore')
s.copy(v1_library / '.rubocop.yml')
s.copy(v1_library / '.yardopts')
s.copy(v1_library / 'google-cloud-bigquery-data_transfer.gemspec', merge=merge_gemspec)

# PERMANENT: Use custom credentials env variable names
s.replace(
    'lib/google/cloud/bigquery/data_transfer/v1/credentials.rb',
    'BIGQUERYDATATRANSFER_KEYFILE', 'DATA_TRANSFER_KEYFILE')
s.replace(
    'lib/google/cloud/bigquery/data_transfer/v1/credentials.rb',
    'BIGQUERYDATATRANSFER_CREDENTIALS', 'DATA_TRANSFER_CREDENTIALS')

# https://github.com/googleapis/gapic-generator/issues/2179
# https://github.com/googleapis/gapic-generator/issues/2196
s.replace(
    [
      'README.md',
      'lib/google/cloud/bigquery/data_transfer.rb',
      'lib/google/cloud/bigquery/data_transfer/v1.rb',
      'lib/google/cloud/bigquery/data_transfer/v1/doc/overview.rb'
    ],
    '\\[Product Documentation\\]: https://cloud\\.google\\.com/bigquerydatatransfer\n',
    '[Product Documentation]: https://cloud.google.com/bigquery/transfer/\n')

# https://github.com/googleapis/gapic-generator/issues/2242
def escape_braces(match):
    expr = re.compile('([^\n#\\$\\\\])\\{([\\w,]+|\\.+)\\}')
    content = match.group(0)
    while True:
        content, count = expr.subn('\\1\\\\\\\\{\\2}', content)
        if count == 0:
            return content
s.replace(
    'lib/google/cloud/**/*.rb',
    '\n(\\s+)#[^\n]*[^\n#\\$\\\\]\\{[\\w,]+\\}',
    escape_braces)

# https://github.com/googleapis/gapic-generator/issues/2243
s.replace(
    'lib/google/cloud/bigquery/data_transfer/*/*_client.rb',
    '(\n\\s+class \\w+Client\n)(\\s+)(attr_reader :\\w+_stub)',
    '\\1\\2# @private\n\\2\\3')
