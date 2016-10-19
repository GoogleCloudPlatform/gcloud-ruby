# Copyright 2016 Google Inc. All rights reserved.
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

require "storage_helper"
require "net/http"
require "digest/sha2"

describe Google::Cloud::Storage::File, :storage do
  let :bucket do
    storage.bucket(bucket_name) ||
    storage.create_bucket(bucket_name)
  end
  let(:bucket_name) { $bucket_names.first }

  let(:files) do
    { logo: { path: "acceptance/data/CloudPlatform_128px_Retina.png" },
      big:  { path: "acceptance/data/three-mb-file.tif" } }
  end

  let(:encryption_key) do
    cipher = OpenSSL::Cipher.new "aes-256-cfb"
    cipher.encrypt
    cipher.random_key
  end
  let(:encryption_key_sha256) { Digest::SHA256.digest encryption_key }

  before do
    # always create the bucket
    bucket
  end

  after do
    bucket.files.all { |f| f.delete rescue nil }
  end

  it "should upload and download a file" do
    original = File.new files[:logo][:path]
    uploaded = bucket.create_file original, "CloudLogo.png",
      cache_control: "public, max-age=3600",
      content_disposition: "attachment; filename=filename.ext",
      content_language: "en",
      content_type: "text/plain",
      metadata: { player: "Alice", score: 101 }

    Tempfile.open ["google-cloud", ".png"] do |tmpfile|
      tmpfile.binmode
      downloaded = uploaded.download tmpfile

      downloaded.size.must_equal original.size
      downloaded.size.must_equal uploaded.size
      downloaded.size.must_equal tmpfile.size # Same file

      File.read(downloaded.path, mode: "rb").must_equal File.read(original.path, mode: "rb")
    end

    uploaded.created_at.must_be_kind_of DateTime
    uploaded.api_url.must_be_kind_of String
    uploaded.media_url.must_be_kind_of String
    uploaded.public_url.must_be_kind_of String
    uploaded.url.must_be_kind_of String

    uploaded.md5.must_be_kind_of String
    uploaded.crc32c.must_be_kind_of String
    uploaded.etag.must_be_kind_of String

    uploaded.cache_control.must_equal "public, max-age=3600"
    uploaded.content_disposition.must_equal "attachment; filename=filename.ext"
    uploaded.content_encoding.must_be :nil?
    uploaded.content_language.must_equal "en"
    uploaded.content_type.must_equal "text/plain"

    uploaded.metadata.must_be_kind_of Hash
    uploaded.metadata.size.must_equal 2
    uploaded.metadata.frozen?.must_equal true
    uploaded.metadata["player"].must_equal "Alice"
    uploaded.metadata["score"].must_equal "101"

    uploaded.delete
  end

  it "should upload and download a larger file" do
    original = File.new files[:big][:path]
    uploaded = bucket.create_file original, "BigLogo.png"
    Tempfile.open ["google-cloud", ".png"] do |tmpfile|
      tmpfile.binmode
      downloaded = uploaded.download tmpfile, verify: :all

      downloaded.size.must_equal original.size
      downloaded.size.must_equal uploaded.size
      downloaded.size.must_equal tmpfile.size # Same file

      File.read(downloaded.path, mode: "rb").must_equal File.read(original.path, mode: "rb")
    end
    uploaded.delete
  end

  it "creates and gets and updates and deletes a file" do
    bucket.file("CRUDLogo").must_be :nil?

    original = File.new files[:logo][:path]
    uploaded = bucket.create_file original, "CRUDLogo.png"

    bucket.file("CRUDLogo.png").wont_be :nil?

    uploaded.created_at.must_be_kind_of DateTime
    uploaded.api_url.must_be_kind_of String
    uploaded.media_url.must_be_kind_of String
    uploaded.public_url.must_be_kind_of String
    uploaded.url.must_be_kind_of String

    uploaded.md5.must_be_kind_of String
    uploaded.crc32c.must_be_kind_of String
    uploaded.etag.must_be_kind_of String

    uploaded.cache_control.must_be :nil?
    uploaded.content_disposition.must_be :nil?
    uploaded.content_encoding.must_be :nil?
    uploaded.content_language.must_be :nil?
    uploaded.content_type.must_equal "image/png"

    uploaded.metadata.must_be_kind_of Hash
    uploaded.metadata.must_be :empty?

    uploaded.update do |f|
      f.cache_control = "private, max-age=0, no-cache"
      f.content_disposition = "attachment; filename=filename.ext"
      f.content_language = "en"
      f.content_type = "text/plain"
      f.metadata = { player: "Alice" }
      f.metadata[:score] = 101
    end

    uploaded.created_at.must_be_kind_of DateTime
    uploaded.api_url.must_be_kind_of String
    uploaded.media_url.must_be_kind_of String
    uploaded.public_url.must_be_kind_of String
    uploaded.url.must_be_kind_of String

    uploaded.md5.must_be_kind_of String
    uploaded.crc32c.must_be_kind_of String
    uploaded.etag.must_be_kind_of String

    uploaded.cache_control.must_equal "private, max-age=0, no-cache"
    uploaded.content_disposition.must_equal "attachment; filename=filename.ext"
    uploaded.content_encoding.must_be :nil?
    uploaded.content_language.must_equal "en"
    uploaded.content_type.must_equal "text/plain"

    uploaded.metadata.must_be_kind_of Hash
    uploaded.metadata.size.must_equal 2
    uploaded.metadata.frozen?.must_equal true
    uploaded.metadata["player"].must_equal "Alice"
    uploaded.metadata["score"].must_equal "101"

    uploaded.reload!

    uploaded.created_at.must_be_kind_of DateTime
    uploaded.api_url.must_be_kind_of String
    uploaded.media_url.must_be_kind_of String
    uploaded.public_url.must_be_kind_of String
    uploaded.url.must_be_kind_of String

    uploaded.md5.must_be_kind_of String
    uploaded.crc32c.must_be_kind_of String
    uploaded.etag.must_be_kind_of String

    uploaded.cache_control.must_equal "private, max-age=0, no-cache"
    uploaded.content_disposition.must_equal "attachment; filename=filename.ext"
    uploaded.content_encoding.must_be :nil?
    uploaded.content_language.must_equal "en"
    uploaded.content_type.must_equal "text/plain"

    uploaded.metadata.must_be_kind_of Hash
    uploaded.metadata.size.must_equal 2
    uploaded.metadata.frozen?.must_equal true
    uploaded.metadata["player"].must_equal "Alice"
    uploaded.metadata["score"].must_equal "101"

    bucket.file("CRUDLogo.png").wont_be :nil?

    uploaded.delete

    bucket.file("CRUDLogo.png").must_be :nil?
  end

  it "should upload and download a file without specifying path" do
    original = File.new files[:logo][:path]
    uploaded = bucket.create_file original
    uploaded.name.must_equal original.path

    Tempfile.open ["google-cloud", ".png"] do |tmpfile|
      tmpfile.binmode
      downloaded = uploaded.download tmpfile

      downloaded.size.must_equal original.size
      downloaded.size.must_equal uploaded.size
      downloaded.size.must_equal tmpfile.size # Same file

      File.read(downloaded.path, mode: "rb").must_equal File.read(original.path, mode: "rb")
    end

    uploaded.delete
  end

  it "should upload and download a file with customer-supplied encryption key" do
    original = File.new files[:logo][:path], "rb"
    uploaded = bucket.create_file original, "CloudLogo.png", encryption_key: encryption_key, encryption_key_sha256: encryption_key_sha256

    Tempfile.open ["CloudLogo", ".png"] do |tmpfile|
      downloaded = uploaded.download tmpfile.path, encryption_key: encryption_key

      downloaded.size.must_equal original.size
      downloaded.size.must_equal uploaded.size
      downloaded.size.must_equal original.size # Same file

      File.read(downloaded.path, mode: "rb").must_equal File.read(original.path, mode: "rb")
    end

    uploaded.delete
  end

  it "should write metadata" do
    meta = { content_type: "x-image/x-png",
             metadata: { title: "Logo Image" } }
    uploaded = bucket.create_file files[:logo][:path],
                                  "CloudLogo",
                                  meta

    uploaded.content_type.must_equal meta[:content_type]
    uploaded.metadata["title"].must_equal meta[:metadata][:title]
  end

  it "should copy an existing file" do
    uploaded = bucket.create_file files[:logo][:path], "CloudLogo"
    copied = try_with_backoff "copying existing file" do
      uploaded.copy "CloudLogoCopy"
    end

    uploaded.name.must_equal "CloudLogo"
    copied.name.must_equal "CloudLogoCopy"
    copied.size.must_equal uploaded.size

    Tempfile.open ["CloudLogo", ".png"] do |tmpfile1|
      tmpfile1.binmode
      Tempfile.open ["CloudLogoCopy", ".png"] do |tmpfile2|
        tmpfile2.binmode
        downloaded1 = uploaded.download tmpfile1
        downloaded2 = copied.download tmpfile2
        downloaded1.size.must_equal downloaded2.size

        File.read(downloaded1.path, mode: "rb").must_equal File.read(downloaded2.path, mode: "rb")
      end
    end

    uploaded.delete
    copied.delete
  end

  it "should copy an existing file with customer-supplied encryption key" do
    uploaded = bucket.create_file files[:logo][:path], "CloudLogo.png", encryption_key: encryption_key
    copied = try_with_backoff "copying existing file with encryption key" do
      uploaded.copy "CloudLogoCopy.png", encryption_key: encryption_key, encryption_key_sha256: encryption_key_sha256
    end
    uploaded.name.must_equal "CloudLogo.png"
    copied.name.must_equal "CloudLogoCopy.png"
    copied.size.must_equal uploaded.size

    Tempfile.open ["CloudLogo", ".png"] do |tmpfile1|
      Tempfile.open ["CloudLogoCopy", ".png"] do |tmpfile2|
        downloaded1 = uploaded.download tmpfile1.path, encryption_key: encryption_key, encryption_key_sha256: encryption_key_sha256
        downloaded2 = copied.download tmpfile2.path, encryption_key: encryption_key
        downloaded1.size.must_equal downloaded2.size

        File.read(downloaded1.path, mode: "rb").must_equal File.read(downloaded2.path, mode: "rb")
      end
    end

    uploaded.delete
    copied.delete
  end

  it "does not error when getting a file that does not exist" do
    file = bucket.file "this/file/does/not/exist.png"
    file.must_be :nil?
  end

  it "file should create a signed read url" do
    local_file = File.new files[:logo][:path]
    file = bucket.create_file local_file, "CloudLogoSignedUrlGetFile.png"

    five_min_from_now = 5 * 60
    url = file.signed_url method: "GET",
                          expires: five_min_from_now

    uri = URI url
    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    http.ca_file ||= ENV["SSL_CERT_FILE"] if ENV["SSL_CERT_FILE"]
    resp = http.get uri.request_uri
    Tempfile.open ["google-cloud", ".png"] do |tmpfile|
      tmpfile.binmode
      tmpfile.write resp.body
      tmpfile.size.must_equal local_file.size

      File.read(local_file.path, mode: "rb").must_equal File.read(tmpfile.path, mode: "rb")
    end
  end

  it "bucket should create a signed read url" do
    local_file = File.new files[:logo][:path]
    file = bucket.create_file local_file, "CloudLogoSignedUrlGetBucket.png"

    five_min_from_now = 5 * 60
    url = bucket.signed_url file.name, method: "GET",
                                       expires: five_min_from_now

    uri = URI url
    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    http.ca_file ||= ENV["SSL_CERT_FILE"] if ENV["SSL_CERT_FILE"]
    resp = http.get uri.request_uri
    Tempfile.open ["google-cloud", ".png"] do |tmpfile|
      tmpfile.binmode
      tmpfile.write resp.body
      tmpfile.size.must_equal local_file.size

      File.read(local_file.path, mode: "rb").must_equal File.read(tmpfile.path, mode: "rb")
    end
  end

  it "should create a signed delete url" do
    file = bucket.create_file files[:logo][:path], "CloudLogoSignedUrlDelete.png"

    five_min_from_now = 5 * 60
    url = file.signed_url method: "DELETE",
                          expires: five_min_from_now

    uri = URI url
    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    http.ca_file ||= ENV["SSL_CERT_FILE"] if ENV["SSL_CERT_FILE"]
    resp = http.delete uri.request_uri

    resp.code.must_equal "204"
  end
end
