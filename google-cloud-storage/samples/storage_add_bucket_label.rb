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

def add_bucket_label bucket_name:, label_key:, label_value:
  # [START storage_add_bucket_label]
  # bucket_name = "Name of your Google Cloud Storage bucket"
  # label_key   = "Cloud Storage bucket Label Key"
  # label_value = "Cloud Storage bucket Label Value"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new
  bucket  = storage.bucket bucket_name

  bucket.update do |bucket|
    bucket.labels[label_key] = label_value
  end

  puts "Added label #{label_key} with value #{label_value} to #{bucket_name}"
  # [END storage_add_bucket_label]
end

if $PROGRAM_NAME == __FILE__
  add_bucket_label bucket_name: ARGV.shift, label_key: ARGV.shift, label_value: ARGV.shift
end
