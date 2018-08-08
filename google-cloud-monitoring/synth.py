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

v3_library = gapic.ruby_library(
    'monitoring', 'v3',
    config_path='/google/monitoring/artman_monitoring.yaml',
    artman_output_name='google-cloud-ruby/google-cloud-monitoring'
)
s.copy(v3_library / 'acceptance')
s.copy(v3_library / 'lib')
s.copy(v3_library / 'test')
s.copy(v3_library / 'README.md')
s.copy(v3_library / 'LICENSE')
s.copy(v3_library / '.gitignore')
s.copy(v3_library / '.rubocop.yml')
s.copy(v3_library / '.yardopts')
s.copy(v3_library / 'google-cloud-monitoring.gemspec', merge=merge_gemspec)

# PERMANENT: Because lib/google-cloud-monitoring.rb is present and handwritten.
s.replace(
    '.rubocop.yml',
    '\\Z',
    '\nNaming/FileName:\n  Exclude:\n    - "lib/google-cloud-monitoring.rb"\n')

# PERMANENT: Use a compatible version of googleapis-common-protos-types
s.replace(
    'google-cloud-monitoring.gemspec',
    '\n  gem\\.add_dependency "google-gax", "~> ([\\d\\.]+)"',
    '\n  gem.add_dependency "google-gax", "~> \\1"\n  gem.add_dependency "googleapis-common-protos-types", ">= 1.0.2"')

# https://github.com/googleapis/gapic-generator/issues/2174
s.replace(
    'lib/google/cloud/monitoring.rb',
    'File\.join\(dir, "\.rb"\)',
    'dir + ".rb"')

# https://github.com/googleapis/gapic-generator/issues/2182
s.replace(
    'lib/google/cloud/monitoring/v3/credentials.rb',
    'MONITORING_KEYFILE\\n(\s+)MONITORING_CREDENTIALS\n',
    'MONITORING_CREDENTIALS\\n\\1MONITORING_KEYFILE\n')
s.replace(
    'lib/google/cloud/monitoring/v3/credentials.rb',
    'MONITORING_KEYFILE_JSON\\n(\s+)MONITORING_CREDENTIALS_JSON\n',
    'MONITORING_CREDENTIALS_JSON\\n\\1MONITORING_KEYFILE_JSON\n')

# https://github.com/googleapis/gapic-generator/issues/2195
s.replace(
    [
      'README.md',
      'lib/google/cloud/monitoring.rb',
      'lib/google/cloud/monitoring/v3.rb',
      'lib/google/cloud/monitoring/v3/doc/overview.rb'
    ],
    '\\(https://console\\.cloud\\.google\\.com/apis/api/monitoring\\)',
    '(https://console.cloud.google.com/apis/library/monitoring.googleapis.com)')

# https://github.com/googleapis/gapic-generator/issues/2194
s.replace(
    '.yardopts',
    '\n--markup markdown\n',
    '\n--markup markdown\n--markup-provider redcarpet\n')

# https://github.com/googleapis/gapic-generator/issues/2194
s.replace(
    'google-cloud-monitoring.gemspec',
    '\n  gem\\.add_development_dependency "minitest", "~> ([\\d\\.]+)"\n  gem\\.add_development_dependency "rubocop"',
    '\n  gem.add_development_dependency "minitest", "~> \\1"\n  gem.add_development_dependency "redcarpet", "~> 3.0"\n  gem.add_development_dependency "rubocop"')
s.replace(
    'google-cloud-monitoring.gemspec',
    '\n  gem\\.add_development_dependency "simplecov", "~> ([\\d\\.]+)"\nend',
    '\n  gem.add_development_dependency "simplecov", "~> \\1"\n  gem.add_development_dependency "yard", "~> 0.9"\nend')
