# Copyright 2017 Google LLC
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

describe Google::Cloud::Spanner::Snapshot, :execute_query, :mock_spanner do
  let(:instance_id) { "my-instance-id" }
  let(:database_id) { "my-database-id" }
  let(:session_id) { "session123" }
  let(:session_grpc) { Google::Spanner::V1::Session.new name: session_path(instance_id, database_id, session_id) }
  let(:session) { Google::Cloud::Spanner::Session.from_grpc session_grpc, spanner.service }
  let(:transaction_id) { "tx789" }
  let(:transaction_grpc) { Google::Spanner::V1::Transaction.new id: transaction_id }
  let(:snapshot) { Google::Cloud::Spanner::Snapshot.from_grpc transaction_grpc, session }
  let(:tx_selector) { Google::Spanner::V1::TransactionSelector.new id: transaction_id }
  let(:default_options) { Google::Gax::CallOptions.new kwargs: { "google-cloud-resource-prefix" => database_path(instance_id, database_id) } }
  let :results_hash do
    {
      metadata: {
        row_type: {
          fields: [
            { name: "id",          type: { code: :INT64 } },
            { name: "name",        type: { code: :STRING } },
            { name: "active",      type: { code: :BOOL } },
            { name: "age",         type: { code: :INT64 } },
            { name: "score",       type: { code: :FLOAT64 } },
            { name: "updated_at",  type: { code: :TIMESTAMP } },
            { name: "birthday",    type: { code: :DATE} },
            { name: "avatar",      type: { code: :BYTES } },
            { name: "project_ids", type: { code: :ARRAY,
                                           array_element_type: { code: :INT64 } } }
          ]
        }
      },
      values: [
        { string_value: "1" },
        { string_value: "Charlie" },
        { bool_value: true},
        { string_value: "29" },
        { number_value: 0.9 },
        { string_value: "2017-01-02T03:04:05.060000000Z" },
        { string_value: "1950-01-01" },
        { string_value: "aW1hZ2U=" },
        { list_value: { values: [ { string_value: "1"},
                                 { string_value: "2"},
                                 { string_value: "3"} ]}}
      ]
    }
  end
  let(:results_grpc) { Google::Spanner::V1::PartialResultSet.new results_hash }
  let(:results_enum) { Array(results_grpc).to_enum }

  it "can execute a simple query" do
    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session.path, "SELECT * FROM users", transaction: tx_selector, options: default_options

    results = snapshot.execute_query "SELECT * FROM users"

    mock.verify

    assert_results results
  end

  it "can execute a query with bool param" do
    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session.path, "SELECT * FROM users WHERE active = @active", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "active" => Google::Protobuf::Value.new(bool_value: true) }), param_types: { "active" => Google::Spanner::V1::Type.new(code: :BOOL) }, options: default_options

    results = snapshot.execute_query "SELECT * FROM users WHERE active = @active", params: { active: true }

    mock.verify

    assert_results results
  end

  it "can execute a query with int param" do
    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session.path, "SELECT * FROM users WHERE age = @age", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "age" => Google::Protobuf::Value.new(string_value: "29") }), param_types: { "age" => Google::Spanner::V1::Type.new(code: :INT64) }, options: default_options

    results = snapshot.execute_query "SELECT * FROM users WHERE age = @age", params: { age: 29 }

    mock.verify

    assert_results results
  end

  it "can execute a query with float param" do
    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session.path, "SELECT * FROM users WHERE score = @score", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "score" => Google::Protobuf::Value.new(number_value: 0.9) }), param_types: { "score" => Google::Spanner::V1::Type.new(code: :FLOAT64) }, options: default_options

    results = snapshot.execute_query "SELECT * FROM users WHERE score = @score", params: { score: 0.9 }

    mock.verify

    assert_results results
  end

  it "can execute a query with Time param" do
    timestamp = Time.parse "2017-01-01 20:04:05.06 -0700"

    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session.path, "SELECT * FROM users WHERE updated_at = @updated_at", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "updated_at" => Google::Protobuf::Value.new(string_value: "2017-01-02T03:04:05.060000000Z") }), param_types: { "updated_at" => Google::Spanner::V1::Type.new(code: :TIMESTAMP) }, options: default_options

    results = snapshot.execute_query "SELECT * FROM users WHERE updated_at = @updated_at", params: { updated_at: timestamp }

    mock.verify

    assert_results results
  end

  it "can execute a query with Date param" do
    date = Date.parse "2017-01-02"

    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session.path, "SELECT * FROM users WHERE birthday = @birthday", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "birthday" => Google::Protobuf::Value.new(string_value: "2017-01-02") }), param_types: { "birthday" => Google::Spanner::V1::Type.new(code: :DATE) }, options: default_options

    results = snapshot.execute_query "SELECT * FROM users WHERE birthday = @birthday", params: { birthday: date }

    mock.verify

    assert_results results
  end

  it "can execute a query with String param" do
    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session.path, "SELECT * FROM users WHERE name = @name", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "name" => Google::Protobuf::Value.new(string_value: "Charlie") }), param_types: { "name" => Google::Spanner::V1::Type.new(code: :STRING) }, options: default_options

    results = snapshot.execute_query "SELECT * FROM users WHERE name = @name", params: { name: "Charlie" }

    mock.verify

    assert_results results
  end

  it "can execute a query with IO-ish param" do
    file = StringIO.new "contents"

    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session.path, "SELECT * FROM users WHERE avatar = @avatar", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "avatar" => Google::Protobuf::Value.new(string_value: Base64.strict_encode64("contents")) }), param_types: { "avatar" => Google::Spanner::V1::Type.new(code: :BYTES) }, options: default_options

    results = snapshot.execute_query "SELECT * FROM users WHERE avatar = @avatar", params: { avatar: file }

    mock.verify

    assert_results results
  end

  it "can execute a query with an Array param" do
    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session.path, "SELECT * FROM users WHERE project_ids = @list", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "list" => Google::Protobuf::Value.new(list_value: Google::Protobuf::ListValue.new(values: [Google::Protobuf::Value.new(string_value: "1"), Google::Protobuf::Value.new(string_value: "2"), Google::Protobuf::Value.new(string_value: "3")])) }), param_types: { "list" => Google::Spanner::V1::Type.new(code: :ARRAY, array_element_type: Google::Spanner::V1::Type.new(code: :INT64)) }, options: default_options

    results = snapshot.execute_query "SELECT * FROM users WHERE project_ids = @list", params: { list: [1,2,3] }

    mock.verify

    assert_results results
  end

  it "can execute a query with an empty Array param" do
    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session.path, "SELECT * FROM users WHERE project_ids = @list", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "list" => Google::Protobuf::Value.new(list_value: Google::Protobuf::ListValue.new(values: [])) }), param_types: { "list" => Google::Spanner::V1::Type.new(code: :ARRAY, array_element_type: Google::Spanner::V1::Type.new(code: :INT64)) }, options: default_options

    results = snapshot.execute_query "SELECT * FROM users WHERE project_ids = @list", params: { list: [] }, types: { list: [:INT64] }

    mock.verify

    assert_results results
  end

  it "can execute a query with a simple Hash param" do
    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session.path, "SELECT * FROM users WHERE settings = @dict", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "dict" => Google::Protobuf::Value.new(list_value: Google::Protobuf::ListValue.new(values: [Google::Protobuf::Value.new(string_value: "production")])) }), param_types: { "dict" => Google::Spanner::V1::Type.new(code: :STRUCT, struct_type: Google::Spanner::V1::StructType.new(fields: [Google::Spanner::V1::StructType::Field.new(name: "env", type: Google::Spanner::V1::Type.new(code: :STRING))])) }, options: default_options

    results = snapshot.execute_query "SELECT * FROM users WHERE settings = @dict", params: { dict: { env: :production } }

    mock.verify

    assert_results results
  end

  it "can execute a query with a complex Hash param" do
    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session.path, "SELECT * FROM users WHERE settings = @dict", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "dict" => Google::Protobuf::Value.new(list_value: Google::Protobuf::ListValue.new(values: [Google::Protobuf::Value.new(string_value: "production"), Google::Protobuf::Value.new(number_value: 0.9), Google::Protobuf::Value.new(list_value: Google::Protobuf::ListValue.new(values: [Google::Protobuf::Value.new(string_value: "1"), Google::Protobuf::Value.new(string_value: "2"), Google::Protobuf::Value.new(string_value: "3")] )) ])) }), param_types: { "dict" => Google::Spanner::V1::Type.new(code: :STRUCT, struct_type: Google::Spanner::V1::StructType.new(fields: [Google::Spanner::V1::StructType::Field.new(name: "env", type: Google::Spanner::V1::Type.new(code: :STRING)), Google::Spanner::V1::StructType::Field.new(name: "score", type: Google::Spanner::V1::Type.new(code: :FLOAT64)), Google::Spanner::V1::StructType::Field.new(name: "project_ids", type: Google::Spanner::V1::Type.new(code: :ARRAY, array_element_type: Google::Spanner::V1::Type.new(code: :INT64)))] )) }, options: default_options

    results = snapshot.execute_query "SELECT * FROM users WHERE settings = @dict", params: { dict: { env: "production", score: 0.9, project_ids: [1,2,3] } }

    mock.verify

    assert_results results
  end

  it "can execute a query with an Array of Hashes" do
    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session_grpc.name, "SELECT * FROM users WHERE STRUCT<name STRING, email STRING>(name, email) IN UNNEST(@data)", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "data" => Google::Protobuf::Value.new(list_value: Google::Protobuf::ListValue.new(values: [Google::Protobuf::Value.new(list_value: Google::Protobuf::ListValue.new(values: [Google::Protobuf::Value.new(string_value: "mike"), Google::Protobuf::Value.new(string_value: "mike@example.net")] )), Google::Protobuf::Value.new(list_value: Google::Protobuf::ListValue.new(values: [Google::Protobuf::Value.new(string_value: "chris"), Google::Protobuf::Value.new(string_value: "chris@example.net")] ))] )) } ), param_types: { "data" => Google::Spanner::V1::Type.new(code: :ARRAY, array_element_type: Google::Spanner::V1::Type.new(code: :STRUCT, struct_type: Google::Spanner::V1::StructType.new(fields: [ Google::Spanner::V1::StructType::Field.new(name: "name", type: Google::Spanner::V1::Type.new(code: :STRING)), Google::Spanner::V1::StructType::Field.new(name: "email", type: Google::Spanner::V1::Type.new(code: :STRING))] ))) }, options: default_options

    results = snapshot.execute "SELECT * FROM users WHERE STRUCT<name STRING, email STRING>(name, email) IN UNNEST(@data)", params: { data: [{ name: "mike", email: "mike@example.net" }, { name: "chris", email: "chris@example.net" }] }

    mock.verify

    assert_results results
  end

  it "can execute a query with an Array of STRUCTs" do
    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session_grpc.name, "SELECT * FROM users WHERE STRUCT<name STRING, email STRING>(name, email) IN UNNEST(@data)", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "data" => Google::Protobuf::Value.new(list_value: Google::Protobuf::ListValue.new(values: [Google::Protobuf::Value.new(list_value: Google::Protobuf::ListValue.new(values: [Google::Protobuf::Value.new(string_value: "mike"), Google::Protobuf::Value.new(string_value: "mike@example.net")] )), Google::Protobuf::Value.new(list_value: Google::Protobuf::ListValue.new(values: [Google::Protobuf::Value.new(string_value: "chris"), Google::Protobuf::Value.new(string_value: "chris@example.net")] ))] )) } ), param_types: { "data" => Google::Spanner::V1::Type.new(code: :ARRAY, array_element_type: Google::Spanner::V1::Type.new(code: :STRUCT, struct_type: Google::Spanner::V1::StructType.new(fields: [ Google::Spanner::V1::StructType::Field.new(name: "name", type: Google::Spanner::V1::Type.new(code: :STRING)), Google::Spanner::V1::StructType::Field.new(name: "email", type: Google::Spanner::V1::Type.new(code: :STRING))] ))) }, options: default_options

    struct_fields = snapshot.fields name: :STRING, email: :STRING
    results = snapshot.execute "SELECT * FROM users WHERE STRUCT<name STRING, email STRING>(name, email) IN UNNEST(@data)", params: { data: [struct_fields.data(["mike", "mike@example.net"]), struct_fields.data(["chris","chris@example.net"])] }

    mock.verify

    assert_results results
  end

  it "can execute a query with an empty Hash param" do
    mock = Minitest::Mock.new
    session.service.mocked_service = mock
    expect_execute_streaming_sql results_enum, session.path, "SELECT * FROM users WHERE settings = @dict", transaction: tx_selector, params: Google::Protobuf::Struct.new(fields: { "dict" => Google::Protobuf::Value.new(list_value: Google::Protobuf::ListValue.new(values: [])) }), param_types: { "dict" => Google::Spanner::V1::Type.new(code: :STRUCT, struct_type: Google::Spanner::V1::StructType.new(fields: [])) }, options: default_options

    results = snapshot.execute_query "SELECT * FROM users WHERE settings = @dict", params: { dict: { } }

    mock.verify

    assert_results results
  end

  def assert_results results
    results.must_be_kind_of Google::Cloud::Spanner::Results

    results.fields.wont_be :nil?
    results.fields.must_be_kind_of Google::Cloud::Spanner::Fields
    results.fields.keys.count.must_equal 9
    results.fields[:id].must_equal          :INT64
    results.fields[:name].must_equal        :STRING
    results.fields[:active].must_equal      :BOOL
    results.fields[:age].must_equal         :INT64
    results.fields[:score].must_equal       :FLOAT64
    results.fields[:updated_at].must_equal  :TIMESTAMP
    results.fields[:birthday].must_equal    :DATE
    results.fields[:avatar].must_equal      :BYTES
    results.fields[:project_ids].must_equal [:INT64]

    rows = results.rows.to_a # grab them all from the enumerator
    rows.count.must_equal 1
    row = rows.first
    row.must_be_kind_of Google::Cloud::Spanner::Data
    row.keys.must_equal [:id, :name, :active, :age, :score, :updated_at, :birthday, :avatar, :project_ids]
    row[:id].must_equal 1
    row[:name].must_equal "Charlie"
    row[:active].must_equal true
    row[:age].must_equal 29
    row[:score].must_equal 0.9
    row[:updated_at].must_equal Time.parse("2017-01-02T03:04:05.060000000Z")
    row[:birthday].must_equal Date.parse("1950-01-01")
    row[:avatar].must_be_kind_of StringIO
    row[:avatar].read.must_equal "image"
    row[:project_ids].must_equal [1, 2, 3]
  end
end
