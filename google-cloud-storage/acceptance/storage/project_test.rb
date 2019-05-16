# Copyright 2018 Google LLC
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

describe Google::Cloud::Storage::Project, :storage do
  it "should get its project service account email" do
    email = storage.service_account_email
    email.wont_be :nil?
    email.must_be_kind_of String
    # https://stackoverflow.com/questions/22993545/ruby-email-validation-with-regex
    email.must_match /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  end
  focus
  it "should create a new HMAC key" do
    client_email = "542339357638-cr0dserr2evg7sv1meghqeu703274f3h@developer.gserviceaccount.com"

    hmac_key = storage.create_hmac_key service_account_email: client_email

    hmac_key.wont_be :nil?
    hmac_key.must_be_kind_of Google::Cloud::Storage::HmacKey

    hmac_key.secret.must_be_kind_of String
    hmac_key.secret.length.must_equal 40

    hmac_key.access_id.must_be_kind_of String
    hmac_key.etag.must_be_kind_of String
    hmac_key.id.must_be_kind_of String
    hmac_key.created_at.must_be_kind_of DateTime
    hmac_key.updated_at.must_be_kind_of DateTime

    hmac_key.service_account_email.must_equal client_email
    hmac_key.state.must_equal "ACTIVE"
    hmac_key.must_be :active?

    hmac_keys = storage.hmac_keys
    hmac_keys.wont_be :empty?

    hmac_key_list_item = hmac_keys.find { |k| k.access_id == hmac_key.access_id }
    hmac_key_list_item.wont_be :nil?
    #hmac_key_list_item.etag.must_equal hmac_key.etag   unreliable!
    #
    # hmac_key_list_item.inactive!
    # hmac_key_list_item.state.must_equal "INACTIVE"
    # hmac_key_list_item.must_be :inactive?

    hmac_key.reload!
    hmac_key.inactive!
    hmac_key.state.must_equal "INACTIVE"
    hmac_key.must_be :inactive?

    hmac_key.delete!
    hmac_key.state.must_equal "DELETED"
    hmac_key.must_be :deleted?

    hmac_key = storage.hmac_key hmac_key.access_id # similar to reload! above
    hmac_key.state.must_equal "DELETED"
    hmac_key.must_be :deleted?
  end
end
