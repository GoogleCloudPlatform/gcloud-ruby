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

require "storage_helper"

describe Google::Cloud::Storage::Bucket, :uniform_bucket_level_access, :storage do
  let(:bucket_name) { $bucket_names.first }
  let :bucket do
    storage.bucket(bucket_name) ||
    safe_gcs_execute { storage.create_bucket(bucket_name) }
  end

  let(:files) do
    { logo: { path: "acceptance/data/CloudPlatform_128px_Retina.png" },
      big:  { path: "acceptance/data/three-mb-file.tif" } }
  end
  let(:local_file) { File.new files[:logo][:path] }

  let(:user_val) { "user-blowmage@gmail.com" }

  after do
    # always reset the uniform_bucket_level_access and public_access_prevention
    # always reset the bucket permissions
    bucket.uniform_bucket_level_access = false if bucket.uniform_bucket_level_access?
    bucket.public_access_prevention = nil if bucket.public_access_prevention_enforced?
    bucket.default_acl.private!
    bucket.files.all { |f| f.delete rescue nil }
  end

  it "sets uniform_bucket_level_access true and is unable to modify file ACL rules" do
    refute bucket.uniform_bucket_level_access?
    _(bucket.uniform_bucket_level_access_locked_at).must_be :nil?
    file = bucket.create_file local_file, "ReaderTest.png"

    bucket.uniform_bucket_level_access = true
    assert bucket.uniform_bucket_level_access?
    _(bucket.uniform_bucket_level_access_locked_at).must_be_kind_of DateTime

    err = expect do
      file.acl.add_reader user_val
    end.must_raise Google::Cloud::PermissionDeniedError
    _(err.message).must_match /does not have storage.objects.get access to/
  end

  it "sets uniform_bucket_level_access true and is unable to get the file" do
    refute bucket.uniform_bucket_level_access?
    file = bucket.create_file local_file, "ReaderTest.png"

    bucket.uniform_bucket_level_access = true
    assert bucket.uniform_bucket_level_access?
    err = expect do
      file.reload!
    end.must_raise Google::Cloud::PermissionDeniedError
    _(err.message).must_match /does not have storage.objects.get access to/

    bucket.uniform_bucket_level_access = false
    file.reload!
  end

  it "sets uniform_bucket_level_access true and is unable to modify bucket ACL rules" do
    refute bucket.uniform_bucket_level_access?
    bucket.uniform_bucket_level_access = true
    assert bucket.uniform_bucket_level_access?
    err = expect do
      bucket.acl.public!
    end.must_raise Google::Cloud::InvalidArgumentError
  end

  it "sets uniform_bucket_level_access true and is unable to modify default ACL rules" do
    refute bucket.uniform_bucket_level_access?
    bucket.uniform_bucket_level_access = true
    assert bucket.uniform_bucket_level_access?

    err = expect do
      bucket.default_acl.public!
    end.must_raise Google::Cloud::InvalidArgumentError
  end

  it "creates new bucket with uniform_bucket_level_access true and is able to insert and get a file" do
    bucket_ubla = storage.create_bucket "#{$bucket_names[2]}-bpo" do |b|
      b.uniform_bucket_level_access = true
    end
    assert bucket_ubla.uniform_bucket_level_access?
    file = bucket_ubla.create_file StringIO.new("uniform_bucket_level_access"), "uniform_bucket_level_access.txt"
    file.reload!

    # after
    file.delete
    safe_gcs_execute { bucket_ubla.delete }
  end

  it "sets uniform_bucket_level_access true and default object acl and object acls are preserved" do
    bucket.default_acl.public!
    _(bucket.default_acl.readers).must_equal ["allUsers"]
    file_default_acl = bucket.create_file StringIO.new("default_acl"), "default_acl.txt"
    _(file_default_acl.acl.readers).must_equal ["allUsers"]
    refute bucket.uniform_bucket_level_access?

    bucket.uniform_bucket_level_access = true
    assert bucket.uniform_bucket_level_access?
    _(bucket.uniform_bucket_level_access_locked_at).must_be_kind_of DateTime
    bucket.uniform_bucket_level_access = false

    refute bucket.uniform_bucket_level_access?
    _(bucket.uniform_bucket_level_access_locked_at).must_be :nil?

    file_default_acl.reload!
    _(file_default_acl.acl.readers).must_equal ["allUsers"]
  end

  it "sets DEPRECATED policy_only true and is unable to modify file ACL rules" do
    refute bucket.policy_only?
    _(bucket.policy_only_locked_at).must_be :nil?
    file = bucket.create_file local_file, "ReaderTest.png"

    bucket.policy_only = true
    assert bucket.policy_only?
    _(bucket.policy_only_locked_at).must_be_kind_of DateTime

    err = expect do
      file.acl.add_reader user_val
    end.must_raise Google::Cloud::PermissionDeniedError
    _(err.message).must_match /does not have storage.objects.get access to/
  end

  it "sets DEPRECATED policy_only true and is unable to get the file" do
    refute bucket.policy_only?
    file = bucket.create_file local_file, "ReaderTest.png"

    bucket.policy_only = true
    assert bucket.policy_only?
    err = expect do
      file.reload!
    end.must_raise Google::Cloud::PermissionDeniedError
    _(err.message).must_match /does not have storage.objects.get access to/

    bucket.policy_only = false
    file.reload!
  end

  it "sets DEPRECATED policy_only true and is unable to modify bucket ACL rules" do
    refute bucket.policy_only?
    bucket.policy_only = true
    assert bucket.policy_only?
    err = expect do
      bucket.acl.public!
    end.must_raise Google::Cloud::InvalidArgumentError
  end

  it "sets DEPRECATED policy_only true and is unable to modify default ACL rules" do
    refute bucket.policy_only?
    bucket.policy_only = true
    assert bucket.policy_only?

    err = expect do
      bucket.default_acl.public!
    end.must_raise Google::Cloud::InvalidArgumentError
  end

  it "creates new bucket with DEPRECATED policy_only true and is able to insert and get a file" do
    bucket_policy_only = storage.create_bucket "#{$bucket_names[2]}-bpo" do |b|
      b.policy_only = true
    end
    assert bucket_policy_only.policy_only?
    file = bucket_policy_only.create_file StringIO.new("policy_only"), "policy_only.txt"
    file.reload!

    # after
    file.delete
    safe_gcs_execute { bucket_policy_only.delete }
  end

  it "sets DEPRECATED policy_only true and default object acl and object acls are preserved" do
    bucket.default_acl.public!
    _(bucket.default_acl.readers).must_equal ["allUsers"]
    file_default_acl = bucket.create_file StringIO.new("default_acl"), "default_acl.txt"
    _(file_default_acl.acl.readers).must_equal ["allUsers"]
    refute bucket.policy_only?

    bucket.policy_only = true
    assert bucket.policy_only?
    _(bucket.policy_only_locked_at).must_be_kind_of DateTime
    bucket.policy_only = false

    refute bucket.policy_only?
    _(bucket.policy_only_locked_at).must_be :nil?

    file_default_acl.reload!
    _(file_default_acl.acl.readers).must_equal ["allUsers"]
  end
focus
  it "sets public_access_prevention to enforced and is unable to modify bucket ACL rules" do
    refute bucket.public_access_prevention_enforced?
    bucket.uniform_bucket_level_access = "enforced"
    assert bucket.public_access_prevention_enforced?
    err = expect do
      bucket.acl.public!
    end.must_raise Google::Cloud::InvalidArgumentError
  end
focus
  it "sets enforced public_access_prevention to nil and is able to modify bucket ACL rules" do
    refute bucket.public_access_prevention_enforced?
    bucket.uniform_bucket_level_access = "enforced"
    assert bucket.public_access_prevention_enforced?
    bucket.uniform_bucket_level_access = nil
    refute bucket.public_access_prevention_enforced?
    bucket.acl.public!
  end
end
