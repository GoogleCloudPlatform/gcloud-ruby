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

  let(:cipher) do
    cipher = OpenSSL::Cipher.new "aes-256-cfb"
    cipher.encrypt
    cipher
  end

  let(:encryption_key) do
    cipher.random_key
  end

  let(:encryption_key_2) do
    cipher.random_key
  end

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

  it "should upload and delete a file with strange filename" do
    original = File.new files[:logo][:path]
    uploaded = bucket.create_file original, "#{[101, 769].pack("U*")}.png",
      cache_control: "public, max-age=3600",
      content_disposition: "attachment; filename=filename.ext",
      content_language: "en",
      content_type: "text/plain",
      metadata: { player: "Alice", score: 101 }
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
      downloaded.must_be_kind_of File

      downloaded.size.must_equal original.size
      downloaded.size.must_equal uploaded.size
      downloaded.size.must_equal tmpfile.size # Same file

      File.read(downloaded.path, mode: "rb").must_equal File.read(original.path, mode: "rb")
    end

    uploaded.delete
  end

  it "should upload and download a file using IO" do
    skip "The download verification sometimes fails on CI. Not sure why."
    inmemory = StringIO.new(File.read(files[:logo][:path], mode: "rb"))

    uploaded = bucket.create_file inmemory, "uploaded/with/inmemory.png"
    uploaded.name.must_equal "uploaded/with/inmemory.png"

    downloaded = uploaded.download
    downloaded.must_be_kind_of StringIO

    inmemory.rewind
    downloaded.rewind

    downloaded.size.must_equal inmemory.size
    downloaded.size.must_equal uploaded.size

    downloaded.read.must_equal inmemory.read
    downloaded.read.encoding.must_equal inmemory.read.encoding

    uploaded.delete
  end

  it "should upload and download text using IO" do
    inmemory = StringIO.new "Hello world!"
    uploaded = bucket.create_file inmemory, "uploaded/with/inmemory.png"
    uploaded.name.must_equal "uploaded/with/inmemory.png"

    downloadio = StringIO.new()
    downloaded = uploaded.download downloadio
    downloaded.must_be_kind_of StringIO
    downloaded.must_equal downloadio # The object returned is the object provided

    inmemory.rewind
    downloaded.rewind

    downloaded.size.must_equal inmemory.size
    downloaded.size.must_equal uploaded.size

    downloaded.read.must_equal inmemory.read
    downloaded.read.encoding.must_equal inmemory.read.encoding

    uploaded.delete
  end

  it "should upload and download a file with customer-supplied encryption key" do
    original = File.new files[:logo][:path], "rb"
    uploaded = bucket.create_file original, "CloudLogo.png", encryption_key: encryption_key

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

  it "should create and update storage_class" do
    uploaded = bucket.create_file files[:logo][:path], "CloudLogo-storage_class.png", storage_class: :nearline

    uploaded.storage_class.must_equal "NEARLINE"
    uploaded.storage_class = :dra
    uploaded.storage_class.must_equal "DURABLE_REDUCED_AVAILABILITY"

    retrieved1 = bucket.file "CloudLogo-storage_class.png"

    retrieved1.storage_class.must_equal "DURABLE_REDUCED_AVAILABILITY"
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

  it "should copy an existing file, with updates" do
    uploaded = bucket.create_file files[:logo][:path], "CloudLogo",
                                  content_language: "en"
    uploaded.content_language.must_equal "en"

    copied = try_with_backoff "copying existing file" do
      uploaded.copy "CloudLogoCopy" do |copy|
        copy.content_language = "de"
      end
    end
    copied.content_language.must_equal "de"

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
      uploaded.copy "CloudLogoCopy.png", encryption_key: encryption_key
    end
    uploaded.name.must_equal "CloudLogo.png"
    copied.name.must_equal "CloudLogoCopy.png"
    copied.size.must_equal uploaded.size

    Tempfile.open ["CloudLogo", ".png"] do |tmpfile1|
      Tempfile.open ["CloudLogoCopy", ".png"] do |tmpfile2|
        downloaded1 = uploaded.download tmpfile1.path, encryption_key: encryption_key
        downloaded2 = copied.download tmpfile2.path, encryption_key: encryption_key
        downloaded1.size.must_equal downloaded2.size

        File.read(downloaded1.path, mode: "rb").must_equal File.read(downloaded2.path, mode: "rb")
      end
    end

    uploaded.delete
    copied.delete
  end

  it "should add, rotate, and remove customer-supplied encryption keys for an existing file" do
    uploaded = bucket.create_file files[:logo][:path], "CloudLogo.png"

    rewritten = try_with_backoff "add encryption key" do
      uploaded.rotate new_encryption_key: encryption_key
    end
    rewritten.name.must_equal uploaded.name
    rewritten.size.must_equal uploaded.size

    rewritten2 = try_with_backoff "rotate encryption keys" do
      uploaded.rotate encryption_key: encryption_key, new_encryption_key: encryption_key_2
    end
    rewritten2.name.must_equal uploaded.name
    rewritten2.size.must_equal uploaded.size

    Tempfile.open ["CloudLogo", ".png"] do |tmpfile|
      downloaded = uploaded.download tmpfile.path, encryption_key: encryption_key_2
      downloaded.size.must_equal uploaded.size
    end

    rewritten3 = try_with_backoff "remove encryption key" do
      uploaded.rotate encryption_key: encryption_key_2
    end
    rewritten3.name.must_equal uploaded.name
    rewritten3.size.must_equal uploaded.size

    Tempfile.open ["CloudLogo", ".png"] do |tmpfile|
      downloaded = uploaded.download tmpfile.path
      downloaded.size.must_equal uploaded.size
    end

    rewritten3.delete
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
    resp.code.must_equal "200"

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
    resp.code.must_equal "200"

    Tempfile.open ["google-cloud", ".png"] do |tmpfile|
      tmpfile.binmode
      tmpfile.write resp.body
      tmpfile.size.must_equal local_file.size

      File.read(local_file.path, mode: "rb").must_equal File.read(tmpfile.path, mode: "rb")
    end
  end

  it "bucket should create a signed read url with response content type and disposition" do
    local_file = File.new files[:logo][:path]
    file = bucket.create_file local_file, "CloudLogoSignedUrlGetBucket.png"

    five_min_from_now = 5 * 60
    url = bucket.signed_url file.name, method: "GET",
                                       expires: five_min_from_now,
                                       query: { "response-content-type" => "application/octet-stream",
                                                "response-content-disposition" => "attachment; filename=\"google-cloud.png\"" }

    uri = URI url
    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    http.ca_file ||= ENV["SSL_CERT_FILE"] if ENV["SSL_CERT_FILE"]

    resp = http.get uri.request_uri
    resp.code.must_equal "200"
    resp["Content-Type"].must_equal "application/octet-stream"
    resp["Content-Disposition"].must_equal "attachment; filename=\"google-cloud.png\""
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

  it "should create a signed url with public-read acl" do
    local_file = File.new files[:logo][:path]
    file = bucket.create_file local_file, "CloudLogoSignedUrlGetFile.png"

    five_min_from_now = 5 * 60
    url = file.signed_url method: "GET",
                          headers: { "X-Goog-META-Foo" => "bar,baz",
                                     "X-Goog-ACL" => "public-read" }

    uri = URI url
    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    http.ca_file ||= ENV["SSL_CERT_FILE"] if ENV["SSL_CERT_FILE"]

    resp = http.get uri.request_uri, { "X-Goog-meta-foo" => "bar,baz",
                                       "X-Goog-ACL" => "public-read" }
    resp.code.must_equal "200"

    Tempfile.open ["google-cloud", ".png"] do |tmpfile|
      tmpfile.binmode
      tmpfile.write resp.body
      tmpfile.size.must_equal local_file.size

      File.read(local_file.path, mode: "rb").must_equal File.read(tmpfile.path, mode: "rb")
    end
  end
end
