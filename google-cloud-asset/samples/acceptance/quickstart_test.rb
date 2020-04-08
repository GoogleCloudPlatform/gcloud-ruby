# Copyright 2020 Google, LLC
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

require "google/cloud/pubsub"

require_relative "helper.rb"
require_relative "../quickstart"

describe "Asset Quickstart" do
  parallelize_me!

  let(:dump_file_name) { "ruby-assets-samples-test.txt" }
  let(:feed_id)        { "ruby_asset_samples_#{SecureRandom.hex}" }
  let :project_id do
    Google::Cloud::Storage.new.project
  end
  let :bucket do
    create_bucket_helper "ruby_asset_sample_#{SecureRandom.hex}"
  end
  let :dump_file_path do
    "gs://#{bucket.name}/#{dump_file_name}"
  end
  let :pubsub do
    require "google/cloud/pubsub"

    Google::Cloud::Pubsub.new
  end
  let :topic do
    topic = pubsub.create_topic "ruby_asset_samples_#{SecureRandom.hex}"
    topic
  end
  let :asset_names do
    asset_name_list = ["//storage.googleapis.com/#{bucket.name}"]
    # ensure read_time_window is after bucket creation
    sleep 3
    asset_name_list
  end

  after do
    delete_bucket_helper bucket.name
  end

  describe "export_assets" do
    it "exports assets to a cloud storage file" do
      assert_nil bucket.file(dump_file_name)
      out, _err = capture_io do
        export_assets project_id: project_id, dump_file_path: dump_file_path
      end
      match = out.match(/Exported assets to: (.*)\n/)
      assert_equal match[1], dump_file_path
      refute_nil bucket.file(dump_file_name)
    end
  end

  describe "batch_get_history" do
    it "puts asset history" do
      out, _err = capture_io do
        batch_get_history project_id: project_id, asset_names: asset_names
      end
      assert out.size.positive?
    end
  end

  describe "create_feed" do
    after do
      topic.delete
    end
    it "creates a feed for a set of assets" do
      asset_names = ["//storage.googleapis.com/#{bucket.name}"]
      out, _err = capture_io do
        create_feed(
          project_id:   project_id,
          feed_id:      feed_id,
          pubsub_topic: topic.name,
          asset_names:  asset_names
        )
      end
      asset_service = Google::Cloud::Asset.asset_service
      match = out.match(/Created feed: (.*)\n/)
      assert match
      asset_service.get_feed name: match[1]
      asset_service.delete_feed name: match[1]
    end
  end
end
