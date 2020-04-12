# Copyright 2020 Google LLC
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

require "storage_helper"
require 'net/http'
require 'uri'

describe Google::Cloud::Storage::Bucket, :generate_signed_post_policy_v4, :storage do
  let(:bucket_name) { $bucket_names.first }
  let :bucket do
    storage.bucket(bucket_name) ||
    safe_gcs_execute { storage.create_bucket bucket_name }
  end
  let(:uri) { URI.parse Google::Cloud::Storage::GOOGLEAPIS_URL }
  let(:data_file) { "logo.jpg" }
  let(:data) { File.expand_path("../data/#{data_file}", __dir__) }

  it "generates a signed post object v4 simple" do
    post_object = bucket.generate_signed_post_policy_v4 "test-object", expires: 10

    form_data = [['file', File.open(data)]]

    post_object.fields.each do |key, value|
      form_data.push [key, value]
    end

    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    request = Net::HTTP::Post.new post_object.url
    request.set_form form_data, 'multipart/form-data'

    response = http.request request

    _(response.code).must_equal "204"
    file = bucket.file(post_object.fields["key"])
    _(file).wont_be :nil?
    Tempfile.open ["google-cloud-logo", ".jpg"] do |tmpfile|
      tmpfile.binmode
      downloaded = file.download tmpfile
      _(File.read(downloaded.path, mode: "rb")).must_equal File.read(data, mode: "rb")
    end
  end

  it "generates a signed post object v4 virtual hosted style" do
    post_object = bucket.generate_signed_post_policy_v4 "test-object", expires: 10, virtual_hosted_style: true

    form_data = [['file', File.open(data)]]

    post_object.fields.each do |key, value|
      form_data.push [key, value]
    end

    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    request = Net::HTTP::Post.new post_object.url
    request.set_form form_data, 'multipart/form-data'

    response = http.request request
    _(response.code).must_equal "204"
    file = bucket.file(post_object.fields["key"])
    _(file).wont_be :nil?
    Tempfile.open ["google-cloud-logo", ".jpg"] do |tmpfile|
      tmpfile.binmode
      downloaded = file.download tmpfile
      _(File.read(downloaded.path, mode: "rb")).must_equal File.read(data, mode: "rb")
    end
  end

  it "generates a signed post object v4 with acl and cache-control file headers" do
    fields = {
      "acl" => "public-read",
      "cache-control" => "public,max-age=86400"
    }
    post_object = bucket.generate_signed_post_policy_v4 "test-object", expires: 10, fields: fields

    form_data = [['file', File.open(data)]]

    post_object.fields.each do |key, value|
      form_data.push [key, value]
    end

    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    request = Net::HTTP::Post.new post_object.url
    request.set_form form_data, 'multipart/form-data'

    response = http.request request

    _(response.code).must_equal "204"
    file = bucket.file(post_object.fields["key"])
    _(file).wont_be :nil?
    Tempfile.open ["google-cloud-logo", ".jpg"] do |tmpfile|
      tmpfile.binmode
      downloaded = file.download tmpfile
      _(File.read(downloaded.path, mode: "rb")).must_equal File.read(data, mode: "rb")
    end
  end

  it "generates a signed post object v4 with success_action_status" do
    fields = {
      "success_action_status" => "200"
    }
    post_object = bucket.generate_signed_post_policy_v4 "test-object", expires: 10, fields: fields

    form_data = [['file', File.open(data)]]

    post_object.fields.each do |key, value|
      form_data.push [key, value]
    end

    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    request = Net::HTTP::Post.new post_object.url
    request.set_form form_data, 'multipart/form-data'

    response = http.request request

    _(response.code).must_equal "200"
    file = bucket.file(post_object.fields["key"])
    _(file).wont_be :nil?
    Tempfile.open ["google-cloud-logo", ".jpg"] do |tmpfile|
      tmpfile.binmode
      downloaded = file.download tmpfile
      _(File.read(downloaded.path, mode: "rb")).must_equal File.read(data, mode: "rb")
    end
  end

  def timestamp_to_time timestamp
    ::Time.parse timestamp
  end
end
