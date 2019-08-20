# Release History
### 0.3.0 / 2019-08-20

#### Bug Fixes

* Update #to_hash to #to_h to fix for protobuf 3.9.0

#### Features

* Update documentation

### 0.2.0 / 2019-07-08

* Support overriding service host and port.
* VulnerabilityNote::Detail changes:
    * BREAKING CHANGE: Remove min_affected_version
    * Add affected_version_start
    * Add affected_version_end
* VulnerabilityOccurrence::PackageIssue changes:
    * Remove min_affected_version
    * Add affected_version

### 0.1.0 / 2019-06-21

* Initial release.
