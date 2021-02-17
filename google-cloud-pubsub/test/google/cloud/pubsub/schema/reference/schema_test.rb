# Copyright 2021 Google LLC
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

describe Google::Cloud::PubSub::Schema, :reference, :mock_pubsub do
  let(:schema_id) { "my-schema" }
  let(:schema) { Google::Cloud::PubSub::Schema.from_name schema_id, :BASIC, pubsub.service }

  it "knows its attributes" do
    _(schema.name).must_equal schema_path(schema_id)
    _(schema.type).must_be :nil?
    _(schema.definition).must_be :nil?
  end

  it "knows its view state" do
    _(schema).must_be :reference?
    _(schema).wont_be :resource?
    _(schema).wont_be :resource_partial?
    _(schema.resource_full?).must_equal false
  end

  it "deletes itself" do
    mock = Minitest::Mock.new
    mock.expect :delete_schema, nil, [name: schema_path(schema_id)]
    pubsub.service.mocked_schemas = mock

    schema.delete

    mock.verify
  end

  it "reloads itself" do
    get_res = Google::Cloud::PubSub::V1::Schema.new schema_hash(schema_id, definition: nil)
    mock = Minitest::Mock.new
    mock.expect :get_schema, get_res, [name: schema_path(schema_id), view: 1]
    pubsub.service.mocked_schemas = mock

    schema.reload!

    _(schema).wont_be :reference?
    _(schema).must_be :resource?
    _(schema.resource_partial?).must_equal true
    _(schema.resource_full?).must_equal false

    mock.verify
  end

  it "reloads itself with view option" do
    get_res = Google::Cloud::PubSub::V1::Schema.new schema_hash(schema_id)
    mock = Minitest::Mock.new
    mock.expect :get_schema, get_res, [name: schema_path(schema_id), view: 2]
    pubsub.service.mocked_schemas = mock

    schema.reload! view: :full

    _(schema).wont_be :reference?
    _(schema).must_be :resource?
    _(schema).wont_be :resource_partial?
    _(schema).must_be :resource_full?

    mock.verify
  end

  it "checks if it exists without making RPC" do
    get_res = Google::Cloud::PubSub::V1::Schema.new schema_hash(schema_id, definition: nil)
    mock = Minitest::Mock.new
    mock.expect :get_schema, get_res, [name: schema_path(schema_id), view: 1]
    pubsub.service.mocked_schemas = mock

    _(schema.exists?).must_equal true

    _(schema).wont_be :reference?
    _(schema).must_be :resource?
    _(schema.resource_partial?).must_equal true
    _(schema.resource_full?).must_equal false

    mock.verify
  end
end
