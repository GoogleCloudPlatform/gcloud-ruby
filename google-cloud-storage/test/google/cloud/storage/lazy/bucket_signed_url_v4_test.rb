# Copyright 2019 Google LLC
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

require "helper"

describe Google::Cloud::Storage::Bucket, :signed_url, :v4, :lazy, :mock_storage do
  let(:bucket_name) { "bucket" }
  let(:bucket) { Google::Cloud::Storage::Bucket.new_lazy bucket_name, storage.service }
  
  let(:file_path) { "file.ext" }

  it "uses the credentials' issuer and signing_key to generate signed_url" do
    Time.stub :now, Time.new(2012,1,1,0,0,0, "+00:00") do
      signing_key_mock = Minitest::Mock.new
      signing_key_mock.expect :sign, "native-signature", [OpenSSL::Digest::SHA256, "GOOG4-RSA-SHA256\n20120101T000000Z\n20120101/auto/storage/goog4_request\ndbaaff5efcb05bbb97a173421f9e365b70b6be90d9a2090a71264daabc22f988"]
      credentials.issuer = "native_client_email"
      credentials.signing_key = signing_key_mock

      signed_url = bucket.signed_url file_path, version: :v4

      signed_url_params = CGI::parse(URI(signed_url).query)
      signed_url_params["X-Goog-Algorithm"].must_equal  ["GOOG4-RSA-SHA256"]
      signed_url_params["X-Goog-Credential"].must_equal  ["native_client_email/20120101/auto/storage/goog4_request"]
      signed_url_params["X-Goog-Date"].must_equal  ["20120101T000000Z"]
      signed_url_params["X-Goog-Expires"].must_equal  ["604800"]
      signed_url_params["X-Goog-SignedHeaders"].must_equal  ["host"]
      signed_url_params["X-Goog-Signature"].must_equal  ["6e61746976652d7369676e6174757265"]

      signing_key_mock.verify
    end
  end

  it "allows issuer and signing_key to be passed in as options" do
    Time.stub :now, Time.new(2012,1,1,0,0,0, "+00:00") do
      credentials.issuer = "native_client_email"
      credentials.signing_key = PoisonSigningKey.new

      signing_key_mock = Minitest::Mock.new
      signing_key_mock.expect :sign, "option-signature", [OpenSSL::Digest::SHA256, "GOOG4-RSA-SHA256\n20120101T000000Z\n20120101/auto/storage/goog4_request\nef7980d38d1a4f86ce3e40e92c71ef5e73a4891d69a36e7ef3e7fcf4feb0eb97"]

      signed_url = bucket.signed_url file_path,
                                     issuer: "option_issuer",
                                     signing_key: signing_key_mock, version: :v4

      signed_url_params = CGI::parse(URI(signed_url).query)
      signed_url_params["X-Goog-Algorithm"].must_equal  ["GOOG4-RSA-SHA256"]
      signed_url_params["X-Goog-Credential"].must_equal  ["option_issuer/20120101/auto/storage/goog4_request"]
      signed_url_params["X-Goog-Date"].must_equal  ["20120101T000000Z"]
      signed_url_params["X-Goog-Expires"].must_equal  ["604800"]
      signed_url_params["X-Goog-SignedHeaders"].must_equal  ["host"]
      signed_url_params["X-Goog-Signature"].must_equal  ["6f7074696f6e2d7369676e6174757265"]

      signing_key_mock.verify
    end
  end

  it "allows client_email and private to be passed in as options" do
    Time.stub :now, Time.new(2012,1,1,0,0,0, "+00:00") do
      credentials.issuer = "native_client_email"
      credentials.signing_key = PoisonSigningKey.new

      signing_key_mock = Minitest::Mock.new
      signing_key_mock.expect :sign, "option-signature", [OpenSSL::Digest::SHA256, "GOOG4-RSA-SHA256\n20120101T000000Z\n20120101/auto/storage/goog4_request\na64d70ac9d1dfa8353eebf2424294e26d20f0b540fd71f08ecd221a116b4fe53"]

      OpenSSL::PKey::RSA.stub :new, signing_key_mock do

        signed_url = bucket.signed_url file_path,
                                       client_email: "option_client_email",
                                       private_key: "option_private_key", version: :v4

        signed_url_params = CGI::parse(URI(signed_url).query)
        signed_url_params["X-Goog-Algorithm"].must_equal  ["GOOG4-RSA-SHA256"]
        signed_url_params["X-Goog-Credential"].must_equal  ["option_client_email/20120101/auto/storage/goog4_request"]
        signed_url_params["X-Goog-Date"].must_equal  ["20120101T000000Z"]
        signed_url_params["X-Goog-Expires"].must_equal  ["604800"]
        signed_url_params["X-Goog-SignedHeaders"].must_equal  ["host"]
        signed_url_params["X-Goog-Signature"].must_equal  ["6f7074696f6e2d7369676e6174757265"]

      end

      signing_key_mock.verify
    end
  end

  it "allows headers to be passed in as options" do
    Time.stub :now, Time.new(2012,1,1,0,0,0, "+00:00") do
      signing_key_mock = Minitest::Mock.new
      signing_key_mock.expect :sign, "native-signature", [OpenSSL::Digest::SHA256, "GOOG4-RSA-SHA256\n20120101T000000Z\n20120101/auto/storage/goog4_request\n4b561c5261aeea6e75a6718f8e672827c356b09a272bfe93bd8ab3dcec39906c"]
      credentials.issuer = "native_client_email"
      credentials.signing_key = signing_key_mock

      signed_url = bucket.signed_url file_path,
                                     headers: { "X-Goog-Meta-FOO" => "bar,baz",
                                                "X-Goog-ACL" => "public-read" }, version: :v4

      signed_url_params = CGI::parse(URI(signed_url).query)
      signed_url_params["X-Goog-Algorithm"].must_equal  ["GOOG4-RSA-SHA256"]
      signed_url_params["X-Goog-Credential"].must_equal  ["native_client_email/20120101/auto/storage/goog4_request"]
      signed_url_params["X-Goog-Date"].must_equal  ["20120101T000000Z"]
      signed_url_params["X-Goog-Expires"].must_equal  ["604800"]
      signed_url_params["X-Goog-SignedHeaders"].must_equal  ["host;x-goog-acl;x-goog-meta-foo"]
      signed_url_params["X-Goog-Signature"].must_equal  ["6e61746976652d7369676e6174757265"]

      signing_key_mock.verify
    end
  end

  it "raises when missing issuer" do
    credentials.issuer = nil
    credentials.signing_key = PoisonSigningKey.new

    expect {
      bucket.signed_url file_path, version: :v4
    }.must_raise Google::Cloud::Storage::SignedUrlUnavailable
  end

  it "raises when missing signing_key" do
    credentials.issuer = "native_issuer"
    credentials.signing_key = nil

    expect {
      bucket.signed_url file_path, version: :v4
    }.must_raise Google::Cloud::Storage::SignedUrlUnavailable
  end

  it "allows query params to be passed in" do
    Time.stub :now, Time.new(2012,1,1,0,0,0, "+00:00") do
      signing_key_mock = Minitest::Mock.new
      signing_key_mock.expect :sign, "native-signature", [OpenSSL::Digest::SHA256, "GOOG4-RSA-SHA256\n20120101T000000Z\n20120101/auto/storage/goog4_request\nf2f6b29f677af847b40cd43a5b2b09c171a1c3b0ffd021adf6f15ece0e77e607"]
      credentials.issuer = "native_client_email"
      credentials.signing_key = signing_key_mock

      signed_url = bucket.signed_url file_path,
                                     query: { "response-content-disposition" => "attachment; filename=\"google-cloud.png\"" }, version: :v4

      signed_url_params = CGI::parse(URI(signed_url).query)
      signed_url_params["X-Goog-Algorithm"].must_equal  ["GOOG4-RSA-SHA256"]
      signed_url_params["X-Goog-Credential"].must_equal  ["native_client_email/20120101/auto/storage/goog4_request"]
      signed_url_params["X-Goog-Date"].must_equal  ["20120101T000000Z"]
      signed_url_params["X-Goog-Expires"].must_equal  ["604800"]
      signed_url_params["X-Goog-SignedHeaders"].must_equal  ["host"]
      signed_url_params["X-Goog-Signature"].must_equal  ["6e61746976652d7369676e6174757265"]
      signing_key_mock.verify
    end
  end

  it "allows query params to be passed in as symbols" do
    Time.stub :now, Time.new(2012,1,1,0,0,0, "+00:00") do
      signing_key_mock = Minitest::Mock.new
      signing_key_mock.expect :sign, "native-signature", [OpenSSL::Digest::SHA256, "GOOG4-RSA-SHA256\n20120101T000000Z\n20120101/auto/storage/goog4_request\nade7c049b7cddfac8f7a4509c85f8012913b300e9afe5ab498eeb77fae7e5c70"]
      credentials.issuer = "native_client_email"
      credentials.signing_key = signing_key_mock

      signed_url = bucket.signed_url file_path,
                                     query: { disposition: :inline }, version: :v4

      signed_url_params = CGI::parse(URI(signed_url).query)
      signed_url_params["X-Goog-Algorithm"].must_equal  ["GOOG4-RSA-SHA256"]
      signed_url_params["X-Goog-Credential"].must_equal  ["native_client_email/20120101/auto/storage/goog4_request"]
      signed_url_params["X-Goog-Date"].must_equal  ["20120101T000000Z"]
      signed_url_params["X-Goog-Expires"].must_equal  ["604800"]
      signed_url_params["X-Goog-SignedHeaders"].must_equal  ["host"]
      signed_url_params["X-Goog-Signature"].must_equal  ["6e61746976652d7369676e6174757265"]

      signing_key_mock.verify
    end
  end

  class PoisonSigningKey
    def sign kind, sig
      raise "The wrong signing_key was used"
    end
  end
end
