# Copyright 2020 Google LLC
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

def enable_bucket_lifecycle_management bucket_name:
  # [START storage_enable_bucket_lifecycle_management]
  # Enable lifecycle management for a bucket
  # bucket_name = "Your Google Cloud Storage bucket name"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new
  bucket = storage.bucket bucket_name

  rules = bucket.lifecycle do |l|
    l.add_delete_rule age: 2
  end

  puts "Lifecycle management is enabled for bucket #{bucket_name} and the rules are #{rules}"
  # [END storage_enable_bucket_lifecycle_management]
  bucket
end

enable_bucket_lifecycle_management bucket_name: ARGV.shift if $PROGRAM_NAME == __FILE__
