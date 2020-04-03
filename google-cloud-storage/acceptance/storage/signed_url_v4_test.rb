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
require "net/http"
require "uri"
require "zlib"

describe Google::Cloud::Storage, :signed_url, :v4, :storage do
  let :bucket do
    storage.bucket(bucket_name) ||
    safe_gcs_execute { storage.create_bucket(bucket_name) }
  end
  let(:bucket_name) { $bucket_names.first }

  let(:files) do
    { logo: { path: "acceptance/data/CloudPlatform_128px_Retina.png" },
      big:  { path: "acceptance/data/three-mb-file.tif" } }
  end

  let(:bucket_public_test_name) {
    ENV["GCLOUD_TEST_STORAGE_BUCKET"] || "storage-library-test-bucket"
  }
  let(:file_public_test_gzip_name) { "gzipped-text.txt" }  # content is "hello world"

  before do
    # always create the bucket
    bucket
  end

  after do
    bucket.files(versions: true).all { |f| f.delete generation: true rescue nil }
  end

  describe Google::Cloud::Storage::Project, :signed_url do
    it "should create a signed read url version v4" do
      local_file = File.new files[:logo][:path]
      file = bucket.create_file local_file, "CloudLogoSignedUrlGetBucket.png"

      five_min_from_now = 5 * 60
      url = storage.signed_url bucket.name, file.name, method: "GET",
                               expires: five_min_from_now, version: :v4

      uri = URI url
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true
      http.ca_file ||= ENV["SSL_CERT_FILE"] if ENV["SSL_CERT_FILE"]

      resp = http.get uri.request_uri
      resp.code.must_equal "200"

      Tempfile.open ["google-cloud", ".png"] do |tmpfile|
        tmpfile.binmode
        tmpfile.write resp.body
        tmpfile.size.must_equal local_file.size

        File.read(local_file.path, mode: "rb").must_equal File.read(tmpfile.path, mode: "rb")
      end
    end

    it "should create a signed POST url version v4" do
      five_min_from_now = 60 * 60
      url = storage.signed_url bucket.name,
                               "CloudLogoProjectSignedUrlPost.png",
                               method: "POST",
                               expires: five_min_from_now,
                               headers: { "x-goog-resumable" => "start" },
                               version: :v4

      uri = URI url
      https = Net::HTTP.new uri.host,uri.port
      https.use_ssl = true
      req = Net::HTTP::Post.new url, { "X-Goog-Resumable" => "start" }
      resp = https.request(req)

      resp.message.must_equal "Created"
      resp.code.must_equal "201"
    end
  end

  describe Google::Cloud::Storage::Bucket, :signed_url do
    it "should create a signed read url version v4" do
      local_file = File.new files[:logo][:path]
      file = bucket.create_file local_file, "CloudLogoSignedUrlGetBucket.png"
  
      five_min_from_now = 5 * 60
      url = bucket.signed_url file.name, method: "GET",
                              expires: five_min_from_now, version: :v4
  
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true
      http.ca_file ||= ENV["SSL_CERT_FILE"] if ENV["SSL_CERT_FILE"]
  
      resp = http.get uri.request_uri
      resp.code.must_equal "200"
  
      Tempfile.open ["google-cloud", ".png"] do |tmpfile|
        tmpfile.binmode
        tmpfile.write resp.body
        tmpfile.size.must_equal local_file.size
  
        File.read(local_file.path, mode: "rb").must_equal File.read(tmpfile.path, mode: "rb")
      end
    end

    it "should create a signed read url to list objects with version v4" do
      local_file = File.new files[:logo][:path]
      file = bucket.create_file local_file, "CloudLogoSignedUrlGetBucket.png"

      five_min_from_now = 5 * 60
      url = bucket.signed_url method: "GET", expires: five_min_from_now, version: :v4

      uri = URI url
      uri.path.must_equal "/#{bucket_name}"

      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true
      http.ca_file ||= ENV["SSL_CERT_FILE"] if ENV["SSL_CERT_FILE"]

      resp = http.get uri.request_uri
      resp.code.must_equal "200"
      resp.body.must_match "CloudLogoSignedUrlGetBucket.png" # in XML
    end

    it "should create a signed POST url version v4" do
      five_min_from_now = 60 * 60
      url = bucket.signed_url "CloudLogoBucketSignedUrlPost.png",
                              method: "POST",
                              expires: five_min_from_now,
                              headers: { "x-goog-resumable" => "start"},
                              version: :v4

      uri = URI url
      https = Net::HTTP.new uri.host,uri.port
      https.use_ssl = true
      req = Net::HTTP::Post.new url, { "x-goog-resumable" => "start" }
      req.body = "abc123"
      resp = https.request(req)

      resp.message.must_equal "Created"
      resp.code.must_equal "201"
    end
  end

  describe Google::Cloud::Storage::File, :signed_url do
    it "should create a signed read url version v4" do
      local_file = File.new files[:logo][:path]
      file = bucket.create_file local_file, "CloudLogoSignedUrlGetFile.png"
  
      five_min_from_now = 5 * 60
      url = file.signed_url method: "GET",
                            expires: five_min_from_now, version: :v4
  
      uri = URI url
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true
      http.ca_file ||= ENV["SSL_CERT_FILE"] if ENV["SSL_CERT_FILE"]
  
      resp = http.get uri.request_uri
      resp.code.must_equal "200"
  
      Tempfile.open ["google-cloud", ".png"] do |tmpfile|
        tmpfile.binmode
        tmpfile.write resp.body
        tmpfile.size.must_equal local_file.size
  
        File.read(local_file.path, mode: "rb").must_equal File.read(tmpfile.path, mode: "rb")
      end
    end

    it "should create a signed POST url version v4" do
      five_min_from_now = 60 * 60
      file = bucket.file "CloudLogoFileSignedUrlPost.png", skip_lookup: true
      url = file.signed_url method: "POST",
                            expires: five_min_from_now,
                            version: :v4
  
      uri = URI url
      https = Net::HTTP.new uri.host,uri.port
      https.use_ssl = true
      req = Net::HTTP::Post.new url, { "x-goog-resumable" => "start" }
      req.body = "abc123"
      resp = https.request(req)
  
      resp.message.must_equal "Created"
      resp.code.must_equal "201"
    end
  end
end
