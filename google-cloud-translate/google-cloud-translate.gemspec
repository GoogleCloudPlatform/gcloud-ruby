require File.expand_path("lib/google/cloud/translate/version", __dir__)

Gem::Specification.new do |gem|
  gem.name          = "google-cloud-translate"
  gem.version       = Google::Cloud::Translate::VERSION

  gem.authors       = ["Google LLC"]
  gem.email         = "googleapis-packages@google.com"
  gem.description   = "google-cloud-translate is the official library for Cloud Translation API."
  gem.summary       = "API Client library for Cloud Translation API"
  gem.homepage      = "https://github.com/googleapis/google-cloud-ruby/tree/master/google-cloud-translate"
  gem.license       = "Apache-2.0"

  gem.platform      = Gem::Platform::RUBY

  gem.files         = `git ls-files -- lib/*`.split("\n") +
                      ["OVERVIEW.md", "AUTHENTICATION.md", "CONTRIBUTING.md", "TROUBLESHOOTING.md", "CHANGELOG.md",
                       "CODE_OF_CONDUCT.md", "LICENSE", ".yardopts"]
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 2.4"

  gem.add_dependency "faraday", "~> 0.13"
  gem.add_dependency "google-cloud-core", "~> 1.2"
  gem.add_dependency "google-gax", "~> 1.7"

  gem.add_development_dependency "autotest-suffix", "~> 1.1"
  gem.add_development_dependency "google-style", "~> 1.24.0"
  gem.add_development_dependency "minitest", "~> 5.10"
  gem.add_development_dependency "minitest-autotest", "~> 1.0"
  gem.add_development_dependency "minitest-focus", "~> 1.1"
  gem.add_development_dependency "minitest-rg", "~> 5.2"
  gem.add_development_dependency "redcarpet", "~> 3.0"
  gem.add_development_dependency "simplecov", "~> 0.9"
  gem.add_development_dependency "yard", "~> 0.9"
  gem.add_development_dependency "yard-doctest", "~> 0.1.13"
end
