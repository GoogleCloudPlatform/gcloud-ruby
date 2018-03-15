# Copyright 2017 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# AUTO GENERATED BY GAPIC

require "minitest/autorun"
require "minitest/spec"

require "google/cloud/dlp"

describe "DlpServiceSmokeTest" do
  it "runs one smoke test with inspect_content" do

    dlp_service_client = Google::Cloud::Dlp.new version: :v2beta1
    min_likelihood = :POSSIBLE
    inspect_config = { min_likelihood: min_likelihood }
    type = "text/plain"
    value = "my phone number is 215-512-1212"
    items_element = { type: type, value: value }
    items = [items_element]
    response = dlp_service_client.inspect_content(inspect_config, items)
  end
end
