# Copyright 2016 Google LLC
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

describe Google::Cloud::Storage::File, :storage do
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

  it "should upload, replace and download a previous generation of a file" do
    bucket.versioning = true unless bucket.versioning?
    filename = "generation_file.txt"
    uploaded_1 = bucket.create_file StringIO.new("generation 1"), filename
    generation_1 = uploaded_1.generation
    uploaded_1.reload!
    uploaded_1.generation.must_equal generation_1

    uploaded_2 = bucket.create_file StringIO.new("generation 2"), filename
    generation_2 = uploaded_2.generation
    generation_2.wont_equal generation_1

    uploaded_1.reload! generation: true
    uploaded_1.generation.must_equal generation_1
    uploaded_2.reload!
    uploaded_2.generation.must_equal generation_2
    uploaded_1.reload!
    uploaded_1.generation.must_equal generation_2

    Tempfile.open ["generation_file", ".txt"] do |tmpfile|
      downloaded = bucket.file(filename).download tmpfile
      File.read(downloaded.path).must_equal "generation 2"
    end

    Tempfile.open ["generation_file", ".txt"] do |tmpfile|
      downloaded =  bucket.file(filename, generation: generation_1).download tmpfile
      File.read(downloaded.path).must_equal "generation 1"
    end

    uploaded_2.delete generation: generation_1
    uploaded_2.delete generation: generation_2
    bucket.versioning = false
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

    generation = uploaded.generation
    generation.must_be_kind_of Integer

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
    uploaded.metageneration.must_equal 1

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
    uploaded.metageneration.must_equal 2

    uploaded.reload!

    uploaded.generation.must_equal generation

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
    inmemory = StringIO.new(File.read(files[:logo][:path], mode: "rb"))

    uploaded = bucket.create_file inmemory, "uploaded/with/inmemory.png"
    uploaded.name.must_equal "uploaded/with/inmemory.png"

    downloaded = uploaded.download
    downloaded.must_be_kind_of StringIO

    inmemory.rewind
    downloaded.size.must_equal inmemory.size
    downloaded.size.must_equal uploaded.size

    downloaded.read.must_equal inmemory.read
    downloaded.read.encoding.must_equal inmemory.read.encoding

    uploaded.delete
  end

  it "should upload and download text using IO" do
    inmemory = StringIO.new "Hello world!"
    uploaded = bucket.create_file inmemory, "uploaded/with/inmemory.txt"
    uploaded.name.must_equal "uploaded/with/inmemory.txt"

    downloadio = StringIO.new()
    downloaded = uploaded.download downloadio
    downloaded.must_be_kind_of StringIO
    downloaded.must_equal downloadio # The object returned is the object provided

    inmemory.rewind
    downloaded.size.must_equal inmemory.size
    downloaded.size.must_equal uploaded.size

    downloaded.read.must_equal inmemory.read
    downloaded.read.encoding.must_equal inmemory.read.encoding

    uploaded.delete
  end

  it "should upload, download, and verify gzip content_type" do
    gz = StringIO.new ""
    z = Zlib::GzipWriter.new gz
    z.write "Hello world!"
    z.close # write the gzip footer
    gzipped = StringIO.new gz.string

    uploaded = bucket.create_file gzipped, "uploaded/with/gzip-type.txt", content_type: "application/gzip"
    uploaded.name.must_equal "uploaded/with/gzip-type.txt"
    uploaded.content_type.must_equal "application/gzip"
    uploaded.content_encoding.must_be_nil
    downloadio = StringIO.new()
    downloaded = uploaded.download downloadio
    downloaded.must_be_kind_of StringIO
    downloaded.must_equal downloadio # The object returned is the object provided
    gzipped.rewind

    downloaded.size.must_equal gzipped.size
    downloaded.size.must_equal uploaded.size

    data = downloaded.read
    data.must_equal gzipped.read
    gzr = Zlib::GzipReader.new StringIO.new(data)
    gzr.read.must_equal "Hello world!"

    uploaded.delete
  end

  it "should upload, download, verify, and decompress when Content-Encoding gzip response header" do
    gz = StringIO.new ""
    z = Zlib::GzipWriter.new gz
    data = "Hello world!"
    z.write data
    z.close # write the gzip footer
    gzipped = StringIO.new gz.string

    uploaded = bucket.create_file gzipped, "uploaded/with/gzip-encoding.txt", content_type: "text/plain", content_encoding: "gzip"
    uploaded.name.must_equal "uploaded/with/gzip-encoding.txt"
    uploaded.content_type.must_equal "text/plain"
    uploaded.content_encoding.must_equal "gzip"

    downloadio = StringIO.new()
    downloaded = uploaded.download downloadio
    downloaded.must_be_kind_of StringIO
    downloaded.wont_equal downloadio # The object returned is NOT the object provided

    downloaded_data = downloaded.read
    downloaded_data.must_equal data
    downloaded_data.encoding.must_equal data.encoding

    uploaded.delete
  end

  it "should download and verify when Content-Encoding gzip response header with skip_decompress" do
    bucket = storage.bucket bucket_public_test_name
    file = bucket.file file_public_test_gzip_name
    file.content_encoding.must_equal "gzip"
    Tempfile.open ["hello_world", ".txt"] do |tmpfile|
      tmpfile.binmode
      downloaded = file.download tmpfile, skip_decompress: true

      data = File.read(downloaded.path, mode: "rb")
      gzr = Zlib::GzipReader.new StringIO.new(data)
      gzr.read.must_equal "hello world"
    end
  end

  it "should download, verify, and decompress when Content-Encoding gzip response header with skip_lookup" do
    bucket = storage.bucket bucket_public_test_name, skip_lookup: true
    file = bucket.file file_public_test_gzip_name, skip_lookup: true
    file.content_encoding.must_be_nil # metadata not loaded
    file.content_type.must_be_nil # metadata not loaded
    Tempfile.open ["hello_world", ".txt"] do |tmpfile|
      tmpfile.binmode
      downloaded = file.download tmpfile

      File.read(downloaded.path, mode: "rb").must_equal "hello world"
    end
  end

  it "should download, verify, and decompress when Content-Encoding gzip response header with crc32c verification" do
    lazy_bucket = storage.bucket bucket_public_test_name
    lazy_file = lazy_bucket.file file_public_test_gzip_name

    Tempfile.open ["hello_world", ".txt"] do |tmpfile|
      tmpfile.binmode
      downloaded = lazy_file.download tmpfile,  verify: :crc32c

      File.read(downloaded.path, mode: "rb").must_equal "hello world" # decompressed file data
    end
  end

  it "should upload and partially download text" do
    inmemory = StringIO.new "Hello world!"
    uploaded = bucket.create_file inmemory, "uploaded/with/inmemory.txt"

    downloaded = uploaded.download range: 3..6
    downloaded.must_be_kind_of StringIO

    downloaded.rewind
    downloaded_partial = downloaded.read

    partial_download_custom_error_msg = lambda do
      download_io = StringIO.new
      uploaded.download download_io, verify: :none
      download_io.rewind
      puts "*"*42
      puts "The full downloaded file contents are: #{download_io.read.inspect}"
      puts "*"*42

      "Another partial download failure - #{"lo w".inspect} != #{downloaded_partial.inspect}"
    end
    assert_equal "lo w", downloaded_partial, partial_download_custom_error_msg

    uploaded.delete
  end

  it "should download a file while skipping lookups" do
    original = File.new files[:logo][:path]
    uploaded = bucket.create_file original, "CloudLogo.png"

    lazy_bucket = storage.bucket bucket_name, skip_lookup: true
    lazy_file = lazy_bucket.file "CloudLogo.png", skip_lookup: true

    lazy_bucket.must_be :lazy?
    lazy_file.must_be :lazy?

    Tempfile.open ["google-cloud", ".png"] do |tmpfile|
      tmpfile.binmode
      downloaded = lazy_file.download tmpfile

      downloaded.size.must_equal original.size
      downloaded.size.must_equal uploaded.size
      downloaded.size.must_equal tmpfile.size # Same file

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

  it "should list generations" do
    uploaded = bucket.create_file files[:logo][:path],
                                  "CloudLogo"

    uploaded.generation.wont_be :nil?
    uploaded.generations.wont_be :nil?
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
    uploaded = bucket.create_file files[:logo][:path], "CloudLogo", acl: "public_read", content_language: "en"
    uploaded.acl.readers.must_include "allUsers" # has "public_read"
    uploaded.content_language.must_equal "en"

    copied = try_with_backoff "copying existing file" do
      uploaded.copy "CloudLogoCopy"
    end

    uploaded.name.must_equal "CloudLogo"
    uploaded.content_language.must_equal "en"
    copied.name.must_equal "CloudLogoCopy"
    copied.acl.readers.wont_include "allUsers" # does NOT have "public_read"
    copied.content_language.must_equal "en"
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
    uploaded = bucket.create_file files[:logo][:path], "CloudLogo", acl: "public_read", content_language: "en", content_type: "image/png"
    uploaded.acl.readers.must_include "allUsers" # has "public_read"
    uploaded.content_language.must_equal "en"
    uploaded.content_type.must_equal "image/png"

    copied = try_with_backoff "copying existing file" do
      uploaded.copy "CloudLogoCopy" do |copy|
        copy.content_language = "de"
      end
    end
    uploaded.content_language.must_equal "en"
    copied.acl.readers.wont_include "allUsers" # does NOT have "public_read"
    copied.content_language.must_equal "de"
    copied.content_type.must_be :nil?

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

  it "should copy an existing file, with force_copy_metadata set to true" do
    uploaded = bucket.create_file files[:logo][:path], "CloudLogo", acl: "public_read", content_language: "en", content_type: "image/png"
    uploaded.acl.readers.must_include "allUsers" # has "public_read"
    uploaded.content_language.must_equal "en"
    uploaded.content_type.must_equal "image/png"
    uploaded.metadata.must_be :empty?

    copied = try_with_backoff "copying existing file" do
      uploaded.copy "CloudLogoCopy", force_copy_metadata: true do |copy|
        copy.content_language = "de"
      end
    end
    uploaded.content_language.must_equal "en"
    copied2 = bucket.file copied.name
    copied2.acl.readers.wont_include "allUsers" # does NOT have "public_read"
    copied.acl.readers.wont_include "allUsers" # does NOT have "public_read"
    copied.content_language.must_equal "de"
    copied.content_type.must_equal "image/png"
    copied.metadata.must_be :empty?

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

  it "should rewrite an existing file, with updates" do
    uploaded = bucket.create_file files[:logo][:path], "CloudLogo.png"
    uploaded.cache_control.must_be :nil?
    uploaded.content_type.must_equal "image/png"

    copied = try_with_backoff "rewriting existing file" do
      uploaded.rewrite "CloudLogoCopy.png" do |f|
        f.cache_control = "public, max-age: 7200"
      end
    end
    uploaded.cache_control.must_be :nil?
    uploaded.content_type.must_equal "image/png"
    copied.cache_control.must_equal "public, max-age: 7200"
    copied.content_type.must_be :nil?

    uploaded.name.must_equal "CloudLogo.png"
    copied.name.must_equal "CloudLogoCopy.png"
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

  it "should rewrite an existing file, with force_copy_metadata set to true" do
    uploaded = bucket.create_file files[:logo][:path], "CloudLogo.png"
    uploaded.cache_control.must_be :nil?
    uploaded.content_type.must_equal "image/png"

    copied = try_with_backoff "rewriting existing file" do
      uploaded.rewrite "CloudLogoCopy.png", force_copy_metadata: true do |f|
        f.cache_control = "public, max-age: 7200"
      end
    end
    uploaded.cache_control.must_be :nil?
    uploaded.content_type.must_equal "image/png"
    copied.cache_control.must_equal "public, max-age: 7200"
    copied.content_type.must_equal "image/png"

    uploaded.name.must_equal "CloudLogo.png"
    copied.name.must_equal "CloudLogoCopy.png"
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

  it "does not error when getting a file that does not exist" do
    file = bucket.file "this/file/does/not/exist.png"
    file.must_be :nil?
  end

  it "should compose existing files into a new file" do
    uploaded_a = bucket.create_file StringIO.new("a"), "a.txt"
    uploaded_b = bucket.create_file StringIO.new("b"), "b.txt"

    composed = try_with_backoff "copying existing file" do
      bucket.compose [uploaded_a, uploaded_b], "ab.txt"
    end

    composed.name.must_equal "ab.txt"
    composed.size.must_equal uploaded_a.size + uploaded_b.size

    Tempfile.open ["ab", ".txt"] do |tmpfile|
      downloaded = composed.download tmpfile

      File.read(downloaded.path).must_equal "ab"
    end

    uploaded_a.delete
    uploaded_b.delete
    composed.delete
  end

  describe "anonymous project" do
    let(:anonymous_storage) { Google::Cloud::Storage.anonymous }
    it "should list public files without authentication" do
      public_bucket = anonymous_storage.bucket bucket_public_test_name, skip_lookup: true
      files = public_bucket.files

      files.wont_be :empty?
    end

    it "should download a public file without authentication" do
      public_bucket = anonymous_storage.bucket bucket_public_test_name, skip_lookup: true
      file = public_bucket.file file_public_test_gzip_name, skip_lookup: true

      Tempfile.open ["hello_world", ".txt"] do |tmpfile|
        tmpfile.binmode
        downloaded = file.download tmpfile, verify: :none # gzipped file verification bug #1835, does not affect this test

        File.read(downloaded.path, mode: "rb").must_equal "hello world" # decompressed file data
      end
    end

    it "raises when downloading a private file without authentication" do
      skip "Removed due to occasional failures in the CI build."
      original = File.new files[:logo][:path]
      file_name = "CloudLogo.png"
      bucket.create_file original, file_name

      private_bucket = anonymous_storage.bucket bucket_name, skip_lookup: true
      file = private_bucket.file file_name, skip_lookup: true

      Tempfile.open ["hello_world", ".txt"] do |tmpfile|
        tmpfile.binmode
        expect { file.download tmpfile }.must_raise Google::Cloud::UnauthenticatedError
      end
    end

    it "raises when creating a file in a private bucket without authentication" do
      skip "Removed due to occasional failures in the CI build."
      original = File.new files[:logo][:path]
      file_name = "CloudLogo-error.png"

      private_bucket = anonymous_storage.bucket bucket_name, skip_lookup: true
      expect { private_bucket.create_file original, file_name }.must_raise Google::Cloud::UnauthenticatedError
    end
  end
end
