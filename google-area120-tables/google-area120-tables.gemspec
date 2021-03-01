# -*- ruby -*-
# encoding: utf-8

require File.expand_path("lib/google/area120/tables/version", __dir__)

Gem::Specification.new do |gem|
  gem.name          = "google-area120-tables"
  gem.version       = Google::Area120::Tables::VERSION

  gem.authors       = ["Google LLC"]
  gem.email         = "googleapis-packages@google.com"
  gem.description   = "Using the Area 120 Tables API, you can query for tables, and update/create/delete rows within tables programmatically."
  gem.summary       = "API Client library for the Area 120 Tables API"
  gem.homepage      = "https://github.com/googleapis/google-cloud-ruby"
  gem.license       = "Apache-2.0"

  gem.platform      = Gem::Platform::RUBY

  gem.files         = `git ls-files -- lib/*`.split("\n") +
                      ["README.md", "AUTHENTICATION.md", "LICENSE.md", ".yardopts"]
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 2.4"

  gem.add_dependency "google-area120-tables-v1alpha1", "~> 0.0"
  gem.add_dependency "google-cloud-core", "~> 1.5"

  gem.add_development_dependency "google-style", "~> 1.24.0"
  gem.add_development_dependency "minitest", "~> 5.14"
  gem.add_development_dependency "minitest-focus", "~> 1.1"
  gem.add_development_dependency "minitest-rg", "~> 5.2"
  gem.add_development_dependency "rake", ">= 12.0"
  gem.add_development_dependency "redcarpet", "~> 3.0"
  gem.add_development_dependency "simplecov", "~> 0.9"
  gem.add_development_dependency "yard", "~> 0.9"
end
