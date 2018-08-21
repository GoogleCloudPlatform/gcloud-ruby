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


v1beta1_library = gapic.ruby_library(
    'asset', 'v1beta1', artman_output_name='google-cloud-ruby/google-cloud-cloudasset',
    config_path='artman_cloudasset_v1beta1.yaml'
)

# Copy everything but Gemfile, .gemspec, and Changelog.md
s.copy(v1beta1_library / 'lib')
s.copy(v1beta1_library / 'test')
s.copy(v1beta1_library / 'Rakefile')
s.copy(v1beta1_library / 'README.md')
s.copy(v1beta1_library / 'LICENSE')
s.copy(v1beta1_library / '.gitignore')
s.copy(v1beta1_library / '.rubocop.yml')
s.copy(v1beta1_library / '.yardopts')
s.copy(v1beta1_library / 'google-cloud-asset.gemspec', merge=merge_gemspec)

# https://github.com/googleapis/gapic-generator/issues/2180
s.replace(
    'google-cloud-asset.gemspec',
    '\n  gem\\.add_dependency "google-gax", "~> ([\\d\\.]+)"\n\n',
    '\n  gem.add_dependency "google-gax", "~> \\1"\n  gem.add_dependency "grpc-google-iam-v1", "~> 0.6.9"\n\n')


# https://github.com/googleapis/gapic-generator/issues/2242
def escape_braces(match):
    expr = re.compile('([^\n#\\$\\\\])\\{([\\w,]+|\\.+)\\}')
    content = match.group(0)
    while True:
        content, count = expr.subn('\\1\\\\\\\\{\\2}', content)
        if count == 0:
            return content


s.replace(
    'lib/google/cloud/asset/v1beta1/**/*.rb',
    '\n(\\s+)#[^\n]*[^\n#\\$\\\\]\\{[\\w,]+\\}',
    escape_braces)


# https://github.com/googleapis/gapic-generator/issues/2232
s.replace(
    'lib/google/cloud/asset/v1beta1/asset_service_client.rb',
    '\n\n(\\s+)class OperationsClient < Google::Longrunning::OperationsClient',
    '\n\n\\1# @private\n\\1class OperationsClient < Google::Longrunning::OperationsClient')
