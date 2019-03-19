#!/bin/bash

# This file runs tests for merges, PRs, and nightlies.
# There are a few rules for what tests are run:
#  * PRs run all non-acceptance tests for every library.
#  * Merges run all non-acceptance tests for every library, and acceptance tests for all altered libraries.
#  * Nightlies run all acceptance tests for every library.
#  * Currently only runs tests on 2.5.0

set -eo pipefail

# Debug: show build environment
env | grep KOKORO

cd github/google-cloud-ruby/

# Capture failures
EXIT_STATUS=0 # everything passed
function set_failed_status {
    EXIT_STATUS=1
}

echo "script started"
echo $PATH
source ~/.rvm/scripts/rvm
echo "rvm sourced"
rvm get head --auto-dotfiles
echo "ran rvm auto-dotfiles"

versions=(2.3.8 2.4.5 2.5.5 2.6.2)
echo "set versions"
rvm_versions=$(rvm list rubies)

if [ "$JOB_TYPE" = "presubmit" ]; then
    version=${versions[2]}
    echo "set version to $version"
    echo "recognized presubmit"
    if [[ $rvm_versions == *$version* ]]; then
      echo "found it, gonna use it"
    else
      echo "couldn't find it, gonna install it"
      rvm install $version
    fi
    echo "installed it, gonna use it"
    rvm use $version@global --default
    echo "using it"
    echo $PATH
    which bundler
    which ruby
    gem update --system
    echo "updated system"
    echo $PATH
    which bundler
    which ruby
    (bundle update && bundle exec rake kokoro:presubmit) || set_failed_status
else
    for version in "${versions[@]}"; do
        if [[ $rvm_versions != *$version* ]]; then
            rvm install "$version"
        fi
        rvm use "$version"@global --default
        git fetch --depth=10000
        gem update --system
        ruby --version
        (bundle update && bundle exec rake kokoro:"$JOB_TYPE") || set_failed_status
    done
fi

exit $EXIT_STATUS
