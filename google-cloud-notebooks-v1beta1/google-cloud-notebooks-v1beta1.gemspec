# -*- ruby -*-
# encoding: utf-8

require File.expand_path("lib/google/cloud/notebooks/v1beta1/version", __dir__)

Gem::Specification.new do |gem|
  gem.name          = "google-cloud-notebooks-v1beta1"
  gem.version       = Google::Cloud::Notebooks::V1beta1::VERSION

  gem.authors       = ["Google LLC"]
  gem.email         = "googleapis-packages@google.com"
  gem.description   = "AI Platform Notebooks makes it easy to manage JupyterLab instances through a protected, publicly available notebook instance URL. A JupyterLab instance is a Deep Learning virtual machine instance with the latest machine learning and data science libraries pre-installed. Note that google-cloud-notebooks-v1beta1 is a version-specific client library. For most uses, we recommend installing the main client library google-cloud-notebooks instead. See the readme for more details."
  gem.summary       = "API Client library for the AI Platform Notebooks V1beta1 API"
  gem.homepage      = "https://github.com/googleapis/google-cloud-ruby"
  gem.license       = "Apache-2.0"

  gem.platform      = Gem::Platform::RUBY

  gem.files         = `git ls-files -- lib/*`.split("\n") +
                      `git ls-files -- proto_docs/*`.split("\n") +
                      ["README.md", "LICENSE.md", "AUTHENTICATION.md", ".yardopts"]
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 2.5"

  gem.add_dependency "gapic-common", "~> 0.4"
  gem.add_dependency "google-cloud-errors", "~> 1.0"

  gem.add_development_dependency "google-style", "~> 1.25.1"
  gem.add_development_dependency "minitest", "~> 5.14"
  gem.add_development_dependency "minitest-focus", "~> 1.1"
  gem.add_development_dependency "minitest-rg", "~> 5.2"
  gem.add_development_dependency "rake", ">= 12.0"
  gem.add_development_dependency "redcarpet", "~> 3.0"
  gem.add_development_dependency "simplecov", "~> 0.18"
  gem.add_development_dependency "yard", "~> 0.9"
end
