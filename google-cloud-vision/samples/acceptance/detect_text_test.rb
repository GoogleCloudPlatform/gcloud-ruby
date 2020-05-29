# Copyright 2020 Google, Inc
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

require_relative "helper"

require_relative "../detect_text"

describe "Detect Text" do
  it "detect text from local image file" do
    assert_output(/CAUTION\nOtters crossing\nfor next 6 miles\n/) do
      detect_text image_path: image_path("otter_crossing.jpg")
    end
  end

  it "detect text from image file in Google Cloud Storage" do
    assert_output(/CAUTION\nOtters crossing\nfor next 6 miles\n/) do
      detect_text_gcs image_path: gs_url("otter_crossing.jpg")
    end
  end
end
